#' summ.df.mean
#'
#' @param d 
#' @param epoch 
#'
#' @return
#' @export
#'
#' @examples
summ.df.mean <- function(d, epoch = 60) {
  splits <- rollapply(1:nrow(d), epoch*100, function(x) x )
  splits <- as.data.frame(splits)
  d <- d %>% select( -Timestamp, -time_minute, -vector.dir)
  tmp <- apply(splits, 1, function(x) {apply(d[x, ], 2, summary)})
  tmp <- as.data.frame(tmp)
  return(matrix(apply(tmp, 1, mean), 
                nrow = 6, 
                dimnames = list(rownames = c("Min.","Qu1st","Median", "Mean","Qu3rd","Max"),
                                colnames = c("AccelerometerX","AccelerometerY","AccelerometerZ","vector.mag"))))
}