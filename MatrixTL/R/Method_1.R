#' SVD estimation method
#'
#' @param Y0 The target matrix of size n*p
#' @param r A tuning parameter to process the rank-r estimation, r<min(n,p)
#'
#' @return A matrix
#' @export
#'
#' @examples
#' Y0 <- matrix(rnorm(10*5),10,5)
#' r <- 2
#' SVD.est(Y0,r)
#'
SVD.est <- function(Y0,r){
  # perform SVD on Y0
  Y0.svd <- svd(Y0)
  U0.h <- Y0.svd$u
  Sigma0.h <- diag(Y0.svd$d)
  V0.h <- Y0.svd$v

  # take top r vectors of each right singular matrix
  U0.h.r <- U0.h[,1:r]
  Sigma0.h.r <- diag((Y0.svd$d)[1:r])
  V0.h.r <- V0.h[,1:r]

  # estimation
  Y0.h.r <- U0.h.r %*% Sigma0.h.r %*% t(V0.h.r)
  return(Y0.h.r)
}

