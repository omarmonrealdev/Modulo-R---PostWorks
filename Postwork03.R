# Postwork Sesión 3

#### Objetivo

#- Realizar un análisis descriptivo de las variables de un dataframe

#### Requisitos

#1. R, RStudio
#2. Haber realizado el prework y seguir el curso de los ejemplos de la sesión
#3. Curiosidad por investigar nuevos tópicos y funciones de R

#### Desarrollo

"Utilizando el dataframe `boxp.csv` realiza el siguiente análisis descriptivo. No olvides excluir los missing values y transformar las variables a su
tipo y escala correspondiente."
df <- read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2022/main/Sesion-03/Data/boxp.csv")

dim(df) #615 x 3

df <- na.omit(df)

dim(df) #591 x 3

df$Grupo <- factor(df$Grupo)

df$Categoria <- factor(df$Categoria, levels = c("C1", "C2", "C3"), ordered = TRUE)

summary(df)

#1) Calcula e interpreta las medidas de tendencia central de la variable `Mediciones`
library(DescTools)

Mode(df$Mediciones)[1]
median(df$Mediciones)
mean(df$Mediciones)



#moda < mediana < media

#Existe una distribucion con sesgo a la derecha


#2) Con base en tu resultado anterior, ¿qué se puede concluir respecto al sesgo de `Mediciones`?

#Existe un sesgo a la derecha, hay datos atipicos por encima de la media


#3) Calcula e interpreta la desviación estándar y los cuartiles de la distribución de `Mediciones`

sd(df$Mediciones) #53.76
#Existen algunos datos alejandos de la media, los datos estan dispersos respecto a la media

cuartiles <- quantile(df$Mediciones, probs = c(0.25, 0.50, 0.75))
cuartiles
#25% de las mediciones tiene valor <= a 23.45
#50% de las mediciones tienen valor <= a 49.30
#75% de las mediciones tienen valor <= a 82.85

"4) Con ggplot, realiza un histograma separando la distribución de `Mediciones` por `Categoría`
¿Consideras que sólo una categoría está generando el sesgo?"


#Los histogramas muestran que las tres categorias generan el sesgo a la derecha
#Aunque podria decirse que la de mayor influencia es la categoria 3

library(dplyr)
library(ggplot2)

df.C1 <- filter(df, Categoria == "C1")
df.C2 <- filter(df, Categoria == "C2")
df.C3 <- filter(df, Categoria == "C3")

hist(df.C1$Mediciones, main = "Histograma Categoria 1", xlab = "Mediciones", ylab = "Frecuencia") 
hist(df.C2$Mediciones, main = "Histograma Categoria 2", xlab = "Mediciones", ylab = "Frecuencia") 
hist(df.C3$Mediciones, main = "Histograma Categoria 3", xlab = "Mediciones", ylab = "Frecuencia") 


#Utilizando ggplot filtrando los datos con SUBSET
ggplot(df, aes(Mediciones)) +  
  geom_histogram(data = subset(df, Categoria=="C1"),fill="blue", colour= "black") +
  geom_histogram(data = subset(df, Categoria=="C2"),fill="red", colour= "black") + 
  geom_histogram(data = subset(df, Categoria=="C3"),fill="green", colour= "black") +
  labs(title = "Histograma de mediciones por Categoria", x = "Mediciones/Categoria", y = "Frecuencia")

#Resumiendo todo lo anterior en una sola linea
ggplot(df, aes(Mediciones,  fill = Categoria)) + geom_histogram(bins = 20) + labs(title = "Histograma") + theme_classic()

"5) Con ggplot, realiza un boxplot separando la distribución de `Mediciones` por `Categoría` 
y por `Grupo` dentro de cada categoría. ¿Consideras que hay diferencias entre categorías? ¿Los grupos al interior de cada categoría 
podrían estar generando el sesgo?"

df.C1.G0 <- filter(df.C1, Grupo == "0")
df.C1.G1 <- filter(df.C1, Grupo == "1")
df.C2.G0 <- filter(df.C2, Grupo == "0")
df.C2.G1 <- filter(df.C2, Grupo == "1")
df.C3.G0 <- filter(df.C3, Grupo == "0")
df.C3.G1 <- filter(df.C3, Grupo == "1")


#Boxplots individuales
boxplot(df.C1.G0$Mediciones, horizontal = TRUE) 
boxplot(df.C1.G1$Mediciones, horizontal = TRUE) 
boxplot(df.C2.G0$Mediciones, horizontal = TRUE) 
boxplot(df.C2.G1$Mediciones, horizontal = TRUE) 
boxplot(df.C3.G0$Mediciones, horizontal = TRUE)
boxplot(df.C3.G1$Mediciones, horizontal = TRUE)

#Boxplots tomando todos los grupos
boxplot(df.C1.G0$Mediciones, df.C1.G1$Mediciones,
        df.C2.G0$Mediciones, df.C2.G1$Mediciones,
        df.C3.G0$Mediciones, df.C3.G1$Mediciones, horizontal = TRUE) 

#Resumiendo todo lo anterior en una sola linea
ggplot(df, aes(x = Mediciones, y = Categoria, fill = Grupo)) + geom_boxplot() + theme_dark()

#Si existen diferencias entre categorias
#La categoria 3 - grupo 0 y en menor medida la categoria 2 - grupo 0, son las que
#generan el sesgo en los datos

