#######################################
# 
# what are most important parts of fingerprint?
brushing.fingerprint


# peaks per second
ggplot(df.summary %>% 
         select(time_minute, peaks.per.sec) %>% 
         mutate(date = as.character(floor_date(time_minute, "day"))) %>%
         filter(date != "2016-01-21"), 
       aes(x = time_minute)) + 
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
  labs(title = "Comparision of peaks per sec vs Fingerprint",
       x = "") +
  facet_wrap(~date, ncol = 1, scales = "free_x") +
  theme_bw() 


# avg.period 
ggplot(df.summary %>% 
         select(time_minute, avg.period) %>% 
         mutate(date = as.character(floor_date(time_minute, "day"))) %>%
         filter(date != "2016-01-21"), 
       aes(x = time_minute)) + 
  geom_line(aes(y = avg.period)) + 
  geom_vline(xintercept = c(as.numeric(dmy_hms("20/01/2016 170200", tz = "GMT")),
                            as.numeric(dmy_hms("20/01/2016 180700", tz = "GMT")),
                            as.numeric(dmy_hms("20/01/2016 182900", tz = "GMT")),
                            as.numeric(dmy_hms("20/01/2016 215600", tz = "GMT")),
                            as.numeric(dmy_hms("25/02/2016 172000", tz = "GMT")),
                            as.numeric(dmy_hms("25/02/2016 230200", tz = "GMT")),
                            as.numeric(dmy_hms("26/02/2016 073100", tz = "GMT"))
  ), col = "red") +
  geom_hline(yintercept = brushing.fingerprint$avg.period, col = "blue") +
  labs(title = "Comparision of avg peaks period vs Fingerprint",
       x = "") +
  facet_wrap(~date, ncol = 1, scales = "free_x") +
  theme_bw() 

# sd.period
## need to limit y axis for visibility
ggplot(df.summary %>% 
         select(time_minute, sd.period) %>% 
         mutate(date = as.character(floor_date(time_minute, "day"))) %>%
         filter(date != "2016-01-21"), 
       aes(x = time_minute)) + 
  geom_line(aes(y = sd.period)) + 
  geom_vline(xintercept = c(as.numeric(dmy_hms("20/01/2016 170200", tz = "GMT")),
                            as.numeric(dmy_hms("20/01/2016 180700", tz = "GMT")),
                            as.numeric(dmy_hms("20/01/2016 182900", tz = "GMT")),
                            as.numeric(dmy_hms("20/01/2016 215600", tz = "GMT")),
                            as.numeric(dmy_hms("25/02/2016 172000", tz = "GMT")),
                            as.numeric(dmy_hms("25/02/2016 230200", tz = "GMT")),
                            as.numeric(dmy_hms("26/02/2016 073100", tz = "GMT"))
  ), col = "red") +
  geom_hline(yintercept = brushing.fingerprint$sd.period, col = "blue") +
  labs(title = "Comparision of sd peaks period vs Fingerprint\nNOTE y axis limited to 0-0.25 some data missing",
       x = "") +
  facet_wrap(~date, ncol = 1, scales = "free_x") +
  theme_bw()+
  scale_y_continuous(limits = c(0,0.25))

# mean
ggplot(df.summary %>% 
         select(time_minute, Mean) %>% 
         mutate(date = as.character(floor_date(time_minute, "day"))) %>%
         filter(date != "2016-01-21"), 
       aes(x = time_minute)) + 
  geom_line(aes(y = Mean)) + 
  geom_vline(xintercept = c(as.numeric(dmy_hms("20/01/2016 170200", tz = "GMT")),
                            as.numeric(dmy_hms("20/01/2016 180700", tz = "GMT")),
                            as.numeric(dmy_hms("20/01/2016 182900", tz = "GMT")),
                            as.numeric(dmy_hms("20/01/2016 215600", tz = "GMT")),
                            as.numeric(dmy_hms("25/02/2016 172000", tz = "GMT")),
                            as.numeric(dmy_hms("25/02/2016 230200", tz = "GMT")),
                            as.numeric(dmy_hms("26/02/2016 073100", tz = "GMT"))
  ), col = "red") +
  geom_hline(yintercept = brushing.fingerprint$Mean, col = "blue") +
  labs(title = "Comparision of mean vector mag vs Fingerprint\nNOTE y axis limited to 0.9-1.5 some data missing",
       x = "") +
  facet_wrap(~date, ncol = 1, scales = "free_x") +
  theme_bw()+
  scale_y_continuous(limits = c(0.9,1.5))

# median
ggplot(df.summary %>% 
         select(time_minute, Median) %>% 
         mutate(date = as.character(floor_date(time_minute, "day"))) %>%
         filter(date != "2016-01-21"), 
       aes(x = time_minute)) + 
  geom_line(aes(y = Median)) + 
  geom_vline(xintercept = c(as.numeric(dmy_hms("20/01/2016 170200", tz = "GMT")),
                            as.numeric(dmy_hms("20/01/2016 180700", tz = "GMT")),
                            as.numeric(dmy_hms("20/01/2016 182900", tz = "GMT")),
                            as.numeric(dmy_hms("20/01/2016 215600", tz = "GMT")),
                            as.numeric(dmy_hms("25/02/2016 172000", tz = "GMT")),
                            as.numeric(dmy_hms("25/02/2016 230200", tz = "GMT")),
                            as.numeric(dmy_hms("26/02/2016 073100", tz = "GMT"))
  ), col = "red") +
  geom_hline(yintercept = brushing.fingerprint$Median, col = "blue") +
  labs(title = "Comparision of median vector mag vs Fingerprint\nNOTE y axis limited to 0.9-1.5 some data missing",
       x = "") +
  facet_wrap(~date, ncol = 1, scales = "free_x") +
  theme_bw()+
  scale_y_continuous(limits = c(0.9,1.5))


# quartile
ggplot(df.summary %>% 
         select(time_minute, Qu1) %>% 
         mutate(date = as.character(floor_date(time_minute, "day"))) %>%
         filter(date != "2016-01-21"), 
       aes(x = time_minute)) + 
  geom_line(aes(y = Qu1)) + 
  geom_vline(xintercept = c(as.numeric(dmy_hms("20/01/2016 170200", tz = "GMT")),
                            as.numeric(dmy_hms("20/01/2016 180700", tz = "GMT")),
                            as.numeric(dmy_hms("20/01/2016 182900", tz = "GMT")),
                            as.numeric(dmy_hms("20/01/2016 215600", tz = "GMT")),
                            as.numeric(dmy_hms("25/02/2016 172000", tz = "GMT")),
                            as.numeric(dmy_hms("25/02/2016 230200", tz = "GMT")),
                            as.numeric(dmy_hms("26/02/2016 073100", tz = "GMT"))
  ), col = "red") +
  geom_hline(yintercept = brushing.fingerprint$Qu1st, col = "blue") +
  labs(title = "Comparision of mean vector mag vs Fingerprint\nNOTE y axis limited to 0.9-1.5 some data missing",
       x = "") +
  facet_wrap(~date, ncol = 1, scales = "free_x") +
  theme_bw()+
  scale_y_continuous(limits = c(0.9,1.5))