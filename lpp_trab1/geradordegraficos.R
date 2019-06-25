library(ggplot2)
print(setwd("/media/moutella/faculdade/lpp/lpp_trab1/"))
filevets <- c("openmp/openmp1024.txt","openmp/openmpmuitostraps.txt","mpi/mpi1024.txt","mpi/mpimuitos.txt","H1024.txt","muitos.txt")
total = length(filevets)
fc = 1
cores=c("blue", "blue", "red", "red", "purple", "purple")
medias2a10  = c()
medias2a30 = c()
while(fc < total+1){
  conn <- file(filevets[fc], "r")
  linn <- readLines(conn)
  v <- c()
  i = 3
  media = 0
  while(i < length(linn)){
    #print(linn[i])
    res = 0
    if(nchar(linn[i]) > 13){
      res = as.numeric(gsub(",", ".", substr(linn[i], 8, 13)))
      v <- c(v,res)
      print("oi")
    }
    else{
      res = as.numeric(gsub(",", ".", substr(linn[i], 8, 12)))
      v <- c(v,res)  
    }
    media = media + res
    i = i+4
    
  }
  media = media/length(v)
  if(fc %% 2){
    medias2a10 <- c(medias2a10, media)
  }
  else{
    medias2a30 <- c(medias2a30, media)
  }
  close(conn)  

  string = ""
  if(fc == 1){
    string = "OpenMP para 1024 trapézios e 4 threads  \n"
  
  }
  if(fc ==2){
    string = "OpenMP para 1024³ trapézios e 4 threads  \n"  
   
  }
  if(fc ==3){
    string = "MPI para 1024 trapézios e 4 processos \n"
  }
  if(fc ==4){
    string = "MPI para 1024³ trapézios e 4 processos \n"
  }
  if(fc ==5){
    string = "MPI e OpenMP para 1024 trapézios com \n 2 processos, 2 threads por processo \n"
  }
  if(fc ==6){
    string = "MPI e OpenMP para 1024³ trapézios com \n 2 processos e 2 threads por processo \n"
  }
  
  string = paste(string,paste("Média:",toString(media), "segundos"))
  
  min = min(v)
  max = max(v)

  hist(v, 
       main=string, 
       xlab="Tempo (s)",
       ylab = "Número de Ocorrências",
       xlim=c(min,max),
       ylim=c(0,70),
       las=1, 
       breaks=7
       ,col=cores[fc])  

  fc = fc+1
}
#barplot(medias2a10, col=rainbow(3), ylim=c(0,0.1))
  df <- data.frame(prog=as.factor(c("openMP", "MPI",
                          "Híbrido")), medias2a10)
  df$prog
  df = cbind(df, cor=c("openMP", "MPI", "Híbrido"))
  df$prog <- factor(df$prog, levels = c("openMP", "MPI", "Híbrido")) 
  df$prog
  ggplot(data=df, aes(x=prog, y=medias2a10, fill=cor)) +
    geom_bar(stat="identity") + 
    geom_text(aes(label=medias2a10), position=position_dodge(width=0.9), vjust=-0.25) +
    scale_fill_manual("Legenda", 
                      values = c("MPI" = "red", 
                                 "openMP" = "blue", 
                                 "Híbrido" = "purple")) +
    labs(y="Tempo Médio 1024t(segundos)", x="Programa")+
    theme(axis.text.x = element_text(face="bold"),
          axis.text.y = element_text(face="bold"))
  
  
#barplot(medias2a30, col=rainbow(3), angle=45, density = 30, ylim=c(0,16))
  df <- data.frame(prog=c("openMP", "MPI",
                          "Híbrido"), medias2a30)
  df = cbind(df, cor=c("openMP", "MPI", "Híbrido"))
  df$prog <- factor(df$prog, levels = c("openMP", "MPI", "Híbrido")) 
  ggplot(data=df, aes(x=prog, y=medias2a30, fill=cor)) +
    geom_bar(stat="identity") + 
    geom_text(aes(label=medias2a30), position=position_dodge(width=0.9), vjust=-0.25) +
    scale_fill_manual("Legenda", 
                      values = c("MPI" = "red", 
                                 "openMP" = "blue", 
                                 "Híbrido" = "purple")) +
    labs(y="Tempo Médio 1024³t(segundos)", x="Programa") +
    theme(axis.text.x = element_text(face="bold"),
          axis.text.y = element_text(face="bold")) + 
    ylim(0,15)