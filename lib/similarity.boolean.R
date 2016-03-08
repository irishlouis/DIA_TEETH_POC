#' similarity.boolean
#'
#' @param brushing.fingerprint 
#' @param brushing.fingerprint.sd 
#' @param sigma 
#' @param d 
#'
#' @return
#' 
similarity.boolean <- function(brushing.fingerprint, brushing.fingerprint.sd, sigma = 1, d){
  tmp <- brushing.fingerprint$Mean + (sigma * brushing.fingerprint.sd$Mean * c(-1,1))
  close.mean <- d$Mean >= tmp[1] & d$Mean <= tmp[2]
  tmp <- brushing.fingerprint$Median + (sigma * brushing.fingerprint.sd$Median * c(-1,1))
  close.median <- d$Median >= tmp[1] & d$Median <= tmp[2]
  # don't have sd for peaks per second of teeth brushing events
  tmp <- brushing.fingerprint$peaks.per.sec + 
    (sigma * brushing.fingerprint.sd$peak.per.sec.sd * c(-1,1))
  close.peak.rate <- d$peaks.per.sec >= tmp[1] & d$peaks.per.sec <= tmp[2]
  
  tmp <- brushing.fingerprint$avg.period + (sigma * brushing.fingerprint$sd.period * c(-1,1))
  close.peak.period <- d$avg.period >= tmp[1] & d$avg.period <= tmp[2]
  
  return(c(close.mean, close.median, close.peak.rate, close.peak.period))
}