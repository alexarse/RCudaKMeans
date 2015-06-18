library(RCudaKMeans)

ncol = 3
nrow = 100

v = c();
for(i in 1:nrow)
{
	v = c(v, runif(ncol, 5.0, 7.5))
}

vec = matrix(data = v, nrow = nrow, ncol = ncol, byrow=TRUE)

nCluster = 2;

print("START CUDA KMEAN")

answer = CudaKMean(vec, nCluster)

print(answer);


