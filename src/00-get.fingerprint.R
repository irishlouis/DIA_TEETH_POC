
# create tmp df - raw data for brushing events
tmp <- df %>% filter(brushing == 1) 
minutes <- unique(tmp$time_minute)

# partition testing / training minutes
set.seed(789456)
training.minutes <- sample(minutes, 0.7 * length(minutes), replace = F)
testing.minutes <- minutes[-which(minutes %in% training.minutes)]

# get summary from training minutes of brushing
brushing.summary.mean <- lapply(training.minutes, function(x) 
  summ.df.mean(d = tmp %>%
                 filter(time_minute == x) %>%
                 select(-brushing),
               epoch = 60))

cache("brushing.summary.mean")

# get mean 
brushing.fingerprint.mean <- Reduce('+', brushing.summary.mean) / length(brushing.summary.mean)
brushing.fingerprint.mean <- t(brushing.fingerprint.mean)

# get peak summary for each training minute
peak.summary <- lapply(training.minutes, function(x)
  (tmp %>% 
     filter(time_minute == x) %>% 
     select(vector.mag) %>% 
     apply(.,2, 
           function(v) get.peak.summary(v, k=10, freq=100)) %>% t())
)

# get summaries of peak data
peak.summary.averages <- sapply(peak.summary, function(x) x[1,]) %>% apply(1, mean)
peak.per.sec.sd <- sapply(peak.summary, function(x) x[1,]) %>% apply(1, sd)

peak.summary <- data.frame(avg.peaks.per.sec = peak.summary.averages[1],
                           sd.peaks.per.sec = peak.per.sec.sd[2],
                           avg.period = peak.summary.averages[2],
                           sd.period = peak.summary.averages[3])

brushing.fingerprint <- cbind(brushing.fingerprint.mean, peak.summary)

cache("brushing.fingerprint" )
cache("training.minutes")
cache("testing.minutes")

rm(tmp, minutes)
