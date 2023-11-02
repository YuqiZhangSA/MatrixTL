#' Operator norm
#'
#' @param A0 A matrix of a fixed size, say n*p
#' @param A1 Another matrix of the same size as A0, n*p
#'
#' @return numeric
#' @export
#'
#' @examples
#' A0 <- matrix(rnorm(10*5),10,5)
#' A1 <- matrix(rnorm(10*5),10,5)
#' op.norm(A0,A1)
op.norm <- function(A0,A1){
  eigenvalues <- eigen(t(A0-A1) %*% (A0-A1))$values
  return(sqrt(max(eigenvalues)))
}
