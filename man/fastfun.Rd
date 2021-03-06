% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fastfun.R
\name{fastfun}
\alias{fastfun}
\title{Fastfun function}
\usage{
fastfun(fn, design, response = NULL)
}
\arguments{
\item{fn}{the evaluator function, found by a call to \code{\link[base]{match.fun}},}

\item{design}{a data frame representing the design of experiments.
The ith row contains the values of the d input variables corresponding to the ith evaluation.}

\item{response}{optional vector (or 1-column matrix or data frame) containing the values of the 1-dimensional output given by the objective function at the design points.}
}
\value{
An object of class  \code{\link[DiceOptim]{fastfun-class}}.
}
\description{
Modification of an R function to be used as with methods \code{predict} and \code{update} (similar to a \code{\link[DiceKriging]{km}} object). 
It creates an S4 object which contains the values corresponding to evaluations of other costly observations.
It is useful when an objective can be evaluated fast.
}
