#' similarity.boolean
#'
#' @param brushing.fingerprint 
#' @param brushing.fingerprint.sd 
#' @param sigma 
#' @param d 
#'
#' @return
#' 
similarity.boolean <- function(brushing.fingerprint, d, close){
  
  close.avg.peak.rate <- d$peaks.per.sec > (1-close) * brushing.fingerprint$avg.peaks.per.sec &
    d$peaks.per.sec < (1+close) * brushing.fingerprint$avg.peaks.per.sec
  
  close.avg.peak.period <- d$avg.period > (1-close) * brushing.fingerprint$avg.period &
    d$avg.period < (1+close) * brushing.fingerprint$avg.period
  
  close.sd.peak.period <- d$sd.period > (0.66) * brushing.fingerprint$sd.period &
    d$sd.period < (1.33) * brushing.fingerprint$sd.period
  
  close.mean <- d$Mean > (1-close/3) * brushing.fingerprint$Mean &
    d$Mean < (1+close/3) * brushing.fingerprint$Mean
  
  close.median <- d$Median > (1-close/3) * brushing.fingerprint$Median &
    d$Median < (1+close/3) * brushing.fingerprint$Median
  
  return(sum(close.avg.peak.rate, close.avg.peak.period, close.sd.peak.period, close.mean, close.median))
}