from pynq import MMIO
from pynq import Bitstream
import cffi
from . import general_const

class FGPU:
    def __init__(self):
        self.bitfile = general_const.BITFILE
        self.param1_ptr = -1
        self.target_ptr = -1
        self.param1_u32ptr = -1
        self.target_u32ptr = -1
        self.mem_size = -1
        #initialize MMIO object
        self.base_addr = 0x43C00000
        self.addr_space = 0x10000
        self.status_reg_offset = 0x8000
        self.start_reg_offset = 0x8004
        self.clean_cache_reg_offset = 0x8008
        self.initiate_reg_offset = 0x800C
        self.mmio = MMIO(self.base_addr, self.addr_space)
        #initialize kernel descriptor
        self.kdesc = {
            #basic parameters
            'size0' : 0,
            'size1' : 0,
            'size2' : 0,
            'offset0' : 0,
            'offset1' : 0,
            'offset2' : 0,
            'wg_size0' : 0,
            'wg_size1' : 0,
            'wg_size2' : 0,
            'nParams' : 0,
            'nDim' : 0,
            #calculated parameters
            'size' : 0,
            'n_wg0' : 0,
            'n_wg1' : 0,
            'n_wg2' : 0,
            'wg_size' : 0,
            'nWF_WG' : 0,
            'start_addr' : 0,
            #extra info
            'problemSize' : 0,
            'dataSize' : 0,
            'param1' : 0,
            'target' : 0
        }
        #initialize copy kernel code
        self.kernel_code = [
            0xa8000022,
            0xa8000003,
            0xa0000004,
            0xa1000005,
            0x100010a1,
            0x74000c23,
            0x7c000823,
            0x92000000,
            0xa8000022,
            0xa8000003,
            0xa0000004,
            0xa1000005,
            0x100010a1,
            0x21000424,
            0x10001064,
            0x72000c23,
            0x35007884,
            0x21000c84,
            0x20001063,
            0x29004063,
            0x7a000823,
            0x92000000,
            0xa8000022,
            0xa8000003,
            0xa0000004,
            0xa1000005,
            0x100010a1,
            0x74000c23,
            0x7c000823,
            0x92000000,
            0xa8000022,
            0xa8000003,
            0xa0000004,
            0xa1000005,
            0x100010a1,
            0x10000463,
            0x74000c04,
            0x35007c63,
            0x21000c63,
            0x20000c83,
            0x29006063,
            0x79000823,
            0x92000000,
            0xa8000022,
            0xa8000003,
            0xa0000004,
            0xa1000005,
            0x100010a1,
            0x74000c23,
            0x7c000823,
            0x92000000
        ]

    def set_fclk0(self):
        self._SCLR_BASE = 0xf8000000
        self._FCLK0_OFFSET = 0x170
        addr = self._SCLR_BASE + self._FCLK0_OFFSET
        FPGA0_CLK_CTRL = MMIO(addr).read()
        if FPGA0_CLK_CTRL != 0x300a00:
            #divider 0
            shift = 20
            mask = 0xF00000
            value = 0x3
            self._set_regfield_value(addr, shift, mask, value)
            #divider 1
            shift = 8
            mask = 0xF00
            value = 0xa
            self._set_regfield_value(addr, shift, mask, value)
            print("FCLK0 is set.")
        else:
            print("FCLK0 was already set.")

    def _set_regfield_value(self, addr, shift, mask, value):
        curval = MMIO(addr).read()
        MMIO(addr).write(0, ((curval & ~mask) | (value << shift)))

    def download_bitstream(self):
        Bitstream(self.bitfile).download()

    def download_kernel_code(self):
        #kernel code memory offset
        kc_offset = 0x4000
        #copy instructions into sequential memory
        for i_offset, instruction in enumerate(self.kernel_code):
            self.mmio.write(kc_offset+i_offset*4, instruction)

    def prepare_kernel_descriptor(self, size_index):
        self.kdesc['wg_size0'] = 64
        self.kdesc['size0'] = self.kdesc['wg_size0'] << size_index
        self.kdesc['problemSize'] = self.kdesc['size0']
        self.kdesc['offset0'] = 0
        self.kdesc['nDim'] = 1
        self.kdesc['wg_size'] = self.kdesc['wg_size0']
        self.kdesc['nWF_WG'] = self.kdesc['wg_size'] // 64
        if self.kdesc['wg_size'] % 64 != 0:
            self.kdesc['nWF_WG'] = self.kdesc['nWF_WG'] + 1
        self.kdesc['size'] = self.kdesc['size0']
        self.kdesc['n_wg0'] = self.kdesc['size0'] // self.kdesc['wg_size0']
        if self.kdesc['nDim'] > 1:
            self.kdesc['size'] = self.kdesc['size0'] * self.kdesc['size1']
            self.kdesc['wg_size'] = self.kdesc['wg_size0'] * self.kdesc['wg_size1']
            self.kdesc['n_wg1'] = self.kdesc['size1'] / self.kdesc['wg_size1']
        else:
            self.kdesc['wg_size1'] = 0
            self.kdesc['n_wg1'] = 1
            self.kdesc['size1'] = 0
        if self.kdesc['nDim'] > 2:
            self.kdesc['size'] = self.kdesc['size0'] * \
                                 self.kdesc['size1'] * \
                                 self.kdesc['size2']
            self.kdesc['wg_size'] = self.kdesc['wg_size0'] * \
                                    self.kdesc['wg_size1'] * \
                                    self.kdesc['wg_size2']
            self.kdesc['n_wg2'] = self.kdesc['size2'] / self.kdesc['wg_size2']
        else:
            self.kdesc['wg_size2'] = 0
            self.kdesc['n_wg2'] = 1
            self.kdesc['size2'] = 0

        self.kdesc['dataSize'] = 4 * self.kdesc['problemSize']
        self.kdesc['offset0'] = 0
        self.kdesc['offset1'] = 0
        self.kdesc['offset2'] = 0
        self.kdesc['nParams'] = 2

    def download_kernel_descriptor(self):
        for offset in range(0, 31):
            self.mmio.write(offset*4, 0)
        self.mmio.write(0, ((self.kdesc['nWF_WG']-1)<<28 |
                            0<<14 |
                            self.kdesc['start_addr'])
                       )
        self.mmio.write(1*4, self.kdesc['size0'])
        self.mmio.write(2*4, self.kdesc['size1'])
        self.mmio.write(3*4, self.kdesc['size2'])
        self.mmio.write(4*4, self.kdesc['offset0'])
        self.mmio.write(5*4, self.kdesc['offset1'])
        self.mmio.write(6*4, self.kdesc['offset2'])
        self.mmio.write(7*4, ((self.kdesc['nDim']-1)<<30 |
                              self.kdesc['wg_size2']<<20 |
                              self.kdesc['wg_size1']<<10 |
                              self.kdesc['wg_size0'])
                       )
        self.mmio.write(8*4, self.kdesc['n_wg0']-1)
        self.mmio.write(9*4, self.kdesc['n_wg1']-1)
        self.mmio.write(10*4, self.kdesc['n_wg2']-1)
        self.mmio.write(11*4, (self.kdesc['nParams']<<28 |
                               self.kdesc['wg_size'])
                       )
        self.mmio.write(16*4, self.kdesc['param1'])
        self.mmio.write(17*4, self.kdesc['target'])

    def allocate_memory(self, mem_size=64*1024):
        if mem_size > 0:
            self.mem_size = mem_size
        ffi = cffi.FFI()
        ffi.cdef("uint32_t cma_get_phy_addr(void *buf);")
        ffi.cdef("void *cma_alloc(uint32_t len, uint32_t cacheable);")
        ffi.cdef("void cma_free(void *buf);")
        ffi.cdef("uint32_t cma_pages_available();")
        libsds = ffi.dlopen('/usr/lib/libsds_lib.so')
        self.param1_ptr = libsds.cma_alloc(self.mem_size, 0)
        self.target_ptr = libsds.cma_alloc(self.mem_size, 0)
        self.kdesc['param1'] = libsds.cma_get_phy_addr(self.param1_ptr)
        self.kdesc['target'] = libsds.cma_get_phy_addr(self.target_ptr)
        self.param1_u32ptr = ffi.cast("uint32_t *", self.param1_ptr)
        self.target_u32ptr = ffi.cast("uint32_t *", self.target_ptr)

    def initialize_memory(self, value=-1):
        for i in range(0, self.mem_size // 4):
            if value < 0:
                self.param1_u32ptr[i] = i
            else:
                self.param1_u32ptr[i] = value
            self.target_u32ptr[i] = 0

    def compute_on_FGPU(self, n_runs=1):
        self.download_kernel_code()
        self.prepare_kernel_descriptor(0)
        for i in range(n_runs):
            print("Run #"+str(i))
            self.allocate_memory()
            self.initialize_memory()
            self.download_kernel_descriptor()
            self.mmio.write(self.initiate_reg_offset, 0xFFFF)
            self.mmio.write(self.clean_cache_reg_offset, 0xFFFF)
            self.mmio.write(self.start_reg_offset, 0x1)
            while self.mmio.read(self.status_reg_offset) == 0:
                pass
