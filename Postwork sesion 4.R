#Postwork sesion 3

#Desarrollo
#Utilizando la variable total_intl_charge de la base de datos
#telecom_service.csv de la sesión 3, realiza un análisis probabilístico. Para ello,
#debes determinar la función de distribución de probabilidad que más se
#acerque el comportamiento de los datos. Hint: Puedes apoyarte de medidas
#descriptivas o técnicas de visualización.
library(DescTools)


df <- read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2022/main/Sesion-03/Data/telecom_service.csv")
summary(df)

datos <- df$total_intl_charge #3333 cargos registrados

mean <- mean(datos) #2.76
median(datos) #2.78
sd <- sd(datos) #0.7537
Mode(datos) #2.7 con frecuencia de 62
min(datos); max(datos) # los datos van del valor 0 a 5.4 como maximo

#1. Grafica la distribución teórica de la variable aleatoria

barplot(table(datos)/length(datos))

curve(dnorm(x, mean = mean, sd = sd), from=min(datos), to=max(datos), 
      col='blue', main = "Densidad de Probabilidad Normal",
      ylab = "f(x)", xlab = "Monto de cargos internacionales")

#las graficas muestran una aproximacion a una distribucion normal, simetrica y leptocurtica
#es decir los datos se encuentran concentrados alrededor de la media

my_hist <- hist(datos, breaks = 4, main = "Histograma", xlab = "Cargos")
#el histograma muestra en que rangos se encuentran la mayoria de los datos



#2. ¿Cuál es la probabilidad de que el total de cargos internacionales sea
#menor a 1.85 usd?

pnorm(q = 1.85, mean = mean, sd = sd) #0.1125

#3. ¿Cuál es la probabilidad de que el total de cargos internacionales sea
#mayor a 3 usd?

pnorm(q = 3, mean = mean, sd = sd, lower.tail = FALSE) #0.3773 

#4. ¿Cuál es la probabilidad de que el total de cargos internacionales esté
#entre 2.35usd y 4.85 usd?

pnorm(q = 4.85, mean = mean, sd = sd) - pnorm(q = 2.35, mean = mean, sd = sd) #0.706

#5. Con una probabilidad de 0.48, ¿cuál es el total de cargos internacionales
#más alto que podría esperar?

qnorm(p = 0.48, mean = mean, sd = sd) #2.7267

#6. ¿Cuáles son los valores del total de cargos internacionales que dejan
#exactamente al centro el 80% de probabilidad?

qnorm(p = 0.1, mean = mean, sd = sd); qnorm(p = 0.1, mean = mean, sd = sd, lower.tail = FALSE)
  #entre 1.7985 y 3.73058  

