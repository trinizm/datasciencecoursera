## Put comments here that give an overall description of what your
## functions do:
## The functions below will store the value of the inputted matrix, 
## calculate it's inverse, cache it and/or retrieve if already computed. 
## 1st run: mat<-makeCacheMatrix(m)
## 2nd run: cacheSolve(mat)

## Write a short comment describing this function
## this function creates a list of functions accessing an environment
## that stores a matrix and its inverse

makeCacheMatrix <- function(x = matrix())   
	inv <- NULL	        #initialize the inverse of a matrix
	setmatrix <- function(y) {	      #sets the matrix 
		x <<- y
		#sets the matrix inverse to NULL in case the matrix changed
		inv <<- NULL
		}
	getmatrix <- function() x
	# assign the variable inv to the matrix inverse
	setinverse <- function(solve) inv <<- solve
	getinverse <- function() inv			#get the matrix inverse
	# list of four functions to be passed
	list(setmatrix=setmatrix,
       	     getmatrix=getmatrix,
             setinverse=setinverse,
             getinverse=getinverse)
}


## Write a short comment describing this function
## this function returns, or computes, caches and returns, matrix inverse

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
        ## variable inv becomes matrix inverse if already exists
	inv <- x$getinverse()
	## check if matrix inverse already cached
		if(!is.null(inv) ) {
		message("getting cached inverse matrix")
		# retrieve matrix inverse from the cache
		return(inv)
	        }
## if matrix inverse not cached, then compute the inverse of the matrix
	# get the value of the input matrix 
	mat <- x$getmatrix()
	# inverse the inputted matrix  
	inv <- solve(mat, ...)
	# cache matrix inverse for later use
	x$setinverse(inv)
	message("newly computed inversed matrix")
	# return newly computed matrix inverse
	inv
}
