require(caret)
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
                      dmy_hms("20/01/2016 215700", tz = "GMT"))
times <- unique(test$time_minute)
confusionMatrix(ifelse(sim.results$event > 0, 1, 0), ifelse(times %in% brushing.minutes, 1, 0))