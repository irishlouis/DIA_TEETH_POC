#' clean.rules
#'
#' @param rules - a apriori object of rules 
#' @description clean up raw results from arules - removing redundant rules, rounding to 3 digits and sorting by lift
#' @return rules.pruned - a pruned & formatted set of apriori rules

clean.rules <- function(rules){
  # keep three decimal places
  quality(rules) <- round(quality(rules), digits=3)
  ## order rules by lift
  rules.sorted <- sort(rules, by="lift")
  
  ## find redundant rules
  subset.matrix <- is.subset(rules.sorted, rules.sorted)
  subset.matrix[lower.tri(subset.matrix, diag = T)] <- NA
  redundant <- colSums(subset.matrix, na.rm = T) >= 1
  
  rules.pruned <- rules.sorted[!redundant]
  return(rules.pruned)
}