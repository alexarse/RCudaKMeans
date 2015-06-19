\name{CudaKMean}
\alias{CudaKMean}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
R Cuda KMeans
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
CudaKMean(data, nCluster)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{data}{
%%     ~~Describe \code{data} here~~
}
  \item{nCluster}{
%%     ~~Describe \code{nCluster} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (data, nCluster) 
{
    dyn.load("lib/RCudaKMeans.so")
    matrix_dim = 0
    nrow = 0
    ncol = 0
    if (is.matrix(data) == TRUE) {
        matrix_size = dim(data)
        matrix_dim = length(matrix_size)
        nrow = matrix_size[1]
        ncol = matrix_size[2]
    }
    else {
        if (is.null(dim(data))) {
            print("IS VECTOR")
            matrix_dim = 1
            nrow = 1
            ncol = length(data)
        }
        else {
            print("PROBLEME")
            matrix_size = dim(data)
            matrix_dim = length(matrix_size)
            nrow = matrix_size[1]
            ncol = matrix_size[2]
        }
    }
    nnn = vector(length = nCluster * ncol, mode = "numeric")
    out <- .C("CudaKMean", data = data, dim = as.integer(matrix_dim), 
        nrow = as.integer(nrow), ncol = as.integer(ncol), nCluster = as.integer(nCluster), 
        answer = nnn)
    return(out)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
