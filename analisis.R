# analisis.R  -  Tarea 11 | Jesus Enrique Flores Riera
# Ejercicio 1: Vectorizacion y algebra espacial (Haversine)
# Ejercicio 2: Limpieza, filtros y agregacion tabular

library(dplyr)

# ── Ejercicio 1 ────────────────────────────────────────────
df <- data.frame(
  Ciudad    = c('Bogota','Medellin','Cali','Barranquilla','Cartagena',
                'Cucuta','Bucaramanga','Pereira','Manizales','Ibague'),
  Latitud   = c(4.7110, 6.2442, 3.4516, 10.9685, 10.3910,
                7.8939, 7.1254,  4.8133,  5.0703,  4.4389),
  Longitud  = c(-74.0721,-75.5812,-76.5320,-74.7813,-75.4794,
                -72.5078,-73.1198,-75.6961,-75.5138,-75.2322),
  Poblacion = c(7181469,2533424,2227642,1274250,1028736,
                750015,582984,474335,434403,563822)
)

calcular_distancias <- function(df) {
  R        <- 6371.0
  lat_bog  <- 4.7110  * pi / 180
  lon_bog  <- -74.0721 * pi / 180

  lat2 <- df$Latitud  * pi / 180
  lon2 <- df$Longitud * pi / 180

  dlat <- lat2 - lat_bog
  dlon <- lon2 - lon_bog

  a <- sin(dlat / 2)^2 + cos(lat_bog) * cos(lat2) * sin(dlon / 2)^2
  c <- 2 * atan2(sqrt(a), sqrt(1 - a))

  df$Distancia_Bogota <- round(R * c, 2)
  return(df)
}

df <- calcular_distancias(df)
cat('=== Ejercicio 1: Distancias desde Bogota ===\n')
print(df[, c('Ciudad','Distancia_Bogota')])

# ── Ejercicio 2 ────────────────────────────────────────────
cat('\n=== Ejercicio 2: Estaciones meteorologicas ===\n')

estaciones <- data.frame(
  Estacion      = c('Paramo','Valle','Costa','Selva','Sabana'),
  Elevacion     = c(3200, 1500, 15, 200, 2600),
  Precipitacion = c(850.5, 1200.0, NA, 3000.5, NA)
)

# Imputacion con media de valores validos
media_valida <- mean(estaciones$Precipitacion, na.rm = TRUE)
estaciones$Precipitacion[is.na(estaciones$Precipitacion)] <- media_valida
cat('DataFrame con imputacion:\n')
print(estaciones)

# Filtro: elevacion estrictamente mayor a 1000 m
estaciones_altas <- estaciones %>% filter(Elevacion > 1000)
cat('\nEstaciones con elevacion > 1000 m:\n')
print(estaciones_altas)

prom_altas <- mean(estaciones_altas$Precipitacion)
cat(sprintf('\nPrecipitacion promedio en estaciones altas: %.2f mm\n', prom_altas))
