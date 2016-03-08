brushing.summary <- lapply(list(df1, df2, df3, df4), summ.df.mean)

brushing.summary

brushing.summary.dir <- lapply(list(df1, df2, df3, df4), function(x) round(table(x$vector.dir)/nrow(x), 2))
brushing.summary.dir

brushing.fingerprint <- Reduce('+', brushing.summary) / length(brushing.summary)

brushing.fingerprint.sd <- lapply(list(df1, df2, df3, df4), summ.df.sd)
brushing.fingerprint.sd <- Reduce('+', brushing.fingerprint.sd) / length(brushing.fingerprint.sd)
brushing.fingerprint.sd

brushing.fingerprint <- cbind(t(brushing.fingerprint), 
                              mean.dir5 = c(0,0,0,mean(sapply(brushing.summary.dir, function(x) x[5]))),
                              sd.dir5 = c(0,0,0, sd(sapply(brushing.summary.dir, function(x) x[5]))))
brushing.fingerprint

save(brushing.fingerprint, file = "brushing.fingerprint.RDA" )

brushing.fingerprint.sd  <- cbind(t(brushing.fingerprint.sd), 
                                  sd.dir5 = c(0,0,0, sd(sapply(brushing.summary.dir, function(x) x[5]))))

brushing.fingerprint.sd

save(brushing.fingerprint.sd, file = "brushing.fingerprint.sd.RDA" )