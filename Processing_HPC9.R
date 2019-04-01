#install.packages("data.table")        # install it
library(data.table)                   # load it
#install.packages("stringr")
library(stringr)

setwd("/Users/anant")
data <- fread("HPC_9_S26749_epilog.bed")
DT = data.table(data)
head(DT)

x <- DT[V3 == '+']
head(x)
meth <- x[,V2]
meth
meth <- meth+1
meth
head(DT)
DT[V3 == '+']$V2 <- meth
DT
head(DT)
dif <- diff(DT$V2)
dif <- c(dif, 1)
head(dif)
length(dif)
nrow(DT)
length(DT)
DT = data.table(DT, dif)
length(DT)
head(DT)

DT <- DT[dif != 0]
head(DT)
nrow(DT)

upd <- DT[, .(chr_num = V1, site1 = V2, site2 = V2, freq = 100*(V5/V6), Count = V5, Miss = V6-V5)]
head(upd)
upd <- upd[order(chr_num)]
upd
chr_n <- upd[,chr_num]
chr_n <- substring(chr_n, 4)
upd[]$chr_num <- chr_n
upd
conf <- upd[str_length(chr_num) == 1 | str_length(chr_num) == 2]
conf
conf[,chr_num]
conf <- conf[chr_num != 'Y' & chr_num != 'M' & chr_num != 'X']
conf
conf[chr_num == 10]
conf
c_1 <- conf[]$chr_num
c_1
c_1 <- strtoi(c_1)
c_1
temp_DT <- conf[,.(site1,site2,freq,Count,Miss)]
new_DT <-  data.table(c_1, temp_DT)
new_DT
write.table(new_DT, file = "2_26_HPC_9.cov", row.names = FALSE, col.names = FALSE, sep = "\t" )

#Up until here, just processing the initial .bed file with collapsing

DT2 <- fread('2_26_HPC_9.cov')
DT2
DT2[V1 == 10]
dim(DT2)
c <- 1 
DT3 <- data.table()
DT3
# for (row in 1:nrow(DT2)) {
#   val <- DT2[row]$V2
#   val
#   val_low <- val - 1
#   val_high <- val + 1
#   temp <- DT2[row]
#   temp$V2 <- val_low
#   temp$V2
#  DT3 <- rbind(DT3, data.table(temp))
#  DT3
#   temp$V2 <- val
#  DT3 <- rbind(DT3, data.table(temp))
#   DT3
#   temp$V2 <- val_high
#   DT3 <- rbind(DT3, data.table(temp))
# }
DT3

pts <- DT2$V2
pts_low <- pts - 1
DT_low <- DT2
DT_low[]$V2 <- pts_low
DT_low

pts_high <- pts + 1
DT_high <- DT2
DT_high[]$V2 <- pts_high
DT_high


DT_tot <- rbind(DT_low, DT2) 
DT_tot <- rbind(DT_tot, DT_high)
DT_tot

DT_tot_adj <- DT_tot[order(V1, V2)]
DT_tot_adj

dif <- diff(DT_tot_adj$V2)
dif <- c(dif, 1)
#sort(dif)
upd <- data.table(DT_tot_adj, dif)
upd
w_dif_zero <- upd[dif == 0]
w_dif_zero

wo_dif_zero <- upd[dif != 0]
wo_dif_zero
new_DT_2 <- wo_dif_zero[, .(V1, V2, V3, V4, V5, V6)]
new_DT_2

write.table(new_DT_2, file = "2_26_bothsides_HPC9.cov", row.names = FALSE, col.names = FALSE, sep = "\t")



