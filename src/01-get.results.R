# filter df to only include test minutes
eval.df <- df %>% filter(!time_minute %in% training.minutes)
eval.df.summary <- df.summary %>% filter(!time_minute %in% training.minutes)

test.perf <- df %>% filter(time_minute %in% training.minutes)
test.perf.summary <- df.summary %>% filter(time_minute %in% training.minutes)

# calibrate on test.df.summary
get.sim.results(summary.df = test.perf.summary, 
                brushing.fingerprint = brushing.fingerprint,
                close = 0.080)

# run on evaluation dataset
eval.results <- get.sim.results(summary.df = eval.df.summary, 
                brushing.fingerprint = brushing.fingerprint,
                close = 0.080)

# confusion matrix of evaluation results
confusionMatrix(eval.results$event.e, eval.df.summary$brushing)

###################################################################################

# try on different subject
test.new.results <- get.sim.results(summary.df = test.new.summary, 
                brushing.fingerprint = brushing.fingerprint,
                close = 0.080)

# confusion matrix of evaluation results
confusionMatrix(test.new.results$event.e, test.new.summary$brushing)

# finds none

# cache results
cache("eval.results")
cache("test.new.results")
