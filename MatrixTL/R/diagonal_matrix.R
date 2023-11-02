#' Diagonal matrix generating function
#'
#' @param r The rank of a diagonal matrix
#'
#' @return matrix
#' @export
#'
#' @examples
#' diagonal.matrix(5)
diagonal.matrix <- function(r) {
  # Generate random non-negative values
  random_values <- runif(r, min = 0, max = 1)
  # Create a diagonal matrix with random non-negative values
  diagonal_matrix <- diag(random_values)
  return(as.matrix(diagonal_matrix))
}
