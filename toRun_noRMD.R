##Install dependencies, commented incase dependencies are already present.
# source("https://bioconductor.org/biocLite.R")
# biocLite("preprocessCore")

#Put here the location of the package
setwd("/Users/anant/MouseEpigeneticClock-master/")
#setwd("./PredictionPackage_20170215/")
#setwd("/Users/anant/MouseEpigeneticClock-master/PredictionPackage_20170215/")


#setwd("./PredictionPackage_20170215/")

RdataF = "./PredictionPackage_20170215.Rdata"
print(RdataF)
functionFile = "./PredictorFunctions.R"
covFolder = "./bismarkFiles/"
ReadDepth = 5


 load(RdataF)
source(functionFile)
require(preprocessCore)

toProcess <- list.files(covFolder,pattern = ".cov")
print(toProcess)

filesToProcess <- list()
for(file in toProcess){
  tmp <- read.delim(paste(covFolder,file,sep=""),as.is = T, header = F)
  print(dim(tmp))
  #tmp <- read.delim(paste(covFolder,file,sep=""),as.is = T, header = T, sep = " ")
  rownames(tmp)
  rownames(tmp)<- paste(tmp[,1], tmp[,2],sep=":")
  rownames(tmp)
  tmp <- tmp[,4:ncol(tmp)]
  tmp
  tmp[,2] <- tmp[,2]+tmp[,3]
  tmp
  tmp[,1] <- tmp[,1]/100
  
  
  tmp <- tmp[which(tmp[,2]>=1),c(1:2)]
  tmp[,2]
  tmp <- tmp[which(rownames(tmp) %in% sitesForPrediction),]
  filesToProcess[[file]] <- tmp
  
}
tmp
dim(tmp)

sitesForPrediction
length(sitesForPrediction)

predictedAges <- list()
qnPerformed <- NULL

dim(filesToProcess[[1]])

filesToProcess[[1]]

length(sitesForPrediction)

alt_betas <- betas
alt_betas

for(i in 1:length(filesToProcess)){
  
  
  
  if(dim(filesToProcess[[i]])[1]==length(sitesForPrediction)){
    filesToProcess[[i]][,1] <- normalize.quantiles.use.target(matrix(filesToProcess[[i]][,1],ncol=1), target = qnTarget)
    print(paste("QN was performed for sample: ",names(filesToProcess)[i]))
    qnPerformed <- c(qnPerformed,T)
  } else {
    print(paste("QN was not possible for sample: ",names(filesToProcess)[i]))
    qnPerformed <- c(qnPerformed,F)
  }
  rownames(betas)
  dim(betas)
  rownames(filesToProcess[[1]])
  filesToProcess[[i]] <- filesToProcess[[i]][which(rownames(filesToProcess[[i]]) %in% rownames(betas)),]
 
  print(filesToProcess[[i]])
  print(dim(filesToProcess[[i]])[1])
  print(length(rownames(betas)))
  
  if(dim(filesToProcess[[i]])[1]==length(rownames(betas))){
    
    filesToProcess[[i]] <- filesToProcess[[i]][order(rownames(filesToProcess[[i]])),]
    filesToProcess[[i]]<- sweep(x =filesToProcess[[i]], 1, rowMean, "-" )
    filesToProcess[[i]] <- sweep(x =filesToProcess[[i]], 1, rowStDev, "/" )
    
    sitesTrainingData <- as.data.frame(filesToProcess[[i]][,1])
    betaScoreSample <- sitesTrainingData*betas
    betaScoreSample <- apply(betaScoreSample,2, sum)
    
    predictedAges[names(filesToProcess)[i]] <- revertAge(betaScoreSample)
    print(paste("Age was predicted for sample: ",names(filesToProcess)[i]))
  } else {
    print(paste("Unablse to predict age for sample: ",names(filesToProcess)[i]))
    predictedAges[names(filesToProcess)[i]] <- NA
  }
}

length(betas)
dim(filesToProcess[[i]])[1]
for(i in 1:length(predictedAges)){
  if(qnPerformed[i]){
    print(paste("Predicted age for sample ",names(filesToProcess)[i],": ",round(predictedAges[[i]],digits = 1), sep=""))
  } else {
    print(paste("Predicted age for sample ",names(filesToProcess)[i],": ",round(predictedAges[[i]],digits = 1), " *", sep=""))
  }
  
}
not_in <- list()
#temp <- filesToProcess[[1]]
temp
dim(temp)
for(i in 1:length(filesToProcess)){
  temp <- filesToProcess[[i]]
  not_in[[i]] <- betas[which(!(rownames(betas) %in% rownames(temp))),]
}
print(not_in[[1]])
filesToProcess[1]
dim(filesToProcess[[1]])[1]
