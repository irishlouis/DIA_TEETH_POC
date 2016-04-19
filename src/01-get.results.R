# filter df to only include test minutes
eval.df <- df %>% filter(!time_minute %in% training.minutes)
eval.df.summary <- df.summary %>% filter(!time_minute %in% training.minutes)

test.perf <- df %>% filter(time_minute %in% training.minutes)
test.perf.summary <- df.summary %>% filter(time_minute %in% training.minutes)

# calibrate on test.df.summary
get.sim.results(summ.df = test.perf.summary, 
                brushing.fingerprint = brushing.fingerprint,
                close = 0.080)

# run on evaluation dataset
eval.results.e <- get.sim.results(summ.df = eval.df.summary, 
                brushing.fingerprint = brushing.fingerprint,
                close = 0.225)

# confusion matrix of evaluation results
confusionMatrix(eval.results.e$event, eval.df.summary$brushing)

## try using boolean
eval.results.b <- get.sim.results(summ.df = eval.df.summary, 
                                brushing.fingerprint = brushing.fingerprint,
                                similarity.measure = similarity.boolean,
                                close = 0.12)

# confusion matrix of evaluation results
confusionMatrix(eval.results.b$event, eval.df.summary$brushing)

# overlap in results
confusionMatrix(eval.results.e$event, eval.results.b$event)

# look where they agree
joined <- cbind(eval.results.b, euc = eval.results.e[,3]) %>% 
  mutate(agree = ifelse(event + euc == 2, 1, 0))


confusionMatrix(joined$agree, 
                eval.df.summary$brushing)

###################################################################################

# try on different subject
test.new.results <- get.sim.results(summ.df = test.new.summary, 
                brushing.fingerprint = brushing.fingerprint,
              #  similarity.measure =similarity.boolean,
                close = 0.080)

# confusion matrix of evaluation results
confusionMatrix(test.new.results$event, test.new.summary$brushing)

# finds none

# cache results
cache("eval.results")
cache("test.new.results")
