#' F.norm
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
#' F.norm(A0,A1)

F.norm <- function(A0,A1)
{
  return(sqrt(sum((A0-A1)^2)))
}
