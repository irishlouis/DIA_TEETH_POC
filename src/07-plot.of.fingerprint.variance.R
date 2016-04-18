#######################################
# 
# what are most important parts of fingerprint?
brushing.fingerprint


# peaks per second
ggplot(df.summary %>% select(time_minute, peaks.per.sec) %>% mutate(date = floor_date(time_minute, "day")), 
       aes(x =time_minute)) + 
  geom_line(aes(y = peaks.per.sec)) + 
  geom_vline(xintercept = c(as.numeric(dmy_hms("20/01/2016 170200", tz = "GMT")),
                            as.numeric(dmy_hms("20/01/2016 180700", tz = "GMT")),
                            as.numeric(dmy_hms("20/01/2016 182900", tz = "GMT")),
                            as.numeric(dmy_hms("20/01/2016 215600", tz = "GMT")),
                            as.numeric(dmy_hms("25/02/2016 172000", tz = "GMT")),
                            as.numeric(dmy_hms("25/02/2016 230200", tz = "GMT")),
                            as.numeric(dmy_hms("26/02/2016 073100", tz = "GMT"))
  ), col = "red") +
  geom_hline(yintercept = brushing.fingerprint$avg.peaks.per.sec, col = "blue") +
  labs(title = "peaks per sec") +
  facet_wrap(~date, ncol = 2, scales = "free_x")

# avg.period 
ggplot(test.summary %>% filter(variable == "vector.mag",
                               Timestamp > dmy_hms("20/01/2016 170000", tz = "GMT"),
                               Timestamp < dmy_hms("20/01/2016 220000", tz = "GMT")), 
       aes(x =Timestamp)) + geom_line(aes(y = avg.period)) + 
  geom_vline(xintercept = c(as.numeric(dmy_hms("20/01/2016 170200", tz = "GMT")),
                            as.numeric(dmy_hms("20/01/2016 180700", tz = "GMT")),
                            as.numeric(dmy_hms("20/01/2016 182900", tz = "GMT")),
                            as.numeric(dmy_hms("20/01/2016 215600", tz = "GMT"))
  ), col = "red") +
  geom_hline(yintercept = 10.8, col = "blue") +
  labs(title = "avg period")

# sd.period
ggplot(test.summary %>% filter(variable == "vector.mag",
                               Timestamp > dmy_hms("20/01/2016 170000", tz = "GMT"),
                               Timestamp < dmy_hms("20/01/2016 220000", tz = "GMT")), 
       aes(x =Timestamp)) + geom_line(aes(y = sd.period)) + 
  geom_vline(xintercept = c(as.numeric(dmy_hms("20/01/2016 170200", tz = "GMT")),
                            as.numeric(dmy_hms("20/01/2016 180700", tz = "GMT")),
                            as.numeric(dmy_hms("20/01/2016 182900", tz = "GMT")),
                            as.numeric(dmy_hms("20/01/2016 215600", tz = "GMT"))
  ), col = "red") +
  geom_hline(yintercept = 4.5, col = "blue")

# mean
ggplot(test.summary %>% filter(variable == "vector.mag",
                               Timestamp > dmy_hms("20/01/2016 170000", tz = "GMT"),
                               Timestamp < dmy_hms("20/01/2016 220000", tz = "GMT")), 
       aes(x =Timestamp)) + geom_line(aes(y = Mean)) + 
  geom_vline(xintercept = c(as.numeric(dmy_hms("20/01/2016 170200", tz = "GMT")),
                            as.numeric(dmy_hms("20/01/2016 180700", tz = "GMT")),
                            as.numeric(dmy_hms("20/01/2016 182900", tz = "GMT")),
                            as.numeric(dmy_hms("20/01/2016 215600", tz = "GMT"))
  ), col = "red") +
  geom_hline(yintercept = 1.068, col = "blue")+
  labs(title = "mean")

# median
ggplot(test.summary %>% filter(variable == "vector.mag",
                               Timestamp > dmy_hms("20/01/2016 170000", tz = "GMT"),
                               Timestamp < dmy_hms("20/01/2016 220000", tz = "GMT")), 
       aes(x =Timestamp)) + geom_line(aes(y = Median)) + 
  geom_vline(xintercept = c(as.numeric(dmy_hms("20/01/2016 170200", tz = "GMT")),
                            as.numeric(dmy_hms("20/01/2016 180700", tz = "GMT")),
                            as.numeric(dmy_hms("20/01/2016 182900", tz = "GMT")),
                            as.numeric(dmy_hms("20/01/2016 215600", tz = "GMT"))
  ), col = "red") +
  geom_hline(yintercept = 1.03, col = "blue") +
  labs(title = "median")


ggplot(test.summary %>% filter(variable == "vector.mag",
                               Timestamp > dmy_hms("20/01/2016 170000", tz = "GMT"),
                               Timestamp < dmy_hms("20/01/2016 220000", tz = "GMT")), 
       aes(x =Timestamp)) + geom_line(aes(y = Qu1)) + 
  geom_vline(xintercept = c(as.numeric(dmy_hms("20/01/2016 170200", tz = "GMT")),
                            as.numeric(dmy_hms("20/01/2016 180700", tz = "GMT")),
                            as.numeric(dmy_hms("20/01/2016 182900", tz = "GMT")),
                            as.numeric(dmy_hms("20/01/2016 215600", tz = "GMT"))
  ), col = "red") +
  geom_hline(yintercept = .82, col = "blue") +
  labs(title = "1stQ")

ggplot(test.summary %>% filter(variable == "vector.mag",
                               Timestamp > dmy_hms("20/01/2016 170000", tz = "GMT"),
                               Timestamp < dmy_hms("20/01/2016 220000", tz = "GMT")), 
       aes(x =Timestamp)) + geom_line(aes(y = Qu2)) + 
  geom_vline(xintercept = c(as.numeric(dmy_hms("20/01/2016 170200", tz = "GMT")),
                            as.numeric(dmy_hms("20/01/2016 180700", tz = "GMT")),
                            as.numeric(dmy_hms("20/01/2016 182900", tz = "GMT")),
                            as.numeric(dmy_hms("20/01/2016 215600", tz = "GMT"))
  ), col = "red") +
  geom_hline(yintercept = 1.28, col = "blue") +
  labs(title = "3rdQ")