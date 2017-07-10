# This function creates a block diagram of an FGPU connected to the four AXI HP ports of the PS on Zynq.
# Paramters:
#   bd_name   : name of the block diagram to be generated   
#   FGPU_ver  : version of the FGPU IP-core (generated with Xilinx IP-core generator)
#   FREQ      : the clock frequency of FGPU


# The created block design can be found in  HW/.srcs/sources_1/bd/bd_design/


proc create_FGPU_block_design { bd_name FGPU_ver FREQ} {
  global ipDir

  create_bd_design $bd_name
  set_property target_language VHDL [current_project]
  set_property  ip_repo_paths  $ipDir [current_project]
  update_ip_catalog

  create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0

  create_bd_cell -type ip -vlnv user.org:user:FGPU:$FGPU_ver FGPU_0

  create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:5.3 clk_wiz_0

  set_property -dict [list \
    CONFIG.USE_PHASE_ALIGNMENT {false} \
    CONFIG.CLKOUT1_REQUESTED_OUT_FREQ  $FREQ\.000 \
    CONFIG.USE_LOCKED {false} \
    CONFIG.USE_RESET {false} \
    CONFIG.SECONDARY_SOURCE {Single_ended_clock_capable_pin} \
  ] [get_bd_cells clk_wiz_0]

  apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config { \
    make_external "FIXED_IO, DDR" \
    apply_board_preset "0" \
    Master "Disable" \
    Slave "Disable" \
  } [get_bd_cells processing_system7_0]

  set_property -dict [list CONFIG.preset {ZC706}] [get_bd_cells processing_system7_0]

  set_property -dict [list \
    CONFIG.PCW_USE_S_AXI_HP0 {1} \
    CONFIG.PCW_USE_S_AXI_HP1 {1} \
    CONFIG.PCW_USE_S_AXI_HP2 {1} \
    CONFIG.PCW_USE_S_AXI_HP3 {1} \
    CONFIG.PCW_QSPI_GRP_IO1_ENABLE {1}\
    ] [get_bd_cells processing_system7_0]

  apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {\
    Master "/FGPU_0/M0" Clk "/clk_wiz_0/clk_out1 ($FREQ MHz)" \
  } [get_bd_intf_pins processing_system7_0/S_AXI_HP0]
  apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {\
    Master "/FGPU_0/M1" Clk "/clk_wiz_0/clk_out1 ($FREQ MHz)" \
  } [get_bd_intf_pins processing_system7_0/S_AXI_HP1]
  apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { \
    Master "/FGPU_0/M2" Clk "/clk_wiz_0/clk_out1 ($FREQ MHz)" \
  }  [get_bd_intf_pins processing_system7_0/S_AXI_HP2]
  apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { \
    Master "/FGPU_0/M3" Clk "/clk_wiz_0/clk_out1 ($FREQ MHz)" \
  } [get_bd_intf_pins processing_system7_0/S_AXI_HP3]
  save_bd_design

  apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { \
    Master "/processing_system7_0/M_AXI_GP0" Clk "/clk_wiz_0/clk_out1 ($FREQ MHz)" \
  } [get_bd_intf_pins FGPU_0/S0]

  connect_bd_net \
    [get_bd_pins processing_system7_0/FCLK_RESET0_N] \
    [get_bd_pins rst_clk_wiz_0_$FREQ\M/ext_reset_in]

  connect_bd_net \
    [get_bd_pins processing_system7_0/FCLK_CLK0] \
    [get_bd_pins clk_wiz_0/clk_in1]

  set_property range 1G [get_bd_addr_segs {FGPU_0/M0/SEG_processing_system7_0_HP0_DDR_LOWOCM}]
  set_property range 1G [get_bd_addr_segs {FGPU_0/M1/SEG_processing_system7_0_HP1_DDR_LOWOCM}]
  set_property range 1G [get_bd_addr_segs {FGPU_0/M2/SEG_processing_system7_0_HP2_DDR_LOWOCM}]
  set_property range 1G [get_bd_addr_segs {FGPU_0/M3/SEG_processing_system7_0_HP3_DDR_LOWOCM}]

  save_bd_design

  make_wrapper -files [get_files .srcs/sources_1/bd/$bd_name/$bd_name.bd] -top

  generate_target all [get_files  .srcs/sources_1/bd/$bd_name/$bd_name.bd]
}

