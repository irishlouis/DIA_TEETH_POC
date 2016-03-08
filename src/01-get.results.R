# save.image("test_brushing_pattern.RDATA")

org.result <- get.sim.results(raw.df = org.df,summary.df = org.df.summary, 
                              brushing.fingerprint = brushing.fingerprint, 
                              brushing.fingerprint.sd = brushing.fingerprint.sd, 
                              sigma = 3.5, close = 0.11)
org.result %>% select(time_minute, sim.e,  event) %>% filter(event > 0) %>% distinct()

# 100% on training dataset


test.result <- get.sim.results(raw.df = test.df, summary.df = test.df.summary, 
                               brushing.fingerprint = brushing.fingerprint, 
                               brushing.fingerprint.sd = brushing.fingerprint.sd, 
                               sigma = 3.5, close = 0.11)
test.result %>% select(time_minute, sim.e,  event) %>% filter(event > 0) %>% distinct()

# 66% and 6 FP's

new.result <- get.sim.results(raw.df = test.new, summary.df = test.new.summary, 
                              brushing.fingerprint = brushing.fingerprint, 
                              brushing.fingerprint.sd = brushing.fingerprint.sd, 
                              sigma = 3.5, close = 0.11)
new.result %>% select(time_minute, sim.e,  event) %>% filter(event > 0) %>% distinct()