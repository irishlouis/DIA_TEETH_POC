#' get.sim.results
#'
#' @param summ.df 
#' @param brushing.fingerprint 
#' @param similarity.euclidean.m
#' @param close
#'
#' @return sim.results
#' 
get.sim.results <- function(summ.df, 
                            brushing.fingerprint,
                            similarity.measure = similarity.euclidean, 
                            close = 2){
  cores <- detectCores()
  cl <- makeCluster(cores)
  registerDoParallel(cl)
  times <- unique(summ.df$time_minute)
  sim.results.e <- foreach(t = seq_along(times), .combine = c) %dopar% {
    return(sim = similarity.measure(brushing.fingerprint = as.data.frame(brushing.fingerprint)[1,], 
                                    d = summ.df[summ.df$time_minute == times[t], ][1,],
                                    close = close))
  }
  
  stopCluster(cl)
  
  sim.results <- data.frame(times = times, sim.result = sim.results.e)
  if(identical(similarity.measure , similarity.euclidean)) {
    sim.results$event <- ifelse(sim.results$sim.result < close, 1, 0)
  } else {
    sim.results$event <- ifelse(sim.results$sim.result >= 5, 1, 0)
  }
  
  return(sim.results)
}