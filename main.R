source("r_source/SimpleExample.R")

ncol = 3
nrow = 20000

v = c();
for(i in 1:nrow)
{
	v = c(v, runif(ncol, 5.0, 7.5))
	# v.append(runif(ncol, 5.0, 7.5));
}
# l1 <- runif(ncol, 5.0, 7.5)
# l2 <- runif(ncol, 5.0, 7.5)
# l3 <- runif(ncol, 5.0, 7.5)
# l4 <- runif(ncol, 5.0, 7.5)
# l5 <- runif(ncol, 5.0, 7.5)
# l6 <- runif(ncol, 5.0, 7.5)

# Row vector matrix.
# vec = matrix(data = c(l1, l2, l3, l4, l5, l6), nrow = 6, ncol = ncol, byrow=TRUE)
vec = matrix(data = v, nrow = nrow, ncol = ncol, byrow=TRUE)



# # Row vector matrix.
# # vec = matrix(data = c(1, 2, 3, 4, 5, 
# # 					  6, 7, 8, 9, 10), nrow = 2, ncol = 5, byrow=TRUE)


nCluster = 2;

print("START CUDA KMEAN")
# # # print(vec)
answer = CudaKMean(vec, nCluster)

# print(answer)

ddd = matrix(data = answer$answer, nrow = nCluster, ncol = ncol, byrow=FALSE)



# print(ddd)

# print("TEST")
gg <- ddd[ order( ddd[,1]), ]
# gg <- sort(ddd, method = "quick")

# sort(ddd(1,:));


# ddd[order(ddd$V1),]

print(gg)

# algorithm = c("Hartigan-Wong", "Lloyd", "Forgy",
#                      "MacQueen")
# # Needs column vector.
print("R KMEAN")
answerKMean = kmeans(vec, nCluster, iter.max = 10,)# algorithm = c("Hartigan-Wong"))
ddd = matrix(data = answerKMean$centers, nrow = nCluster, ncol = ncol, byrow=FALSE)
# print(answerKMean$centers)
# print(ddd)
gg <- ddd[ order( ddd[,1]), ]
print(gg)

