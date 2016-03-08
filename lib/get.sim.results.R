#' get.sim.results
#'
#' @param raw.df -
#' @param summary.df 
#' @param brushing.fingerprint 
#' @param similarity 
#' @param close
#'
#' @return
#' 
get.sim.results <- function(raw.df, summary.df, 
                            brushing.fingerprint,
                            brushing.fingerprint.sd,
                            similarity.euclidean.m = similarity.euclidean, 
                            similarity.boolean.m = similarity.boolean,
                            sigma = 1,
                            close = 2){
  cores <- detectCores()
  cl <- makeCluster(cores)
  registerDoParallel(cl)
  times <- unique(summary.df$Timestamp)
  sim.results.e <- foreach(t = seq_along(times), .combine = c) %dopar% {
    return(sim = similarity.euclidean.m(as.data.frame(brushing.fingerprint)[4,], 
                                        summary.df[summary.df$Timestamp == times[t], ][4,]))
  }
  sim.results.b <- foreach(t = seq_along(times), .combine = rbind) %dopar% {
    return(sim = similarity.boolean.m(brushing.fingerprint = as.data.frame(brushing.fingerprint)[4,], 
                                      brushing.fingerprint.sd = as.data.frame(brushing.fingerprint.sd)[4,], 
                                      sigma = sigma, 
                                      d = summary.df[summary.df$Timestamp == times[t], ][4,]))
  }
  stopCluster(cl)
  
  sim.results <- data.frame(times = times, sim.e = sim.results.e, sim.b = sim.results.b)
  
  sim.results$event.e <- ifelse(sim.results$sim.e < close, 1, 0)
  sim.results$event.b <- ifelse(sim.results %>% select(sim.b.1:sim.b.4) %>% apply(., 1, sum) == 4, 1, 0)
  
  sim.results %>% filter(event.e == 1 )
  sim.results %>% filter(event.b == 1)
  sim.results %>% filter(event.e == 1 & event.b == 1)
  
  sim.results$event <- ifelse(sim.results$event.e == 1 &
                                sim.results$event.b == 1, 
                              1,0)
  
  counter <- 0
  for (i in 2:length(sim.results$event)) {
    if(sim.results$event[i] == 1 & sim.results$event[i-1] == 0) counter <- counter + 1
    if(sim.results$event[i] == 1 ) sim.results$event[i] <- counter
  }
  message(paste(counter, " events of brushing teeth have been identified"))
  
  result <- left_join(raw.df, 
                      sim.results, 
                      by = c("time_minute" = "times"))
  
  return(result)
}