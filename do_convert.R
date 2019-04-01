setwd('/Users/anant/')
library(data.table)                   # load it
library(stringr)  

inp_HPC_1 <- fread("HPC_1_S26746_epilog.bed")
ret <- data_convert(inp_HPC_1)
col1 <- ret[,.(chr_num)]
col1
col1[1]
write.table(ret, file = "re_out_HPC_1.cov", row.names = FALSE, col.names = FALSE, sep = "\t" )


inp_HPC_2 <- fread("HPC_2_S26752_epilog.bed")
ret_HPC_2 <- data_convert(inp_HPC_2)
write.csv(ret_HPC_2, file = "out_HPC_2")


inp_HPC_3 <- fread("HPC_3_S26753_epilog.bed")
ret_HPC_3 <- data_convert(inp_HPC_3)
write.table(ret_HPC_3, file = "out_HPC_3")


inp_HPC_4 <- fread("HPC_4_S26754_epilog.bed")
ret_HPC_4 <- data_convert(inp_HPC_4)
write.table(ret_HPC_4, file = "out_HPC_4")

inp_HPC_5 <- fread("HPC_5_S26747_epilog.bed")
ret_HPC_5 <- data_convert(inp_HPC_5)
write.table(ret_HPC_5, file = "out_HPC_5")

inp_HPC_6 <- fread("HPC_6_S26755_epilog.bed")
ret_HPC_6 <- data_convert(inp_HPC_6)
write.table(ret_HPC_6, file = "out_HPC_6")

inp_HPC_7 <- fread("HPC_7_S26748_epilog.bed")
ret_HPC_7 <- data_convert(inp_HPC_7)
write.table(ret_HPC_7, file = "out_HPC_7")

inp_HPC_8 <- fread("HPC_8_S26756_epilog.bed")
ret_HPC_8 <- data_convert(inp_HPC_8)
write.table(ret_HPC_8, file = "out_HPC_8")

inp_HPC_9 <- fread("HPC_9_S26749_epilog.bed")
ret_HPC_9 <- data_convert(inp_HPC_9)
write.table(ret_HPC_9, file = "out_HPC_9")

inp_HPC_10 <- fread("HPC_10_S26750_epilog.bed")
ret_HPC_10 <- data_convert(inp_HPC_10)
write.table(ret_HPC_10, file = "out_HPC_10")

inp_HPC_11 <- fread("HPC_11_S26751_epilog.bed")
ret_HPC_11 <- data_convert(inp_HPC_11)
write.table(ret_HPC_11, file = "out_HPC_11")

inp_HPC_12 <- fread("HPC_12_S26757_epilog.bed")
ret_HPC_12 <- data_convert(inp_HPC_12)
write.table(ret_HPC_12, file = "out_HPC_12")

