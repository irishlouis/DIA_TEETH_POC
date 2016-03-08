#' similarity
#'
#' @param brushing.fingerprint 
#' @param d a one minute summary of actigraphy data for comparision with the fingerprint
#'
#' @return a measure of similarity - euclidean distance from fingerprint
#' 
similarity.euclidean <- function(brushing.fingerprint, d){
  return(
    # sqrt(sum(((brushing.fingerprint$Qu1st-d$Qu1)/brushing.fingerprint$Qu1st)^2)) +
    sqrt(sum(((brushing.fingerprint$Median-d$Median)/brushing.fingerprint$Median)^2)) +
      sqrt(sum(((brushing.fingerprint$Mean-d$Mean)/brushing.fingerprint$Mean)^2)) +
      # sqrt(sum(((brushing.fingerprint$Qu3rd-d$Qu2)/brushing.fingerprint$Qu3rd)^2)) +
      # sqrt(sum(((brushing.fingerprint$mean.dir5[4]-max(d$per.vec.dir5[4], 0, na.rm = T))/brushing.fingerprint$mean.dir5[4])^2)) +
      sqrt(sum(((brushing.fingerprint$avg.period - d$avg.period)/brushing.fingerprint$avg.period)^2)) +
      # sqrt(sum(((brushing.fingerprint$sd.period - d$sd.period)/brushing.fingerprint$sd.period)^2)) +
      sqrt(sum(((brushing.fingerprint$peaks.per.sec - d$peaks.per.sec)/brushing.fingerprint$peaks.per.sec)^2))
  )
}