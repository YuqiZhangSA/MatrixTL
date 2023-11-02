#' Generate orthonormal matrix
#'
#' @param r a tuning parameter that represent the rank of the generated orthonormal matrix
#'
#' @return a matrix
#' @export
#'
#' @examples
#' orthonormal.matrix(10)
#'
orthonormal.matrix <- function(r){
  # Generate a random r x r matrix A
  # with normally distributed random values
  A <- matrix(rnorm(r * r), nrow = r, ncol = r)
  # Perform QR decomposition on A to obtain Q
  Q <- qr.Q(qr(A))

  # Check if columns of Q need to be adjusted
  # for consistent orientation
  # The sign of the columns can be adjusted
  # to ensure that the determinant of Q is 1
  if (det(Q) < 0) {
    Q <- -Q
  }

  return(Q)
}
