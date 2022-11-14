# 5G_HorizontalSlicing

The source code is avaialble in: 5G Slicing SourceCode.m 

The database sample for 626 MBit, is available in : input.mat

The target throughputs (Mega-bit) are available in target.mat, 

Test file is also available for DNN slicing in : test.mat

--------------------------------------------------------------------------------

All the files: input.mat, target.mat, test.mat constructing the DeepHS database.  

With RCRRM equals: 612 626 646 668 684 812 832 956 970 1100 1114 1242 1258 1292 1386 1402 2586 5172  

If you want to generate all database, you need to run the code again for all RCRRM throughput, and varying the users number from min to max capacity of each RCRRM, then concatenate them in one database. Min and Max are empirical depending of optimisation capacity of cvx)  
