# analisis.py  -  Tarea 11 | Jesus Enrique Flores Riera
# Ejercicio 1: Vectorizacion y algebra espacial (Haversine)
# Ejercicio 2: Limpieza, filtros y agregacion tabular

import numpy as np
import pandas as pd

# ── Ejercicio 1 ────────────────────────────────────────────
# Datos de censos (ciudades de Colombia)
df = pd.DataFrame({
    'Ciudad':    ['Bogota', 'Medellin', 'Cali', 'Barranquilla', 'Cartagena',
                  'Cucuta',  'Bucaramanga', 'Pereira', 'Manizales', 'Ibague'],
    'Latitud':   [4.7110,   6.2442,   3.4516,  10.9685,  10.3910,
                  7.8939,   7.1254,   4.8133,   5.0703,   4.4389],
    'Longitud':  [-74.0721, -75.5812, -76.5320, -74.7813, -75.4794,
                  -72.5078, -73.1198, -75.6961, -75.5138, -75.2322],
    'Poblacion': [7181469,  2533424,  2227642,  1274250,   1028736,
                   750015,   582984,   474335,   434403,    563822]
})

def calcular_distancias(df: pd.DataFrame) -> pd.DataFrame:
    """Calcula la distancia Haversine desde Bogota a cada ciudad del DataFrame."""
    R = 6371.0  # Radio de la Tierra en km
    lat_bog = np.radians(4.7110)
    lon_bog = np.radians(-74.0721)

    lat2 = np.radians(df['Latitud'].values)
    lon2 = np.radians(df['Longitud'].values)

    dlat = lat2 - lat_bog
    dlon = lon2 - lon_bog

    a = np.sin(dlat / 2)**2 + np.cos(lat_bog) * np.cos(lat2) * np.sin(dlon / 2)**2
    c = 2 * np.arctan2(np.sqrt(a), np.sqrt(1 - a))

    df = df.copy()
    df['Distancia_Bogota'] = np.round(R * c, 2)
    return df

df = calcular_distancias(df)
print('=== Ejercicio 1: Distancias desde Bogota ===')
print(df[['Ciudad', 'Distancia_Bogota']].to_string(index=False))

# ── Ejercicio 2 ────────────────────────────────────────────
print('\n=== Ejercicio 2: Estaciones meteorologicas ===')

estaciones = pd.DataFrame({
    'Estacion':      ['Paramo', 'Valle', 'Costa', 'Selva', 'Sabana'],
    'Elevacion':     [3200, 1500, 15, 200, 2600],
    'Precipitacion': [850.5, 1200.0, None, 3000.5, None]
})

# Imputacion: rellena nulos con la media de los valores validos
media_valida = estaciones['Precipitacion'].mean()
estaciones['Precipitacion'] = estaciones['Precipitacion'].fillna(media_valida)
print('DataFrame con imputacion:')
print(estaciones.to_string(index=False))

# Filtro espacial: estaciones con elevacion > 1000 m
estaciones_altas = estaciones[estaciones['Elevacion'] > 1000].copy()
print('\nEstaciones con elevacion > 1000 m:')
print(estaciones_altas.to_string(index=False))

prom_altas = estaciones_altas['Precipitacion'].mean()
print(f'\nPrecipitacion promedio en estaciones altas: {prom_altas:.2f} mm')
