# Tarea 11 — Vectorizacion y DataFrames

**Autor:** Jesus Enrique Flores Riera  
**Curso:** Programacion SIG  


---

## Descripcion

Tarea 11: dos ejercicios resueltos en Python, R y Julia.

- **Ejercicio 1:** Funcion vectorizada `calcular_distancias` con formula Haversine
  sobre DataFrame de censos. Calcula distancia en km desde Bogota a cada ciudad.
- **Ejercicio 2:** Limpieza, imputacion por media y filtrado tabular de estaciones
  meteorologicas con valores faltantes.

---

## Estructura del repositorio

```
tarea_Vectorizacion_DataFrames/
├── analisis.py        # Solucion en Python (NumPy + Pandas)
├── analisis.R         # Solucion en R (dplyr + base)
├── analisis.jl        # Solucion en Julia (DataFrames.jl)
├── analisis.qmd       # Documento Quarto con scripts y reflexion
├── renders/
│   ├── analisis.html  # Reporte en HTML
│   └── analisis.pdf   # Reporte en PDF
└── README.md
```

---

## Requisitos

### Python
```bash
pip install numpy pandas
```

### R
```r
install.packages('dplyr')
```

### Julia
```julia
using Pkg
Pkg.add(["DataFrames", "Statistics"])
```

---

## Ejecucion de los scripts

```bash
# Python
python3 analisis.py

# R
Rscript analisis.R

# Julia
julia analisis.jl
```

---

## Renderizar documento Quarto

```bash
mkdir -p renders
quarto render analisis.qmd --output-dir renders
```

> El YAML global tiene `eval: false` — renderiza sin ejecutar codigo.

---

## Salida esperada

### Ejercicio 1
```
       Ciudad  Distancia_Bogota
       Bogota              0.00
     Medellin            213.68
         Cali            155.44
 Barranquilla            689.85
    Cartagena            661.27
       Cucuta            412.46
  Bucaramanga            313.48
      Pereira            181.30
    Manizales            175.61
       Ibague            146.34
```

### Ejercicio 2
```
Precipitacion promedio en estaciones altas: 1350.17 mm
```

---

## Licencia

Uso academico — Curso de Programacion SIG, 2026.
