# analisis.jl  -  Tarea 11 | Jesus Enrique Flores Riera
# Ejercicio 1: Vectorizacion y algebra espacial (Haversine)
# Ejercicio 2: Limpieza, filtros y agregacion tabular

using DataFrames, Statistics

# ── Ejercicio 1 ────────────────────────────────────────────
df = DataFrame(
    Ciudad    = ["Bogota","Medellin","Cali","Barranquilla","Cartagena",
                 "Cucuta","Bucaramanga","Pereira","Manizales","Ibague"],
    Latitud   = [4.7110, 6.2442, 3.4516, 10.9685, 10.3910,
                 7.8939, 7.1254,  4.8133,  5.0703,  4.4389],
    Longitud  = [-74.0721,-75.5812,-76.5320,-74.7813,-75.4794,
                 -72.5078,-73.1198,-75.6961,-75.5138,-75.2322],
    Poblacion = [7181469,2533424,2227642,1274250,1028736,
                 750015,582984,474335,434403,563822]
)

function calcular_distancias(df::DataFrame)::DataFrame
    R       = 6371.0
    lat_bog = deg2rad(4.7110)
    lon_bog = deg2rad(-74.0721)

    lat2 = deg2rad.(df.Latitud)
    lon2 = deg2rad.(df.Longitud)

    dlat = lat2 .- lat_bog
    dlon = lon2 .- lon_bog

    a = sin.(dlat ./ 2).^2 .+ cos(lat_bog) .* cos.(lat2) .* sin.(dlon ./ 2).^2
    c = 2 .* atan.(sqrt.(a), sqrt.(1 .- a))

    result = copy(df)
    result.Distancia_Bogota = round.(R .* c, digits=2)
    return result
end

df = calcular_distancias(df)
println("=== Ejercicio 1: Distancias desde Bogota ===")
println(select(df, :Ciudad, :Distancia_Bogota))

# ── Ejercicio 2 ────────────────────────────────────────────
println("\n=== Ejercicio 2: Estaciones meteorologicas ===")

estaciones = DataFrame(
    Estacion      = ["Paramo","Valle","Costa","Selva","Sabana"],
    Elevacion     = [3200, 1500, 15, 200, 2600],
    Precipitacion = Union{Float64,Missing}[850.5, 1200.0, missing, 3000.5, missing]
)

# Imputacion con media de valores validos
media_valida = mean(skipmissing(estaciones.Precipitacion))
estaciones.Precipitacion = coalesce.(estaciones.Precipitacion, media_valida)
println("DataFrame con imputacion:")
println(estaciones)

# Filtro: elevacion > 1000 m
estaciones_altas = filter(row -> row.Elevacion > 1000, estaciones)
println("\nEstaciones con elevacion > 1000 m:")
println(estaciones_altas)

prom_altas = mean(estaciones_altas.Precipitacion)
println("\nPrecipitacion promedio en estaciones altas: ", round(prom_altas, digits=2), " mm")
