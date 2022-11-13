#1. Del siguiente enlace, descarga los datos de soccer de la temporada 2019/2020 de la primera división de la liga española: https://www.football-data.co.uk/spainm.php

#2. Importa los datos a R como un Dataframe. NOTA: No olvides cambiar tu dirección de trabajo a la ruta donde descargaste tu archivo

sp1 <- read.csv("SP1.csv")
View(sp1)

#3. Del dataframe que resulta de importar los datos a `R`, extrae las columnas que contienen los números de goles anotados por los equipos que jugaron en casa (FTHG) y los goles anotados por los equipos que jugaron como visitante (FTAG); guárdalos en vectores separados

golesAnotadosCasa <- c(sp1$FTHG)
golesAnotadosCasa

golesAnotadosVisita <- c(sp1$FTAG)
golesAnotadosVisita

sumatoriaGoles <- golesAnotadosCasa + golesAnotadosVisita



#a) ¿Cuántos goles tuvo el partido con mayor empate?
tablaDeGoles <- data.frame (golesAnotadosCasa, golesAnotadosVisita, sumatoriaGoles)

empates <- subset(tablaDeGoles, golesAnotadosCasa == golesAnotadosVisita)

max(empates$sumatoriaGoles) 

# Respuesta: 8 goles, mayor empate 4-4


#b) ¿En cuántos partidos ambos equipos empataron 0 a 0?
sumaGlobalGoles <- data.frame(table(sumatoriaGoles))

View(subset(sumaGlobalGoles, sumatoriaGoles == 0)) 

# Respuesta 33 empates a 0


#c) ¿En cuántos partidos el equipo local (HG) tuvo la mayor goleada sin dejar que el 
#equipo visitante (AG) metiera un solo gol?

visitaCero <- subset(tablaDeGoles, golesAnotadosVisita == 0)

visitaCero$sumatoriaGoles <- NULL

View (table(visitaCero$golesAnotadosCasa, visitaCero$golesAnotadosVisita))

# Respuesta: 1 partido (6 a 0)


