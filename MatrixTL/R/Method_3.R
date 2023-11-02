#' two-sample-weighted transfer learning method
#'
#' @param w0 The weight we put on the target data
#' @param w1 The weight we put on the source data, note that w1=1-w0
#' @param Y0 The target matrix of size n0*p
#' @param Y1 The source matrix of size n1*p
#' @param r A tuning parameter to process the rank-r estimation, r<min(n0,n1,p)
#'
#' @return A matrix
#' @export
#'
#' @examples
#' Y0 <- matrix(rnorm(10*5),10,5)
#' Y1 <- matrix(rnorm(10*5),10,5)
#' r <- 2
#' w0 <- 0.3
#' w1 <- 1-w0
#' two.sample.weighted(w0,w1,Y0,Y1,r)
two.sample.weighted <- function(w0,w1,Y0,Y1,r){
  # perform SVD on Y0 and Y1 respectively
  Y0.svd <- svd(Y0)
  U0.h <- Y0.svd$u
  Sigma0.h <- diag(Y0.svd$d)
  V0.h <- Y0.svd$v

  Y1.svd <- svd(Y1)
  U1.h <- Y1.svd$u
  Sigma1.h <- diag(Y1.svd$d)
  V1.h <- Y1.svd$v

  # take top r vectors of each right singular matrix
  V0.h.r <- V0.h[,1:r]
  U0.h.r <- U0.h[,1:r]
  Sigma0.h.r <- diag((Y0.svd$d)[1:r])

  V1.h.r <- V1.h[,1:r]

  # find the orthonormal matrix O
  # such that minimises the (rotate-)Frobenius distance
  # Orthogonal Procrustes problem
  M <- t(V1.h.r) %*% V0.h.r
  M.svd <- svd(M)
  M.u <- svd(M)$u
  M.v <- svd(M)$v
  O <- M.u %*% t(M.v)
  # check orthogonality
  is_orthogonal(O)
  # dim(V1.R)

  # weighted average
  weight.pair <- function(w0,w1,V0.h,V1.h.R){
    return(V0.h * w0 + V1.h.R * w1)
    #return(list(V0.h, V1.h.R ))
  }

  V.h.r.w <- weight.pair(w0,w1,V0.h.r,V1.h.r %*% O)
  F.norm(V0.h.r,V.h.r.w)
  F.norm(V0.h.r,V1.h.r)

  # calculate the estimation
  Y0.h.r.3 <- U0.h.r %*% Sigma0.h.r %*% t(V.h.r.w)

  return(Y0.h.r.3)
}


