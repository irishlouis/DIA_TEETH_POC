head(df.summary)
set.seed(7654)
# partition data for building model
inTrain <- createDataPartition(df.summary$brushing, p = .6, list = FALSE)
training <- df.summary[inTrain, ] %>% mutate(brushing = as.factor(ifelse(brushing == 1, "y", "n")))
testing <- df.summary[-inTrain, ] %>% mutate(brushing = as.factor(ifelse(brushing == 1, "y", "n")))

# define model training control
my_control <- caret::trainControl(
  method='repeatedcv',
  number=3,
  savePredictions=TRUE,
  classProbs=TRUE  
)

# set up for parallel processing
# install.packages("doParallel")
cores <- detectCores()-1
cl <- makeCluster(cores)
registerDoParallel(cl)

set.seed(2345)
# train list of models using control spec'd above
model_list <- caretList(brushing ~ ., 
                        data=as.data.frame(training)[, -c(1:2)], 
                        trControl=my_control,
                        methodList=c('rotationForest', 'xgbTree', 'ada', 'gbm',
                                     'adaboost', 'rf', 'nnet', 
                                     'svmRadial', 'rpart', 'glm'))


lapply(model_list, 
       function(x) confusionMatrix(predict(x, testing), testing$brushing))

# check all have class probilities
sapply(model_list, function(x) is.function(x$modelInfo$prob))

# look at corrolation btn the models
modelCor(resamples(model_list))

# create greedy ensemble of the model list

greedy_ensemble <- caretEnsemble(model_list)

summary(greedy_ensemble)

require(pROC)

# create a stack of model list using GLM
# note defining model control inside of training call here
nnet_ensemble <- caretStack(
  model_list, 
  method='nnet',
  metric='ROC',
  trControl=trainControl(
    method='boot',
    number=10,
    savePredictions=TRUE,
    classProbs=TRUE,
    summaryFunction=twoClassSummary
  )
)

# test
confusionMatrix(predict(greedy_ensemble, newdata=testing, type='raw'), 
                testing$brushing)

confusionMatrix(predict(nnet_ensemble, newdata=testing, type='raw'), 
                testing$brushing)



stopCluster(cl)


