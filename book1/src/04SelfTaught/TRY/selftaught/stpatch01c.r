## Previous version: sta01a.r
## Created: Jan 18th, 2015.
## This version: try patches

rm(list=ls())

###########################
## making patches
###########################

load('../demoEigenface/loadedFaces.RData')

## disp.pix ##
disp.pix = function(pmat,...){
  image(t(matrix(apply(t(pmat),1,rev),112, 92,byrow=F)), 
     col=gray(1:256/256), ...)
}

i = sample(40,1)
j = sample(10,1)

disp.pix(persons[[i]][[j]], xaxt='n', yaxt='n')

dim(persons[[i]][[j]])

## Patch size

pSize = 10 ## 10 x 10

## coor. of the top left corner of the patch
startx = 1:(92 - pSize+1)    
starty = 1:(112 - pSize+1)

Npatches = 8000 ## number of patches

sampleXs = sample(startx, Npatches, replace=TRUE)
sampleYs = sample(starty, Npatches, replace=TRUE)
samplePs = sample(40, Npatches, replace=TRUE)
samplePIs = sample(10, Npatches, replace=TRUE)

patch.xy = function(x,y,iperson,pSize=10){

  iperson[y:(y+pSize-1), x:(x+pSize-1)]
}

disp.patch = function(ipatch, pSize=10, ...){
  image(t(matrix(apply(t(ipatch),1,rev),pSize, pSize,byrow=F)), 
     col=gray(1:256/256), ...)
}

par(mfrow=c(10,20))
par(mar=c(0.1,0.1,0,0))

for(j in 1:200){
 i = j 
   patchi = patch.xy(sampleXs[i], sampleYs[i], 
   persons[[samplePs[i]]][[samplePIs[i]]])

 disp.patch(patchi, xaxt='n', yaxt='n')
}

##dev.copy2eps(file='stpatch01aPatches.eps')

######################################################
## Arrange patches into PX: (pSize*pSize) x Npatches
######################################################

PX = matrix(0, (pSize*pSize), Npatches)

for(i in 1:Npatches){
 PX[,i] = matrix( patch.xy(sampleXs[i], sampleYs[i], 
   persons[[samplePs[i]]][[samplePIs[i]]]), ncol=1)
}

par(mfrow=c(10,20))
par(mar=c(0.1,0.1,0,0))

for(i in 1:200){
 disp.patch(PX[,i], xaxt='n', yaxt='n')
}

##save(PX, file='PX.RData')

####################################
## Try Self-Taught on patches (PX)
####################################

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

X = PX    ## Use patches as input

##########################
## Clear out some memory
##########################
rm(PX) 
rm(persons)
rm(Npatches)
rm(patch.xy)
rm(patchi)
rm(samplePIs)
rm(samplePs)
rm(sampleXs)
rm(sampleYs)
rm(startx)
rm(starty)
rm(w0)

gamma = 10
beta = 5

D = nrow(X)
N = ncol(X)
M = 120

Ax = matrix(rnorm(M*N), M, N)
Br = matrix(rnorm(M*D), M, D)

w0 = pack.w(Ax, Br)

rm(Ax) ## to clear out some memory
rm(Br) ## to clear out some memory

##w = optim(w0, fwrap, gwrap, method='BFGS', 
##  hessian=TRUE, control=list(maxit=3000))
## Error: cannot allocate vector of size 152 Kb

maxit = 3000
alpha = 0.001

w = w0
rm(w0)

errlogs = matrix(0, 1, maxit)

errold = fwrap(w, X, beta, gamma, D, N, M)

logt1 = Sys.time()
for(i in 1: maxit){

  gW = gwrap(w, X, beta, gamma, D, N, M)
  wnew = w - alpha * gW

  errnew = fwrap(wnew, X, beta, gamma, D, N, M)

  if( errnew <= errold ){ 
    errlogs[i] = errnew
    errold = errnew
    w = wnew        
  } else {
    alpha = alpha * 0.1
    cat('i ', i, ': alpha ', alpha, '\n')
  }
  if( (i %% 20) == 0 )
  plot(1:i, errlogs[1:i], main='Cost', xlab='epoch', ylab='cost', type='l')

} 
logt2 = Sys.time()
## 40 min.

##save(logt1, logt2, w, errlogs, file='stpatch01cG1.RData')

BREAK HERE Jan 19th, 2015.
####

errlogs = matrix(0, 1, maxit)

logt1 = Sys.time()
for(i in 1: maxit){

  gW = gwrap(w)
  w = w - alpha * gW

  erri = fwrap(w)
  errlogs[i] = erri

  if( erri > 1e10 ) break;

  if( (i %% 20) == 0 )
  plot(1:i, errlogs[1:i], main='Cost', xlab='epoch', ylab='cost', type='l')

} 
logt2 = Sys.time()

##save(logt1, logt2, w, errlogs, file='stpatch01g1a.RData')

errlogs = matrix(0, 1, maxit)

logt1 = Sys.time()
for(i in 1: maxit){

  gW = gwrap(w)
  w = w - alpha * gW

  erri = fwrap(w)
  errlogs[i] = erri

  if( erri > 1e10 ) break;

  if( (i %% 20) == 0 )
  plot(1:i, errlogs[1:i], main='Cost', xlab='epoch', ylab='cost', type='l')

} 
logt2 = Sys.time()

errlogs[3000-1] - errlogs[3000]

##save(logt1, logt2, w, errlogs, file='stpatch01g1b.RData')


errlogs = matrix(0, 1, maxit)

logt1 = Sys.time()
for(i in 1: maxit){

  gW = gwrap(w)
  w = w - alpha * gW

  erri = fwrap(w)
  errlogs[i] = erri

  if( erri > 1e10 ) break;

  if( (i %% 20) == 0 )
  plot(1:i, errlogs[1:i], main='Cost', xlab='epoch', ylab='cost', type='l')

} 
logt2 = Sys.time()

errlogs[3000-1] - errlogs[3000]

##save(logt1, logt2, w, errlogs, file='stpatch01g1c.RData')

########################
## Check results
########################

finalparam = unpack.w(w, D, N, M)

A = finalparam$A
B = finalparam$B

err = X - t(B) %*% A

> sum(err^2)
[1] 4199.049

Xba = t(B) %*% A


p = par(mfcol=c(10,20))
par(mar=c(0.1,0.1,0.1,0))

for(i in 1:100){
i = sample(1:N, 1)
disp.patch(X[,i], yaxt='n', xaxt='n')
disp.patch(Xba[,i], yaxt='n', xaxt='n')
}

par(mfrow=c(1,2))
par(mar=c(3,3,3,1))
hist( colSums(abs(A)) , main='|A|')
hist( sqrt(rowSums(B^2)) , main='||B||')

par(p)

errlogs[2999] - errlogs[3000]

############

#############
## Penalty 2
#############

load('stpatch01g1c.RData')

maxit = 500
alpha= 1e-5

gamma = 100
beta = 10/3

errlogs = matrix(0, 1, maxit)

logt1 = Sys.time()
for(i in 1: maxit){

  gW = gwrap(w)
  w = w - alpha * gW

  erri = fwrap(w)
  errlogs[i] = erri

  if( erri > 1e10 ) break;

  if( (i %% 20) == 0 )
  plot(1:i, errlogs[1:i], main='Cost', xlab='epoch', ylab='cost', type='l')

} 
logt2 = Sys.time()

errlogs[maxit-1] - errlogs[maxit]

##save(logt1, logt2, w, errlogs, file='stpatch01betag2.RData')

maxit = 1000
alpha= 1e-5

gamma = 100
beta = 10/3

errlogs = matrix(0, 1, maxit)

logt1 = Sys.time()
for(i in 1: maxit){

  gW = gwrap(w)
  w = w - alpha * gW

  erri = fwrap(w)
  errlogs[i] = erri

  if( erri > 1e10 ) break;

  if( (i %% 20) == 0 )
  plot(1:i, errlogs[1:i], main='Cost', xlab='epoch', ylab='cost', type='l')

} 
logt2 = Sys.time()

errlogs[maxit-1] - errlogs[maxit]

##save(logt1, logt2, w, errlogs, file='stpatch01betag2a.RData')

maxit = 1000
alpha= 1e-5

gamma = 100
beta = 10/3

errlogs = matrix(0, 1, maxit)

logt1 = Sys.time()
for(i in 1: maxit){

  gW = gwrap(w)
  w = w - alpha * gW

  erri = fwrap(w)
  errlogs[i] = erri

  if( erri > 1e10 ) break;

  if( (i %% 20) == 0 )
  plot(1:i, errlogs[1:i], main='Cost', xlab='epoch', ylab='cost', type='l')

} 
logt2 = Sys.time()

errlogs[maxit-1] - errlogs[maxit]

##save(logt1, logt2, w, errlogs, file='stpatch01betag2b.RData')

maxit = 1000
alpha= 1e-5

gamma = 100
beta = 10/3

errlogs = matrix(0, 1, maxit)

logt1 = Sys.time()
for(i in 1: maxit){

  gW = gwrap(w)
  w = w - alpha * gW

  erri = fwrap(w)
  errlogs[i] = erri

  if( erri > 1e10 ) break;

  if( (i %% 20) == 0 )
  plot(1:i, errlogs[1:i], main='Cost', xlab='epoch', ylab='cost', type='l')

} 
logt2 = Sys.time()

errlogs[maxit-1] - errlogs[maxit]

##save(logt1, logt2, w, errlogs, file='stpatch01betag2c.RData')

maxit = 1000
alpha= 1e-5

gamma = 100
beta = 10/3

errlogs = matrix(0, 1, maxit)

logt1 = Sys.time()
for(i in 1: maxit){

  gW = gwrap(w)
  w = w - alpha * gW

  erri = fwrap(w)
  errlogs[i] = erri

  if( erri > 1e10 ) break;

  if( (i %% 20) == 0 )
  plot(1:i, errlogs[1:i], main='Cost', xlab='epoch', ylab='cost', type='l')

} 
logt2 = Sys.time()

errlogs[maxit-1] - errlogs[maxit]
##save(logt1, logt2, w, errlogs, file='stpatch01betag2d.RData')

maxit = 3000
alpha= 1e-5

gamma = 100
beta = 10/3

errlogs = matrix(0, 1, maxit)

logt1 = Sys.time()
for(i in 1: maxit){

  gW = gwrap(w)
  w = w - alpha * gW

  erri = fwrap(w)
  errlogs[i] = erri

  if( erri > 1e10 ) break;

  if( (i %% 20) == 0 )
  plot(1:i, errlogs[1:i], main='Cost', xlab='epoch', ylab='cost', type='l')

} 
logt2 = Sys.time()

errlogs[maxit-1] - errlogs[maxit]
##save(logt1, logt2, w, errlogs, file='stpatch01betag2e.RData')

maxit = 3000
alpha= 1e-5

gamma = 100
beta = 10/3

errlogs = matrix(0, 1, maxit)

logt1 = Sys.time()
for(i in 1: maxit){

  gW = gwrap(w)
  w = w - alpha * gW

  erri = fwrap(w)
  errlogs[i] = erri

  if( erri > 1e10 ) break;

  if( (i %% 20) == 0 )
  plot(1:i, errlogs[1:i], main='Cost', xlab='epoch', ylab='cost', type='l')

} 
logt2 = Sys.time()

errlogs[maxit-1] - errlogs[maxit]
##save(logt1, logt2, w, errlogs, file='stpatch01betag2f.RData')

#############
## Penalty 3
#############

load('stpatch01g2f.RData')

maxit = 500
alpha= 1e-5

gamma = 1e3
beta = 10/3

errlogs = matrix(0, 1, maxit)

logt1 = Sys.time()
for(i in 1: maxit){

  gW = gwrap(w)
  w = w - alpha * gW

  erri = fwrap(w)
  errlogs[i] = erri

  if( erri > 1e10 ) break;

  if( (i %% 20) == 0 )
  plot(1:i, errlogs[1:i], main='Cost', xlab='epoch', ylab='cost', type='l')

} 
logt2 = Sys.time()

errlogs[maxit-1] - errlogs[maxit]

##save(logt1, logt2, w, errlogs, file='stpatch01betag3.RData')

maxit = 5000
alpha= 1e-5

gamma = 1e3
beta = 10/3

errlogs = matrix(0, 1, maxit)

logt1 = Sys.time()
for(i in 1: maxit){

  gW = gwrap(w)
  w = w - alpha * gW

  erri = fwrap(w)
  errlogs[i] = erri

  if( erri > 1e10 ) break;

  if( (i %% 20) == 0 )
  plot(1:i, errlogs[1:i], main='Cost', xlab='epoch', ylab='cost', type='l')

} 
logt2 = Sys.time()

errlogs[maxit-1] - errlogs[maxit]

##save(logt1, logt2, w, errlogs, file='stpatch01betag3a.RData')

maxit = 5000
alpha= 1e-5

gamma = 1e3
beta = 10/3

errlogs = matrix(0, 1, maxit)

logt1 = Sys.time()
for(i in 1: maxit){

  gW = gwrap(w)
  w = w - alpha * gW

  erri = fwrap(w)
  errlogs[i] = erri

  if( erri > 1e10 ) break;

  if( (i %% 20) == 0 )
  plot(1:i, errlogs[1:i], main='Cost', xlab='epoch', ylab='cost', type='l')

} 
logt2 = Sys.time()

errlogs[maxit-1] - errlogs[maxit]

##save(logt1, logt2, w, errlogs, file='stpatch01betag3b.RData')

#############
## Penalty 4
#############

load('stpatch01g3b.RData')

maxit = 500
alpha= 1e-5

gamma = 1e4
beta = 10/3

errlogs = matrix(0, 1, maxit)

logt1 = Sys.time()
for(i in 1: maxit){

  gW = gwrap(w)
  w = w - alpha * gW

  erri = fwrap(w)
  errlogs[i] = erri

  if( erri > 1e10 ) break;

  if( (i %% 20) == 0 )
  plot(1:i, errlogs[1:i], main='Cost', xlab='epoch', ylab='cost', type='l')

} 
logt2 = Sys.time()

errlogs[maxit-1] - errlogs[maxit]

##save(logt1, logt2, w, errlogs, file='stpatch01betag4.RData')

maxit = 3000
alpha= 1e-5

gamma = 1e4
beta = 10/3

errlogs = matrix(0, 1, maxit)

logt1 = Sys.time()
for(i in 1: maxit){

  gW = gwrap(w)
  w = w - alpha * gW

  erri = fwrap(w)
  errlogs[i] = erri

  if( erri > 1e10 ) break;

  if( (i %% 20) == 0 )
  plot(1:i, errlogs[1:i], main='Cost', xlab='epoch', ylab='cost', type='l')

} 
logt2 = Sys.time()

errlogs[maxit-1] - errlogs[maxit]

##save(logt1, logt2, w, errlogs, file='stpatch01betag4a.RData')

maxit = 3000
alpha= 1e-5

gamma = 1e4
beta = 10/3

errlogs = matrix(0, 1, maxit)

logt1 = Sys.time()
for(i in 1: maxit){

  gW = gwrap(w)
  w = w - alpha * gW

  erri = fwrap(w)
  errlogs[i] = erri

  if( erri > 1e10 ) break;

  if( (i %% 20) == 0 )
  plot(1:i, errlogs[1:i], main='Cost', xlab='epoch', ylab='cost', type='l')

} 
logt2 = Sys.time()

errlogs[maxit-1] - errlogs[maxit]

##save(logt1, logt2, w, errlogs, file='stpatch01betag4b.RData')

load('stpatch01betag4b.RData')
maxit = 5000
alpha= 1e-5

gamma = 1e4
beta = 10/3

errlogs = matrix(0, 1, maxit)

logt1 = Sys.time()
for(i in 1: maxit){

  gW = gwrap(w)
  w = w - alpha * gW

  erri = fwrap(w)
  errlogs[i] = erri

  if( erri > 1e10 ) break;

  if( (i %% 20) == 0 )
  plot(1:i, errlogs[1:i], main='Cost', xlab='epoch', ylab='cost', type='l')

} 
logt2 = Sys.time()

errlogs[maxit-1] - errlogs[maxit]

##save(logt1, logt2, w, errlogs, file='stpatch01betag4c.RData')

load('stpatch01betag4c.RData')

########################
## Check results
########################

finalparam = unpack.w(w, D, N, M)

A = finalparam$A
B = finalparam$B

err = X - t(B) %*% A

> sum(err^2)
[1] 8982.077

Xba = t(B) %*% A


p = par(mfcol=c(10,20))
par(mar=c(0.1,0.1,0.1,0))

for(i in 1:100){
i = sample(1:N, 1)
disp.patch(X[,i], yaxt='n', xaxt='n')
disp.patch(Xba[,i], yaxt='n', xaxt='n')
}

par(mfrow=c(1,2))
par(mar=c(3,3,3,1))
hist( colSums(abs(A)) , main='|A|')
hist( sqrt(rowSums(B^2)) , main='||B||')

p = par(mfcol=c(5,10))
par(mar=c(0.1,0.1,0.1,0))

for(i in 1:50){
  disp.patch(B[i,], yaxt='n', xaxt='n')
}

par(p)

errlogs[maxit-1] - errlogs[maxit]

