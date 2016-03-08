#' summ.df.sd
#'
#' @param d 
#' @param epoch 
#'
#' @return
#' @export
#'
#' @examples
summ.df.sd <- function(d, epoch = 60, freq = 100) {
  # splits <- rollapply(1:nrow(d), epoch*freq, function(x) x  )
  # splits <- as.data.frame(splits)
  # splits <- as.data.frame(splits)
  d <- d %>% select( vector.mag)
  tmp <- data.frame()
  for(i in 1:(nrow(d) - (epoch * freq) + 1)){
    split <- i:(i+(epoch * freq)-1)
    tmp <- rbind(tmp, summary(d[split, ] ))
  }
  
  return(matrix(apply(tmp, 2, sd), 
                nrow = 6, 
                dimnames = list(rownames = c("Min.","Qu1st","Median", "Mean","Qu3rd","Max"),
                                colnames = c("vector.mag"))))
}