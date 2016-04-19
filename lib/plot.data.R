#' plot.data
#'
#' @param d 
#'
#' @return
#' @export
#'
#' @examples
plot.data <- function(d){
  p1 <- ggplot(d, aes(Timestamp, vector.mag)) + 
    geom_line() + theme(legend.position="none") + labs(title = "Overall Vector Mag") + theme_bw()
  p2 <- ggplot(d, aes(Timestamp, AccelerometerX)) + geom_line() + labs(title = "X Accel Data") + theme_bw()
  p3 <- ggplot(d, aes(Timestamp, AccelerometerY)) + geom_line() + labs(title = "Y Accel Data") + theme_bw()
  p4 <- ggplot(d, aes(Timestamp, AccelerometerZ)) + geom_line() + labs(title = "Z Accel Data") + theme_bw()
  
  grid.arrange(p1, p2, p3, p4, ncol = 1)
}