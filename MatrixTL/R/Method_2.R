#' Vertical concatenation transfer learning method
#'
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
#' vertical.concatenation(Y0,Y1,r)
vertical.concatenation <- function(Y0,Y1,r){
  # vertical concatenate Y0 and Y1
  Y <- rbind(Y0,Y1)
  # dim(Y)

  # Perform basic SVD estimation for the concatenation Y
  Y.h.r.2 <- SVD.est(Y,r)

  # Divide Y0 estimation from the concatenation
  Y0.h.r.2 <- Y.h.r.2[1:nrow(Y0),]

  return(Y0.h.r.2)
}

