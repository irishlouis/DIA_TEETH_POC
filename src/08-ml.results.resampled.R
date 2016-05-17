# run with multiple splits to see if performance holds

checkModel <- function(seed){
  set.seed(seed)
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
  
  # train list of models using control spec'd above
  model_list <- caretList(brushing ~ ., 
                          data=as.data.frame(training)[, -c(1:2)], 
                          trControl=my_control,
                          methodList=c('xgbTree', 'ada', 'gbm',
                                       'adaboost', 'rf', 'nnet', 
                                       'svmRadial', 'rpart'))
  
  return(lapply(model_list, 
                function(x) confusionMatrix(predict(x, testing), testing$brushing)$overall[2]) %>% unlist)
  stopCluster(cl)
}

set.seed(123123)
# set how many runs to do
n_resamples <- 30
seeds <- round(rep(runif(n_resamples, 1, 10000000)), 0)

resample.results <- do.call(rbind, lapply(seeds, function(s) {print(which(seeds ==s)); return(checkModel(s))}))

summary(resample.results)

ggplot(melt(resample.results, varnames = c("sample_id", "method"), value.name = "kappa") %>% 
         mutate(method = str_replace(method, ".Kappa", "")),
       aes(x=method, y=kappa)) + 
  geom_violin() +
  geom_boxplot(fill = "grey", alpha = 0.25) + 
  geom_point(alpha = 0.25) +
  theme_bw() +
  labs(title = "Kappa Results from Models for 30 partitions",
       subtitle = "Significant variation in performance",
       x="",
       y="Kappa (%)") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5),
         panel.grid.major.x = element_blank())
         
       
cache("resample.results")
