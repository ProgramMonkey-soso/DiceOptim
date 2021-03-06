% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/qEI.R
\name{qEI}
\alias{qEI}
\title{Analytical expression of the multipoint expected improvement (qEI)
criterion}
\usage{
qEI(
  x,
  model,
  plugin = NULL,
  type = "UK",
  minimization = TRUE,
  fastCompute = TRUE,
  eps = 10^(-5),
  envir = NULL
)
}
\arguments{
\item{x}{a matrix representing the set of input points (one row corresponds
to one point) where to evaluate the qEI criterion,}

\item{model}{an object of class \code{km},}

\item{plugin}{optional scalar: if provided, it replaces the minimum of the
current observations,}

\item{type}{"SK" or "UK" (by default), depending whether uncertainty
related to trend estimation has to be taken into account,}

\item{minimization}{logical specifying if EI is used in minimiziation or in
maximization,}

\item{fastCompute}{if TRUE, a fast approximation method based on a
semi-analytic formula is used (see [Marmin 2014] for details),}

\item{eps}{the value of \emph{epsilon} of the fast computation trick.
Relevant only if \code{fastComputation} is TRUE,}

\item{envir}{an optional environment specifying where to get intermediate
values calculated in \code{\link{qEI}}.}
}
\value{
The multipoint Expected Improvement, defined as \deqn{qEI(X_{new})
:= E[ ( min(Y(X)) - min(Y( X_{new} )) )_{+} | Y(X)=y(X)],}

where \eqn{X} is the current design of experiments, \eqn{ X_{new} } is a
new candidate design, and \eqn{Y} is a random process assumed to have
generated the objective function \eqn{y}.
}
\description{
Computes the multipoint expected improvement criterion.
}
\examples{

\donttest{
set.seed(007)

# Monte-Carlo validation

# a 4-d, 81-points grid design, and the corresponding response
d <- 4; n <- 3^d
design <- do.call(expand.grid,rep(list(seq(0,1,length=3)),d))
names(design) <- paste("x",1:d,sep="")
y <- data.frame(apply(design, 1, hartman4))
names(y) <- "y"

# learning
model <- km(~1, design=design, response=y, control=list(trace=FALSE))

# pick up 10 points sampled from the 1-point expected improvement
q <- 10
X <- sampleFromEI(model,n=q)
# simulation of the minimum of the kriging random vector at X
t1 <- proc.time()
newdata <- as.data.frame(X)
colnames(newdata) <- colnames(model@X)

krig  <- predict(object=model, newdata=newdata,type="UK",se.compute=TRUE, cov.compute=TRUE)
mk <- krig$mean
Sigma.q <- krig$cov
mychol <- chol(Sigma.q)
nsim <- 300000
white.noise <- rnorm(n=nsim*q)
minYsim <- apply(crossprod(mychol,matrix(white.noise,nrow=q)) + mk,2,min)
# simulation of the improvement (minimization)
qImprovement <- (min(model@y)-minYsim)*((min(model@y)-minYsim) > 0)

# empirical expectation of the improvement and confident interval (95\%)
eiMC <- mean(qImprovement)
confInterv <- c(eiMC - 1.96*sd(qImprovement)*1/sqrt(nsim),eiMC + 1.96*sd(qImprovement)*1/sqrt(nsim))

# MC estimation of the qEI
print(eiMC) 
t2 <- proc.time()
# qEI with analytical formula
qEI(X,model,fastCompute= FALSE)
t3 <- proc.time()
# qEI with fast computation trick
qEI(X,model)
t4 <- proc.time()
t2-t1  # Time of MC computation
t3-t2  # Time of normal computation
t4-t3  # Time of fast computation
}

}
\references{
C. Chevalier and D. Ginsbourger (2014) Learning and Intelligent
Optimization - 7th International Conference, Lion 7, Catania, Italy,
January 7-11, 2013, Revised Selected Papers, chapter Fast computation of
the multipoint Expected Improvement with applications in batch selection,
pages 59-69, Springer.

D. Ginsbourger, R. Le Riche, L. Carraro (2007), A Multipoint Criterion for
Deterministic Parallel Global Optimization based on Kriging. The
International Conference on Non Convex Programming, 2007.

S. Marmin. Developpements pour l'evaluation et la maximisation du critere
d'amelioration esperee multipoint en optimisation globale (2014). Master's
thesis, Mines Saint-Etienne (France) and University of Bern (Switzerland).

D. Ginsbourger, R. Le Riche, and L. Carraro. Kriging is well-suited to
parallelize optimization (2010), 
In Lim Meng Hiot, Yew Soon Ong, Yoel
Tenne, and Chi-Keong Goh, editors, \emph{Computational Intelligence in
Expensive Optimization Problems}, Adaptation Learning and Optimization,
pages 131-162. Springer Berlin Heidelberg.

J. Mockus (1988), \emph{Bayesian Approach to Global Optimization}. Kluwer
academic publishers.

M. Schonlau (1997), \emph{Computer experiments and global optimization},
Ph.D. thesis, University of Waterloo.
}
\seealso{
\code{\link{EI}}
}
\author{
Sebastien Marmin 

Clement Chevalier 

David Ginsbourger
}
\keyword{models}
\keyword{optimization}
\keyword{parallel}
