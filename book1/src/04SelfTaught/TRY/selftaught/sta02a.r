## Previous version: sta01a.r
## Created: Jan 18th, 2015.
## This version: try Penalty Method with larger A and M = 100
## To see if features (B) seem better
## By better features, it means that it picks up only a specific aspect, not replicate any image

rm(list=ls())

## disp.pix ##

disp.pix = function(pmat,...){
  image(t(matrix(apply(t(pmat),1,rev),112, 92,byrow=F)), 
     col=gray(1:256/256), ...)
}

load('ImgGamma.RData')

i = sample(1:400,1)

disp.pix(Gamma[,i], main='Gamma', xaxt='n', yaxt='n')

###################
## Try Self-Taught
###################

## input X: D x N
## Ax: M x N
## Br: M x D
## approx. model for X[,i]: y = t(Br) %*% Ax[,i] ## D x 1


## Step 1: find b
## min {b, a} sum_i || x[i] - y(a[i],b) || + beta sum_j |a[i,j]|
## s.t. ||b[j]|| <= 1


###########################
## Objective Function
###########################

obf = function(X, Ax, Br, beta, gamma){
  err   = sum( (X - t(Br) %*% Ax)^2 )
  spar  = sum( abs(Ax) )
  acti  = sqrt( rowSums(Br^2) )

  Penalty = sum( apply( as.matrix(acti - 1) , 1, oplus)^2 )

return( err + beta*spar + gamma*Penalty )
}##end obf

###########################
## Violation Function
###########################

oplus = function(x){
  x * (x > 0)
}

###########################
## Gradient
###########################

gradf = function(X, Ax, Br, beta, gamma){
  t1 = (X - t(Br) %*% Ax)            ## D x N
  t2 = Ax %*% t(t1)                  ## M x D

  gB = -2 * t2                       ## M x D

  t3 = Br %*% t1                     ## M x N

  gA = -2 * t3 + beta * Ax/abs(Ax)   ## M x N

  t4 = sqrt(rowSums(Br^2))           ## M x 1: || b_m ||

  t5 = 2 * oplus( t4 - 1 )           ## M x 1
  t6 = matrix(t4, M, D)              ## M x D

  t7 = Br / t6                       ## M x D

  gP = matrix(t5, M, D) * t7         ## M x D
  
return(list(gA=gA, gB=(gB+gamma*gP)))
}##end gradf

###########################################
## pack.w and unpack.w
###########################################

pack.w = function(Ap, Bp){
c(Ap, Bp)
}

unpack.w = function(w, D, N, M){
  Ap = matrix(w[1:(M*N)], M, N, byrow=F)
  Bp = matrix(w[-( 1:(M*N) )], M, D, byrow=F)

return(list(A=Ap, B=Bp))
}

########################
## Wrapping Functions ##
########################

fwrap = function(w, X, beta, gamma, D, N, M){
  AB = unpack.w(w, D, N, M)
return( obf(X, AB$A, AB$B, beta, gamma) )
}

gwrap = function(w, X, beta, gamma, D, N, M){
  AB = unpack.w(w, D, N, M)
  gW = gradf(X, AB$A, AB$B, beta, gamma)
return( c(gW$gA, gW$gB) )
}

####################################################
## Test Objective and Gradient Functions in Action
####################################################

X = Gamma
rm(Gamma) ## to clear out some memory

D = nrow(X)
N = ncol(X)

M = 100

Ax = matrix(rnorm(M*N), M, N)
Br = matrix(rnorm(M*D), M, D)

w0 = pack.w(Ax, Br)

rm(Ax) ## to clear out some memory
rm(Br) ## to clear out some memory

epsilon = 1e-5

maxit = 500

w = w0

##w = optim(w, fwrap, gradwrap, method='BFGS', hessian=TRUE, control=list(maxit=3000))
##Reached total allocation of 4078Mb

chkB = Inf
errold = Inf
gP = 1
ri = 0

while(TRUE){  
  gamma = 10^gP
  beta = gamma/10

  errlogs = matrix(0, 1, maxit)
  alpha = 0.001
   
  ri = ri + 1
  logt1 = Sys.time()
  for(i in 1: maxit){

    gW = gwrap(w, X, beta, gamma, D, N, M)
    wnew = w - alpha * gW

    erri = fwrap(wnew, X, beta, gamma, D, N, M)
    errlogs[i] = erri

    if( (erri > 1e10) | (erri > errold) ){
    ## step size is too large

      alpha = alpha*0.1
      wnew = w
      erri = errold
    }

    w = wnew
    errold = erri

    if( (i %% 20) == 0 )
    plot(1:i, errlogs[1:i], 
      main=paste('gamma ', gamma, '; chkB ', chkB), 
      xlab='epoch', ylab='cost', type='l')

  } 
  logt2 = Sys.time()

fname = paste('sta02g',gP,'r',ri,sep='')
save(logt1, logt2, w, alpha, errlogs, file=fname)

  if( (errlogs[i-1] - errlogs[i])/errlogs[i-1] < epsilon ){
  ## approx. converge.
    gP = gP + 1
    ri = 0
  }

  finalparam = unpack.w(w, D, N, M)
  A = finalparam$A
  B = finalparam$B
  chkB = min( sqrt(rowSums(B^2)) )
  if(  chkB <= 1 ) break;

  err = X - t(B) %*% A
  cat('Gamma ', gamma, '; err.:', sum(err^2), '; chkB ', chkB, 
    '; runtime ', round(logt2 - logt1),
    '\n', sep='')

}##end while
####################################################


