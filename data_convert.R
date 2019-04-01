data_convert <- function(input){
  library(data.table)                   # load it
  library(stringr)                      #load it
  DT = data.table(input)
  x <- DT[V3 == '+']
  meth <- x[,V2]
  meth <- meth+1
  DT[V3 == '+']$V2 <- meth
  dif <- diff(DT$V2)
  dif <- c(dif, 1)
  DT = data.table(DT, dif)
  DT <- DT[dif != 0]
  upd <- DT[, .(chr_num = V1, site1 = V2, site2 = V2, freq = 100*(V5/V6), Count = V5, Miss = V6-V5)]
  upd <- upd[order(chr_num)]
  
  chr_n <- upd[,chr_num]
  chr_n <- substring(chr_n, 4)
  upd[]$chr_num <- chr_n
  conf <- upd[str_length(chr_num) == 1]
  
  # chan <- conf[chr_num != 'X']
  # chan <- chan[chr_num != 'Y']
  # col_1 <- chan[,.(chr_num)]
  # col_1 <- strtoi(col1)
  # chan[]$chr_num <- col_1
  # return(chan)
  
  return(conf)
  
  
  #get rid of chromosome x and y data points through data.table expression, then convert string to integer 
  
}

