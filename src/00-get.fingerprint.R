
tmp <- df %>% filter(brushing == 1) 
minutes <- unique(tmp$time_minute)

# partition testing / training minutes
set.seed(789456)
training.minutes <- sample(minutes, 0.7 * length(minutes), replace = F)
testing.minutes <- minutes[-which(minutes %in% training.minutes)]



# partition hou

brushing.summary.mean <- lapply(training.minutes, function(x) summ.df.mean(d = tmp %>% 
                                                                             filter(time_minute == x) %>% 
                                                                             select(-brushing), 
                                                           epoch = 60))
cache("brushing.summary.mean")

# brushing.summary.dir <- lapply(hours, function(x) round(table(tmp[hour == x, vector.dir])/nrow(tmp[hour=x,]), 2))
# brushing.summary.dir

brushing.fingerprint.mean <- Reduce('+', brushing.summary.mean) / length(brushing.summary.mean)

# brushing.summary.sd <- lapply(training.minutes, function(x) summ.df.sd(d = tmp %>% 
#                                                                          filter(time_minute == x) %>% 
#                                                                          select(-brushing), 
#                                                                 epoch = 60) )
# cache("brushing.summary.sd")

# brushing.fingerprint.sd <- Reduce('+', brushing.fingerprint.sd) / length(brushing.fingerprint.sd)
# brushing.fingerprint.sd

brushing.fingerprint.mean <- t(brushing.fingerprint.mean)

brushing.fingerprint.mean

cache("brushing.fingerprint.mean" )

# brushing.fingerprint.sd  <- t(brushing.fingerprint.sd)
# 
# brushing.fingerprint.sd

# cache("brushing.fingerprint.sd")

rm(tmp, minutes)
