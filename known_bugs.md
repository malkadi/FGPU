#Hardware
+ Branch in a conditional procedure call is not working. 
In other words, if a branch took place, then a function is called, whose code will branch, a problem will occurr.
Reason: A branch writes the current top entry of the diveergence stack(in CU schedulre) and will create a new entry on the top.
But the overwritten entry is needed when the function returns.
Solution: When a function is to be called, the wavefront active record (which referes to the top of divergence stack) needs to be incrmeneted. Have a look to the defined but commented PC_stack_dummy_entry in CU_scheduler.vhd.
How to regenarte: Use the LUdecompose kernel. Make a soft floating point operation in some if. You need data without NaN of inf.
+ When the buswidth of read data from cache to CUs is smaller than the #CUs * 32bit, they may be some problems.
The BRAM which stores read data from the cache in each CU may be overfilled and overwritten.
+ Using a 3 dimentional index space has never been tested. I didn't need it yet.
+ Changing the address of atomic operation within the same kernel has never been tested. Application is needed.
+ Setting the number of cache banks equal or less to the number of the AXI interface banks (CACHE_N_BANKS_W &lt= GMEM_N_BANKS_W) may lead to a bottleneck

#Compiler
+ Using other sections rather that .text is not yet supported.
How to generate: Define the coeffecients of a 5x5 image filter as a 2D array constant. This data will be stored into .rodata section.
