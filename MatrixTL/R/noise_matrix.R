#' Noise matrix generating function
#'
#' @param n The row size of the noise matrix
#' @param p The column size of the noise matrix
#'
#' @return A matrix
#' @export
#'
#' @examples
#' noise.matrix(10,5)
noise.matrix <- function(n,p)
{
  return(matrix(rnorm(n * p), nrow = n, ncol = p))
}
