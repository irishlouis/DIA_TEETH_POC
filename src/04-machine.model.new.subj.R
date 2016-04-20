# will model work for different subject
head(test.new.summary)

testing2 <- test.new.summary[,brushing := as.factor(ifelse(brushing == 1, "y", "n")),]


lapply(model_list, 
       function(x) confusionMatrix(predict(x, testing2), testing2$brushing))

confusionMatrix(predict(greedy_ensemble, newdata=testing2, type='raw'), 
                testing2$brushing)

confusionMatrix(predict(nnet_ensemble, newdata=testing2, type='raw'), 
                testing2$brushing)




