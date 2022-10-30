plot(xs, abs(xs), type='l')
lines(xs, xs^2, col='blue')
abline(h=0.8, lty=2, col='cyan')
abline(h=0.2, lty=2, col='cyan')

lines(xs, 1-exp(-abs(xs*10)), col='green')

##
plot(xs, abs(xs), type='l')
lines(xs, 1-exp(-abs(xs*1)), col='red')
lines(xs, 1-exp(-abs(xs*2)), col='yellow')
lines(xs, 1-exp(-abs(xs*10)), col='green')
lines(xs, 1-exp(-abs(xs*100)), col='blue')

abline(h=0.2,col='cyan',lty=2)

##
plot(xs, abs(xs), type='l')
lines(xs, xs^5, col='green')
lines(xs, 1-xs^5, col='green')
