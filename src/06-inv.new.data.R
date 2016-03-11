# louis plots

# evening plot
p1 <- ggplot(test.new %>% filter(Timestamp > ymd_hms("20160225 214200", tz= "GMT"),
                                 Timestamp < ymd_hms("20160225 214500", tz= "GMT")),
       aes(Timestamp, vector.mag)) + geom_line() + 
  labs(title = "New Test Subject Brushing Vector Magnitude",
       y = "")
## how close was similarity
test.new.results %>% filter(times >= ymd_hms("20160225 214200", tz= "GMT"),
                            times <= ymd_hms("20160225 214500", tz= "GMT")) 

test.new.summary %>% filter(time_minute >= ymd_hms("20160225 214200", tz= "GMT"),
                            time_minute <= ymd_hms("20160225 214500", tz= "GMT"))

brushing.fingerprint

#################
#
# morning 

p2 <- ggplot(test.new %>% filter(Timestamp > ymd_hms("20160226 080800", tz= "GMT"),
                                 Timestamp < ymd_hms("20160226 081100", tz= "GMT")),
             aes(Timestamp, vector.mag)) + geom_line() + 
  labs(title = "New Test Subject Brushing Vector Magnitude",
       y = "")
## how close was similarity
test.new.results %>% filter(times >= ymd_hms("20160226 080800", tz= "GMT"),
                            times <= ymd_hms("20160226 081100", tz= "GMT")) 

test.new.summary %>% filter(time_minute >= ymd_hms("20160226 080800", tz= "GMT"),
                            time_minute <= ymd_hms("20160226 081100", tz= "GMT"))

brushing.fingerprint
