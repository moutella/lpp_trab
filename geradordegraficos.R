conn <- file("openmp/openmp1024.txt", "r")
linn <- readLines(conn)
v <- c()
i = 2
while(i < length(linn)){
  print(linn[i])
  v <- c(v,as.numeric(gsub(",", ".", substr(linn[i], 8, 12))))
  i = i+4

}
close(conn)

hist(v, 
     main="OpenMP para 1024 trapezios : \n  ", 
     xlab="Números",
     ylab = "Frequência",
     xlim=c(0,max(v)),
     ylim=c(0,100),
     las=1, 
     breaks=5)

#substr(s, 6, 12)
#as.numeric(gsub(",", ".", substr(s, 8, 12)))

#as.numeric(gsub(",", ".", substr(s, 6, 6))) * 60
