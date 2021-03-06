% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/goldsteinprice.R
\name{goldsteinprice}
\alias{goldsteinprice}
\title{2D test function}
\usage{
goldsteinprice(x)
}
\arguments{
\item{x}{a 2-dimensional vector specifying the location where the function
is to be evaluated.}
}
\value{
A real number equal to the goldsteinprice function values at
\code{x}
}
\description{
Goldstein-Price 2-dimensional test function.
}
\details{
The goldsteinprice (standardized version) function is defined over the
domain \code{[0,1]^2}. It has 1 global minimizer : x* = c(0.5, 0.25), with
minimum f(x*) = -3.129172, and 3 local minima x*,2 = c(0.35, 0.4), x*,3 =
c(0.95, 0.55), x*,4 = c(0.8 , 0.7), with respective minima f(x*,2) =
-2.180396, f(x*,3) = -1.756143, f(x*,4) = -0.807367.
}
\examples{
 
design <- matrix(runif(200), 200, 2)
response <- apply(design, 1, goldsteinprice)

}
\author{
Tobias Wagner  

Victor Picheny 

David Ginsbourger
}
\keyword{internal}
\keyword{optimize}
