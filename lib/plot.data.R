#' plot.data
#'
#' @param d 
#'
#' @return
#' @export
#'
#' @examples
plot.data <- function(d){
  p1 <- ggplot(d, aes(Timestamp, vector.mag)) + geom_point(aes(col = vector.dir)) + 
    geom_line() + theme(legend.position="none") + labs(title = "Overall Vector Mag")
  p2 <- ggplot(d, aes(Timestamp, AccelerometerX)) + geom_line() + labs(title = "X Accel Data")
  p3 <- ggplot(d, aes(Timestamp, AccelerometerY)) + geom_line() + labs(title = "Y Accel Data")
  p4 <- ggplot(d, aes(Timestamp, AccelerometerZ)) + geom_line() + labs(title = "Z Accel Data")
  
  grid.arrange(p1, p2, p3, p4, ncol = 1)
}