#' get.sim.results
#'
#' @param summary.df 
#' @param brushing.fingerprint 
#' @param similarity.euclidean.m
#' @param close
#'
#' @return sim.results
#' 
get.sim.results <- function(summary.df, 
                            brushing.fingerprint,
                            similarity.euclidean.m = similarity.euclidean, 
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
  
  return(sim.results)
}