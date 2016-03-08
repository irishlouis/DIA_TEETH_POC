#' peak.func
#'
#' @param t time period to calculate peak summary for
#' @param df dataset to pull vector from
#' @param freq frequency device recording at 
#' @param k window size for smoothing
#'
#' @return data.frame of peak summary for period t
#' 
peak.func <- function(t, df, freq, k){
  tbl <- df %>% filter(time_minute == t) %>% 
    select(-Timestamp, -vector.dir, -time_minute) %>% 
    apply(.,2, function(x) get.peak.summary(v = x, k = k, freq = freq)) %>% 
    t() %>% data.frame %>% mutate(Timestamp = t) 
  if(nrow(tbl) == 4) {
    return(tbl)
  } else{
    return(data.frame(peaks.per.sec = rep(0,4), 
                      avg.period = rep(0,4), 
                      sd.period = rep(0,4), 
                      Timestamp  = rep(t,4)))
  }
}