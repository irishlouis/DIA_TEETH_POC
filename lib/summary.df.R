#' summary.df
#'
#' @param df data.frame to summarise
#' @param freq frequency device recording at
#' @param k window size of smoothing
#'
#' @export summary data.frame
#' 
summary.df <- function(df, freq, k=10){
  test <- df
  times <- unique(test$time_minute)
  
  test.summary <- select(test, -vector.dir, -time_minute) %>%
    melt(id.vars = "Timestamp") %>%
    mutate(Timestamp = floor_date(Timestamp, "minute")) %>%
    group_by(Timestamp, variable) %>%
    summarise(min = min(value), 
              Qu1 = quantile(value, .25),
              Median = median(value),
              Mean = mean(value),
              Qu2 = quantile(value, .75),
              Max = max(value)) %>%
    left_join(select(test, Timestamp, vector.dir, -time_minute) %>% 
                filter(vector.dir == 5) %>%
                mutate(Timestamp = floor_date(Timestamp, "minute")) %>% 
                group_by(Timestamp) %>% summarise(per.vec.dir5 = n()/(60 * freq)),
              by = "Timestamp"
    )
  tmp <- do.call(rbind, lapply(times, function(t) peak.func(t, test, freq, k)))
  test.summary <- cbind(test.summary, tmp %>% select(-Timestamp)) 
  return(test.summary)
}