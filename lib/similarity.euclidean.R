#' similarity
#'
#' @param brushing.fingerprint 
#' @param d a one minute summary of actigraphy data for comparision with the fingerprint
#'
#' @return a measure of similarity - euclidean distance from fingerprint
#' 
similarity.euclidean <- function(brushing.fingerprint, d, close){
  return(
      # sqrt(sum(((brushing.fingerprint$Qu1st-d$Qu1)/brushing.fingerprint$Qu1st)^2)) +
      sqrt(sum(((brushing.fingerprint$Median-d$Median)/brushing.fingerprint$Median)^2)) +
      sqrt(sum(((brushing.fingerprint$Mean-d$Mean)/brushing.fingerprint$Mean)^2)) +
      # sqrt(sum(((brushing.fingerprint$Qu3rd-d$Qu2)/brushing.fingerprint$Qu3rd)^2)) +
      # sqrt(sum(((brushing.fingerprint$mean.dir5[4]-max(d$per.vec.dir5[4], 0, na.rm = T))/brushing.fingerprint$mean.dir5[4])^2)) +
      sqrt(sum(((brushing.fingerprint$vector.mag.peaks.per.sec - d$vector.mag.peaks.per.sec)/brushing.fingerprint$vector.mag.peaks.per.sec)^2)) +
      sqrt(sum(((brushing.fingerprint$vector.mag.avg.period - d$vector.mag.avg.period)/brushing.fingerprint$vector.mag.avg.period)^2)) +
      0.5 * sqrt(sum(((brushing.fingerprint$vector.mag.sd.period - d$vector.mag.sd.period)/brushing.fingerprint$vector.mag.sd.period)^2)) +
      sqrt(sum(((brushing.fingerprint$vector.mag.avg.amp - d$vector.mag.avg.amp)/brushing.fingerprint$vector.mag.avg.amp)^2)) +
      sqrt(sum(((brushing.fingerprint$vector.mag.sd.amp - d$vector.mag.sd.amp)/brushing.fingerprint$vector.mag.sd.amp)^2))
  )
}