# label data 

## minutes when brushing occurring 
## from subject diary
brushing.minutes <- c(dmy_hms("20/01/2016 170100", tz = "GMT"),
                      dmy_hms("20/01/2016 170200", tz = "GMT"),
                      dmy_hms("20/01/2016 170300", tz = "GMT"),
                      dmy_hms("20/01/2016 180500", tz = "GMT"),
                      dmy_hms("20/01/2016 180600", tz = "GMT"),
                      dmy_hms("20/01/2016 180700", tz = "GMT"),
                      dmy_hms("20/01/2016 180800", tz = "GMT"),
                      dmy_hms("20/01/2016 182700", tz = "GMT"),
                      dmy_hms("20/01/2016 182800", tz = "GMT"),
                      dmy_hms("20/01/2016 182900", tz = "GMT"),
                      dmy_hms("20/01/2016 215500", tz = "GMT"),
                      dmy_hms("20/01/2016 215600", tz = "GMT"),
                      dmy_hms("20/01/2016 215700", tz = "GMT"),
                      ymd_hms("20160225 171900", tz = "GMT"), 
                      ymd_hms("20160225 172000", tz = "GMT"), 
                      ymd_hms("20160225 172100", tz = "GMT"),
                      ymd_hms("20160225 230100", tz = "GMT"), 
                      ymd_hms("20160225 230200", tz = "GMT"), 
                      ymd_hms("20160225 230300", tz = "GMT"),
                      ymd_hms("20160225 230400", tz = "GMT"),
                      ymd_hms("20160226 072900", tz = "GMT"), 
                      ymd_hms("20160226 073000", tz = "GMT"), 
                      ymd_hms("20160226 073100", tz = "GMT"), 
                      ymd_hms("20160226 073200", tz = "GMT"))

df$brushing <- ifelse(df$time_minute %in% brushing.minutes, 1, 0)
df.summary$brushing <- ifelse(df.summary$time_minute %in% brushing.minutes, 1, 0)

# housekeeping
rm(brushing.minutes)

cache("df")
cache("df.summary")
