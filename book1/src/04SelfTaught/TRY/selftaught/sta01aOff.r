Approx.errs = matrix(0, 1, 6)

ri = sample(1:N, 5)
##save(ri, file='ri.RData')
rb = sample(50, 10)
rv = seq(1, 10304, 100) 
##save(rb,file='rbrv.RData')

sampleBs = matrix(0, 10304, 6)

###################################
load('sta01ag1x64.RData')

finalparam = unpack.w(w, D, N, M)
A = finalparam$A
B = finalparam$B
err = X - t(B) %*% A
Approx.errs[1] = sum(err^2)

Xba = t(B) %*% A
p = par(mfcol=c(2,5))
par(mar=c(0,0,0,0))
for(i in 1:5){
  disp.pix(X[,ri[i]], yaxt='n', xaxt='n')
  disp.pix(Xba[,ri[i]], yaxt='n', xaxt='n')
}

#dev.copy2eps(file='g1approx.eps')

par(mfrow=c(2,5))
par(mar=c(0,0,0,0))
for(j in 1:10){
  disp.pix(B[rb[j],], xaxt='n', yaxt='n')
}
#dev.copy2eps(file='g1B.eps')

sampleBs[,1] = B[mx,]
disp.pix(sampleBs[,1])

qA = quantile(colSums(abs(A)), probs=c(0, 0.25, 0.5, 0.75, 1))
qB = quantile(sqrt(rowSums(B^2)), probs=c(0, 0.25, 0.5, 0.75, 1))

##save(qA,qB, file='g1qAB.RData')

mx = which.max(sqrt(rowSums(B^2)))


###########################################
load('sta01ag2c.RData')

finalparam = unpack.w(w, D, N, M)
A = finalparam$A
B = finalparam$B
err = X - t(B) %*% A
Approx.errs[2] = sum(err^2)

Xba = t(B) %*% A
p = par(mfcol=c(2,5))
par(mar=c(0,0,0,0))
for(i in 1:5){
  disp.pix(X[,ri[i]], yaxt='n', xaxt='n')
  disp.pix(Xba[,ri[i]], yaxt='n', xaxt='n')
}

#dev.copy2eps(file='g2approx.eps')

par(mfrow=c(2,5))
par(mar=c(0,0,0,0))
for(j in 1:10){
  disp.pix(B[rb[j],], xaxt='n', yaxt='n')
}
#dev.copy2eps(file='g2B.eps')

sampleBs[,2] = B[mx,]
disp.pix(sampleBs[,2])

which.max(sqrt(rowSums(B^2)))

qA = quantile(colSums(abs(A)), probs=c(0, 0.25, 0.5, 0.75, 1))
qB = quantile(sqrt(rowSums(B^2)), probs=c(0, 0.25, 0.5, 0.75, 1))

##save(qA,qB, file='g2qAB.RData')

###############################

load('sta01ag3a.RData')

finalparam = unpack.w(w, D, N, M)
A = finalparam$A
B = finalparam$B
err = X - t(B) %*% A
Approx.errs[3] = sum(err^2)

Xba = t(B) %*% A
p = par(mfcol=c(2,5))
par(mar=c(0,0,0,0))
for(i in 1:5){
  disp.pix(X[,ri[i]], yaxt='n', xaxt='n')
  disp.pix(Xba[,ri[i]], yaxt='n', xaxt='n')
}

#dev.copy2eps(file='g3approx.eps')

par(mfrow=c(2,5))
par(mar=c(0,0,0,0))
for(j in 1:10){
  disp.pix(B[rb[j],], xaxt='n', yaxt='n')
}
#dev.copy2eps(file='g3B.eps')

sampleBs[,3] = B[mx,]
disp.pix(sampleBs[,3])

sum( (sampleBs[,2] - sampleBs[,3])^2 )

qA = quantile(colSums(abs(A)), probs=c(0, 0.25, 0.5, 0.75, 1))
qB = quantile(sqrt(rowSums(B^2)), probs=c(0, 0.25, 0.5, 0.75, 1))

##save(qA,qB, file='g3qAB.RData')



################################

load('sta01ag4c.RData')


finalparam = unpack.w(w, D, N, M)
A = finalparam$A
B = finalparam$B
err = X - t(B) %*% A
Approx.errs[4] = sum(err^2)

Xba = t(B) %*% A
p = par(mfcol=c(2,5))
par(mar=c(0,0,0,0))
for(i in 1:5){
  disp.pix(X[,ri[i]], yaxt='n', xaxt='n')
  disp.pix(Xba[,ri[i]], yaxt='n', xaxt='n')
}

#dev.copy2eps(file='g4approx.eps')

par(mfrow=c(2,5))
par(mar=c(0,0,0,0))
for(j in 1:10){
  disp.pix(B[rb[j],], xaxt='n', yaxt='n')
}
#dev.copy2eps(file='g4B.eps')

sampleBs[,4] = B[mx,]
disp.pix(sampleBs[,4])

sum( (sampleBs[,4] - sampleBs[,3])^2 )

qA = quantile(colSums(abs(A)), probs=c(0, 0.25, 0.5, 0.75, 1))
qB = quantile(sqrt(rowSums(B^2)), probs=c(0, 0.25, 0.5, 0.75, 1))

##save(qA,qB, file='g4qAB.RData')


################################

load('sta01ag5a.RData')

finalparam = unpack.w(w, D, N, M)
A = finalparam$A
B = finalparam$B
err = X - t(B) %*% A
Approx.errs[5] = sum(err^2)

Xba = t(B) %*% A
p = par(mfcol=c(2,5))
par(mar=c(0,0,0,0))
for(i in 1:5){
  disp.pix(X[,ri[i]], yaxt='n', xaxt='n')
  disp.pix(Xba[,ri[i]], yaxt='n', xaxt='n')
}

#dev.copy2eps(file='g5approx.eps')

par(mfrow=c(2,5))
par(mar=c(0,0,0,0))
for(j in 1:10){
  disp.pix(B[rb[j],], xaxt='n', yaxt='n')
}
#dev.copy2eps(file='g5B.eps')

sampleBs[,5] = B[mx,]
disp.pix(sampleBs[,5])

sum( (sampleBs[,4] - sampleBs[,5])^2 )

qA = quantile(colSums(abs(A)), probs=c(0, 0.25, 0.5, 0.75, 1))
qB = quantile(sqrt(rowSums(B^2)), probs=c(0, 0.25, 0.5, 0.75, 1))

##save(qA,qB, file='g5qAB.RData')

################################

load('sta01ag6e.RData')

finalparam = unpack.w(w, D, N, M)
A = finalparam$A
B = finalparam$B
err = X - t(B) %*% A
Approx.errs[6] = sum(err^2)

Xba = t(B) %*% A
p = par(mfcol=c(2,5))
par(mar=c(0,0,0,0))
for(i in 1:5){
  disp.pix(X[,ri[i]], yaxt='n', xaxt='n')
  disp.pix(Xba[,ri[i]], yaxt='n', xaxt='n')
}

#dev.copy2eps(file='g6approx.eps')

par(mfrow=c(2,5))
par(mar=c(0,0,0,0))
for(j in 1:10){
  disp.pix(B[rb[j],], xaxt='n', yaxt='n')
}
#dev.copy2eps(file='g6B.eps')

sampleBs[,6] = B[mx,]
disp.pix(sampleBs[,6])

sum( (sampleBs[,6] - sampleBs[,5])^2 )

qA = quantile(colSums(abs(A)), probs=c(0, 0.25, 0.5, 0.75, 1))
qB = quantile(sqrt(rowSums(B^2)), probs=c(0, 0.25, 0.5, 0.75, 1))

##save(qA,qB, file='g6qAB.RData')


################################

##save(Approx.errs, sampleBs, file='errB.RData')


plot(1:6, Approx.errs)
par(mfrow=c(2,3))
par(mar=c(0,0,0,0))
for(j in 1:6){
  disp.pix(sampleBs[,j], xaxt='n', yaxt='n')
}

par(mfrow=c(2,5))
par(mar=c(3,3,3,1))
##plot(1:6, sampleBs[2996,], type='b')
for(j in 1:10){
  i = sample(10304, 1)
  plot(1:6, sampleBs[i,], type='b', main=paste('i:',i))
}
##dev.copy2eps(file='Bconverges.eps')


############################
## Do boxplot of A and B
############################

qAs = matrix(0, 5, 6)
qBs = matrix(0, 5, 6)


for(i in 1:6){
  fname = paste('g',i,'qAB.RData',sep='')
  load(fname)

  qAs[,i] = qA
  qBs[,i] = qB

}

par(mfrow=c(1,2))
par(mar=c(5,5,3,1))
matplot(t(qAs), pch=c(15,6,8,2,15), 
  col=c('black','blue', 'red', 'blue', 'black'),
#  main='colSums(abs(A))', 
  main='|A|',
  xlab='gamma: power of 10', ylab='|A|')
lines(1:6, qAs[3,], col='red', lty=2)

matplot(t(qBs), pch=c(15,6,8,2,15), 
  col=c('black','blue', 'red', 'blue', 'black'),
#  main='sqrt(rowSums(B^2))', 
  main='||B||',
  xlab='gamma: power of 10', ylab='||B||', ylim=c(0,11))

#abline(h=1, col='yellow')
lines(1:6, qBs[3,], col='red', lty=2)
points(1:6, qBs[3,], col='red', pch=8)
legend(5,10, c('max','q3','q2','q1','min'), pch=c(15,2,8,6,15),
 col=c('black','blue', 'red', 'blue', 'black'))

##dev.copy2eps(file='quantileAB.eps')

########################
## Plot approx errors
########################

load('errB.RData')

plot(1:6, Approx.errs, main='Approx. Errors',
 xlab='gamma: power of 10', ylab='Error',
 type='b')

##dev.copy2eps(file='approxErrors.eps')
