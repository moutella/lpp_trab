filevets <- c("resultados/mpi.txt", "resultados/openmpcritical.txt","resultados/openmpreduce.txt","resultados/extra.txt","resultados/sections.txt","resultados/dynamic.txt")
total = length(filevets)
fc = 1
while(fc < total+1){
  conn <- file(filevets[fc], "r")
  linn <- readLines(conn)
  v <- c()
  i = 2
  media = 0
  while(i < length(linn)){
    print(linn[i])
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
  close(conn)  
  
  string = ""
  if(fc == 1){
    string = "Produto Esclar: MPI 4 Processos  \n"
    
  }
  if(fc ==2){
    string = "Produto Escalar: openMP 4 threads (Critical)  \n"  
    
  }
  if(fc ==3){
    string = "Produto Escalar: openMP 4 threads (Reduce) \n"
  }
  if(fc ==4){
    string = "Produto Escalar: openMP 4 threads (Forma alternativa) \n"
  }
  if(fc ==5){
    string = "Sections (Paralelismo Funcional): openMP 4 threads \n"
  }
  if(fc ==6){
    string = "Produto Escalar: openMP 4 threads (Critical) (Dynamic) \n"
  }
  
  string = paste(string,paste("Média:",toString(media),sep=" "  ),sep=" "  )
  
  min = min(v)
  max = max(v)
  # if(max < 1){
  #    min = floor(min)
  #  }
  
  hist(v, 
       main=string, 
       xlab="Tempos",
       ylab = "Frequência",
       xlim=c(min,max),
       ylim=c(1,150),
       las=1, 
       breaks=7)  
  
  fc = fc+1
}





#substr(s, 6, 12)
#as.numeric(gsub(",", ".", substr(s, 8, 12)))

#as.numeric(gsub(",", ".", substr(s, 6, 6))) * 60
