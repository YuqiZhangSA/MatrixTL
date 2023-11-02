---
output: pdf_document
---

<!-- README.md is generated from README.Rmd. Please edit that file -->

```{r, include = FALSE}
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.path = "man/figures/README-",
  out.width = "100%"
)
```

# MatrixTL

<!-- badges: start -->

<!-- badges: end -->

MatrixTL is short for *Matrix Transfer Learning*, we aim to estimate a low-rank matrix by observing its noisy version. 

## Model
To be specific, the model is of the form
$$
  Y_0=M_0^*+E_0,\ Y_1=M_1^*+E_1,
$$
where $Y_0\in \mathbb{R}^{n_0\times p}$ and $Y_1\in \mathbb{R}^{n_1\times p}$ are our observations; $M_0^*\in \mathbb{R}^{n_0\times p}$ is called *target matrix* we aim to estimate and $M_1^*\in \mathbb{R}^{n_1\times p}$ is the *source matrix* which highly related to the target matrices under a specific sense; $E_0\in \mathbb{R}^{n_0\times p}$ and $E_1\in \mathbb{R}^{n_1\times p}$ are the Normally distributed random noise matrices. 

We aim to perform transfer learning methods to estimate the target matrix $M_0^*$ via the information from both target and source observation, rather than the direct low-rank matrix estimation only through $Y_0$.

In this simplified package, we only consider a very fundamental setting of this model, which is, in the true matrices $M_0^*$ and $M_1^*$, they share the same right-singular matrix, that is to say, they have the same column spaces spanned by the right-singular vectors. Ahead of the instruction of the package, we generate a synthetic dataset under this simple setting and store it in the `data` folder.

```{r}
# Note that here we used some basic matrix-generating functions which we have included in our packages. Here we only show how we generated the synthetic dataset.
library(MatrixTL)

# Set dimension parameter
n0 <- 200
n1 <- 500
p <- 100
r <- 80

# Generate target data
U0 <- orthogonal.matrix(n0,r)
Lambda0 <- diagonal.matrix(r)
V0 <- orthogonal.matrix(p,r)
M0 <- U0 %*% Lambda0 %*% t(V0)
E0 <- noise.matrix(n0,p)
Y0 <- M0 + E0

# Generate source data
# Setting 1: V1 = V0
U1 <- orthogonal.matrix(n1,r)
Lambda1 <- diagonal.matrix(r)
V1 <- V0
M1 <- U1 %*% Lambda1 %*% t(V1)
E1 <- noise.matrix(n1,p)
Y1 <- M1 + E1

# Create a list to store the matrices
test_matrix <- list(Y0, Y1)
file_name <- "MatrixTL_test_data.RData"
save(test_matrix, file = file_name)
Y0 <- test_matrix[[1]]
Y1 <- test_matrix[[2]]
```


## Installation
```{r}
# install_github("yuqizhangsa/MatrixTL")
```

## Example
Here we provide an example of how to use the package.
```{r example}
library(MatrixTL)

# Load the data from the RData file
load("/Users/zhangyuqi/MatrixTL/data/MatrixTL_test_data.RData")
Y0 <- test_matrix[[1]]
Y1 <- test_matrix[[2]]

# suppose that we would process a low-rank estimation with tuning parameter r_hat
# note that r_hat < min(n0,n1,p)
r_hat <- 20

# Method 1: SVD estimation method
Y0_est_1 <- SVD.est(Y0,r_hat)

# Method 2: Vertical concatenation transfer learning method
Y0_est_2 <- vertical.concatenation(Y0,Y1,r_hat)

# Method 3: Two-sample-weighted transfer learning method
# set weights for the samples
w0 <- 0.3
w1 <- 1-w0
Y0_est_3 <- two.sample.weighted(w0,w1,Y0,Y1,r_hat)

# Evaluation of the estimation, we use Y0_est_2 as an example
# Evaluation 1: Frobenius norm
F.norm(Y0,Y0_est_2)
# Evaluation 2: Operator norm
op.norm(Y0,Y0_est_2)

```
