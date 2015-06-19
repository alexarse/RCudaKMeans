CudaKMean <- function(data, nCluster)
{
	dyn.load("lib/RCudaKMeans.so")

	matrix_dim = 0
	nrow = 0
	ncol = 0

	if(is.matrix(data) == TRUE) {
		matrix_size = dim(data)
		matrix_dim = length(matrix_size)
		nrow = matrix_size[1]
		ncol = matrix_size[2]

	} else {

		if(is.null(dim(data)))
		{
			print("IS VECTOR")
			matrix_dim = 1
			nrow = 1
			ncol = length(data)
		} else
		{
			print("PROBLEME")
			matrix_size = dim(data)
			matrix_dim = length(matrix_size)
			nrow = matrix_size[1]
			ncol = matrix_size[2]
		}
	}

	nnn = vector(length=nCluster * ncol, mode="numeric")

	out <- .C("CudaKMean", 
			  data = data, 
			  dim = as.integer(matrix_dim), 
			  nrow = as.integer(nrow), 
			  ncol = as.integer(ncol), 
			  nCluster = as.integer(nCluster),
			  answer = nnn)

	return(matrix(data = out$answer, nrow = nCluster, ncol = ncol, byrow=FALSE))
}
