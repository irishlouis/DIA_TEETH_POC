#' summary.df
#'
#' @param df data.frame to summarise
#' @param freq frequency device recording at
#' @param k window size of smoothing
#'
#' @export summary data.frame
#' 
summary.df <- function(df, freq, k=10){
  test <-  select(df, time_minute, vector.mag) %>%
    melt(id.vars = "time_minute")
  
  times <- unique(df$time_minute)
  
  test.summary <- test %>%
    group_by(time_minute, variable) %>%
    summarise(min = min(value), 
              Qu1 = quantile(value, .25),
              Median = median(value),
              Mean = mean(value),
              Qu2 = quantile(value, .75),
              Max = max(value))
  
  tmp <- do.call(rbind, lapply(seq_along(times), function(t) peak.func(times[t], df, freq, k)))
  test.summary <- cbind(test.summary, tmp %>% select(-Timestamp)) 
  return(test.summary)
}