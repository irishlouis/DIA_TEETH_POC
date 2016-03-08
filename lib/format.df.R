#' format.df
#'
#' @param df - raw actigraphy data to be formated, without metadata 
#'
#' @return df - formated df with formated time, vector.mag & vector.dir
#' 
format.df <- function(df) {
  names(df) <- str_replace(names(df), " ", "")
  op <- options(digits.secs = 3)
  df$Timestamp <- dmy_hms(df$Timestamp, tz = "GMT")
  df$vector.dir <- NA
  df$vector.dir[df$AccelerometerX<0  & df$AccelerometerY<0  & df$AccelerometerZ<0]  <- 1 
  df$vector.dir[df$AccelerometerX<0  & df$AccelerometerY<0  & !df$AccelerometerZ<0] <- 2 
  df$vector.dir[df$AccelerometerX<0  & !df$AccelerometerY<0 & !df$AccelerometerZ<0] <- 3 
  df$vector.dir[!df$AccelerometerX<0 & !df$AccelerometerY<0 & !df$AccelerometerZ<0] <- 4 
  df$vector.dir[!df$AccelerometerX<0 & !df$AccelerometerY<0 & df$AccelerometerZ<0]  <- 5 
  df$vector.dir[!df$AccelerometerX<0 & df$AccelerometerY<0  & df$AccelerometerZ<0]  <- 6 
  df$vector.dir[df$AccelerometerX<0  & !df$AccelerometerY<0 & df$AccelerometerZ<0]  <- 7 
  df$vector.dir[!df$AccelerometerX<0 & df$AccelerometerY<0  & !df$AccelerometerZ<0] <- 8 
  df$vector.dir[df$AccelerometerX==0 & df$AccelerometerY==0 & df$AccelerometerZ==0] <- 9
  df$vector.dir <- as.factor(df$vector.dir)
  df <- df %>% mutate(vector.mag = sqrt(AccelerometerX^2+ AccelerometerY^2+ AccelerometerZ^2),
                      time_minute = floor_date(Timestamp, "minute"))  
  return(df)
}