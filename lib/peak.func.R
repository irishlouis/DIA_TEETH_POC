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
  require(dplyr)
  tbl <- df %>% filter(time_minute == t) %>% 
    select(vector.mag) %>% 
    apply(.,2, function(x) get.peak.summary(v = x, k = k, freq = freq)) %>% 
    unlist %>% t() %>% data.frame %>% mutate(Timestamp = t) 
  if (nrow(tbl) == 1 & ncol(tbl) == 6 & is.numeric(tbl[1,1])){
    return(tbl)
  } else {
    return(data.table(vector.mag.peaks.per.sec=0, 
                      vector.mag.avg.period=0,
                      vector.mag.sd.period=0,
                      vector.mag.avg.amp=0,
                      vector.mag.sd.amp=0,
                      Timestamp=t))  
  }
}