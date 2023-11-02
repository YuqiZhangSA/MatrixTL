#' Check orthogonality
#'
#' @param A a matrix to be checked
#'
#' @return logical
#' @export
#'
#' @examples
#' A <- matrix(rnorm(3*4),3,4)
#' is_orthogonal(A)
is_orthogonal <- function(A){
  return(all.equal(t(A) %*% A, diag(nrow(t(A) %*% A))))
}
