#'  Orthogonal matrix generating function (semi-orthogonal)
#'
#' @param n the row size of the generated orthogonal matrix
#' @param r the column size of the generated orthogonal matrix
#'
#' @return a matrix
#' @export
#'
#' @examples
#' orthogonal.matrix(10,5)
orthogonal.matrix <- function(n, r) {
  # Generate a random n by r matrix with random values
  A <- matrix(rnorm(n * r), n, r)
  # Perform QR decomposition to get the orthogonal matrix
  Q <- qr.Q(qr(A))
  return(as.matrix(Q))
}
