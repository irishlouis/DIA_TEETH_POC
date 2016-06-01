# run with multiple splits to see if performance holds for new data/different subject

testing2 <- test.new.summary[,brushing := as.factor(ifelse(brushing == 1, "y", "n")),]

checkModelNewSubj <- function(seed=1){
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
  rm(training)
  
  return(rbind(lapply(model_list, 
                      function(x) confusionMatrix(predict(x, testing), testing$brushing)$overall[2]) %>% unlist,
               lapply(model_list, 
                      function(x) confusionMatrix(predict(x, as.data.frame(testing2)[, -c(1:2)]), testing2$brushing)$overall[2]) %>% unlist))
  rm(model_list)
  stopCluster(cl)
  
  unregister()
}

set.seed(123123)
# set how many runs to do
n_resamples <- 30
seeds <- round(rep(runif(n_resamples, 1, 10000000)), 0)

resample.results <- do.call(rbind, lapply(seeds, function(s) {print(which(seeds ==s)); return(checkModelNewSubj(s))}))

cache("resample.results")

dt <- data.table(resample.results)
dt[,test_type := c("validation", "new_subj"),]

dt[,lapply(.SD, summary), test_type]

setkey(dt, test_type)

p1<-ggplot(melt(dt["validation"] %>% select(-nnet.Kappa, -rpart.Kappa), id.vars = "test_type", value.name = "kappa") %>% 
         mutate(variable = str_replace(variable, ".Kappa", "")),
       aes(x=variable, y=kappa)) + 
  geom_violin() +
  geom_boxplot(fill = "grey", alpha = 0.25) + 
  geom_point(alpha = 0.25) +
  theme_bw() +
  labs(title = "Kappa Results from Models - 30 Data Partitions",
       subtitle = "The evaluation results of models trained & tested on Subject A show significant variation in performance\ndepending on the data split",
       # caption = "Grey box represents IQR with Median\nViolin plot shows distribution",
       x="",
       y="") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, size = 12),
         panel.grid.major.x = element_blank()) +
  scale_y_continuous(labels = percent)

p1

# print plot to pdf
pdf("evalResults.pdf",width = 8, height = 4, compress = FALSE )
p1
dev.off()
  
p2 <- ggplot(melt(dt["new_subj"] %>% select(-nnet.Kappa, -rpart.Kappa), id.vars = "test_type", value.name = "kappa") %>% 
         mutate(variable = str_replace(variable, ".Kappa", "")),
       aes(x=variable, y=kappa)) + 
  geom_violin() +
  geom_boxplot(fill = "grey", alpha = 0.25) + 
  geom_point(alpha = 0.25) +
  theme_bw() +
  labs(title = "Kappa Results for Predicting Unseen Subject - 30 Data Partitions",
       subtitle = "Using model trained on Subject A's teeth brushing pattern and using it classify periods of brushing\nfor Subject B shows some predictive power. Variance shows sensitivity to the training / testing partition",
      # caption = "Grey box represents IQR with Median\nViolin plot shows distribution",
       x="",
       y="") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, size = 12),
        panel.grid.major.x = element_blank()) +
  scale_y_continuous(labels = percent)
p2

# print plot to pdf
pdf("unseenResults.pdf",width = 8, height = 4, compress = FALSE )
p2
dev.off()

cache("resample.results")


