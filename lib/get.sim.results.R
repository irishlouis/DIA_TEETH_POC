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
                            brushing.fingerprint.sd = NULL,
                            similarity.euclidean.m = similarity.euclidean, 
                            similarity.boolean.m = similarity.boolean,
                            sigma = 1,
                            close = 2){
  cores <- detectCores()
  cl <- makeCluster(cores)
  registerDoParallel(cl)
  times <- unique(summary.df$time_minute)
  sim.results.e <- foreach(t = seq_along(times), .combine = c) %dopar% {
    return(sim = similarity.euclidean.m(as.data.frame(brushing.fingerprint)[1,], 
                                        summary.df[summary.df$time_minute == times[t], ][1,]))
  }
  
  stopCluster(cl)
  
  sim.results <- data.frame(times = times, sim.e = sim.results.e)
  
  sim.results$event.e <- ifelse(sim.results$sim.e < close, 1, 0)
 
  
  sim.results$event <- ifelse(sim.results$event.e == 1 , 
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