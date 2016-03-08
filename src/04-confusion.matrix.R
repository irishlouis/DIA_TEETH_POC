require(caret)

times <- unique(test$time_minute)
confusionMatrix(ifelse(sim.results$event > 0, 1, 0), ifelse(times %in% brushing.minutes, 1, 0))