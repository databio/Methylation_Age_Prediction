##Install dependencies, commented incase dependencies are already present.
# source("https://bioconductor.org/biocLite.R")
# biocLite("preprocessCore")

#Put here the location of the package
setwd("/Users/anant/Methylation Age Prediction/")
#setwd("./PredictionPackage_20170215/")
#setwd("/Users/anant/MouseEpigeneticClock-master/PredictionPackage_20170215/")


#setwd("./PredictionPackage_20170215/")

RdataF = "./PredictionPackage_20170215.Rdata"
print(RdataF)
functionFile = "./PredictorFunctions.R"
covFolder = "./AgePredictionInputData/bismarkFilesN12/"
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

rownames(betas)

#***Code to create vector with only matched sites. Uncomment when variables are no longer recognized
for(i in 1:length(filesToProcess)){
  temp <- filesToProcess[[i]]
  is_not_in <- betas[which(!(rownames(betas) %in% rownames(temp))),]
  upd_ini <- data.frame(is_not_in)
}

#print(not_in[[1]])
filesToProcess[1]
dim(filesToProcess[[1]])[1]

store <- rownames(upd_ini)
store

upd_betas = alt_betas[!rownames(alt_betas) %in% store,]
upd_betas2 = data.frame(upd_betas)

upd_betas2

dim(upd_betas2)

alt_betas

alt_SFP <- sitesForPrediction
alt_SFP

head(filesToProcess[[1]])

x <- rownames(filesToProcess[[1]])
head(x)
class(x)
class(sitesForPrediction)
head(sitesForPrediction)
is_in_SFP <- which(sitesForPrediction %in% x)


(is_in_SFP)
upd_SFP <- sitesForPrediction[is_in_SFP]
upd_SFP


# for(i in 1:length(filesToProcess)){
#   temp2 <- data.frame(rownames(filesToProcess[[i]]))
#   head(temp2)
#   dfSFP <- data.frame(sitesForPrediction)
#   head(dfSFP)
#   is_not_inSFP <- dfSFP[which(!(dfSFP) %in% temp2),]
#   upd_iniSFP <- data.frame(is_not_inSFP)
#   
# }
# is_not_inSFP
# dim(upd_iniSFP)
# 
# print('update')
# 
# store2 <- upd_iniSFP[,1]
# store2
# 
# upd_SFP = alt_SFP[!(alt_SFP) %in% store2,]
# upd_SFP2 = data.frame(upd_SFP)
# 
# upd_betas = alt_betas[!rownames(alt_betas) %in% store,]
# upd_betas2 = data.frame(upd_betas)
# 
# upd_betas2



if(dim(filesToProcess[[i]])[1]==length(upd_SFP)){
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

if(dim(filesToProcess[[i]])[1]==length(rownames(upd_betas2))){
  
  filesToProcess[[i]] <- filesToProcess[[i]][order(rownames(filesToProcess[[i]])),]
  filesToProcess[[i]]<- sweep(x =filesToProcess[[i]], 1, rowMean, "-" )
  filesToProcess[[i]] <- sweep(x =filesToProcess[[i]], 1, rowStDev, "/" )
  
  sitesTrainingData <- as.data.frame(filesToProcess[[i]][,1])
  betaScoreSample <- sitesTrainingData*upd_betas2
  betaScoreSample <- apply(betaScoreSample,2, sum)
  
  predictedAges[names(filesToProcess)[i]] <- revertAge(betaScoreSample)
  print(paste("Age was predicted for sample: ",names(filesToProcess)[i]))
} else {
  print(paste("Unable to predict age for sample: ",names(filesToProcess)[i]))
  predictedAges[names(filesToProcess)[i]] <- NA
}


dim(filesToProcess[[i]])[1]
for(i in 1:length(predictedAges)){
  if(qnPerformed[i]){
    print(paste("Predicted age for sample ",names(filesToProcess)[i],": ",round(predictedAges[[i]],digits = 1), sep=""))
  } else {
    print(paste("Predicted age for sample ",names(filesToProcess)[i],": ",round(predictedAges[[i]],digits = 1), " *", sep=""))
  }
  
}


getwd()


