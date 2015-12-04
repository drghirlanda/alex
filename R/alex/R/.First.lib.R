.First.lib <- function( libname, pkgname ) {
  if( !require(data.table) ) {
    stop("required package 'data.table' is not installed")
  }
  if( !require(foreach) ) {
    stop("required package 'foreach' is not installed")
  }
  if( require(doParallel) ) {
    registerDoParallel( cores=4 )
  } else {
    warning("you can install package 'doParallel' for faster operation")
  }
}
