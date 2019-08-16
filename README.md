# paso2019

Paquete de datos con los resultados del escrutinio de las "Paso 2019" de Argentina.

## Contenido

### Datos

Tablas originales distribuidas por la justicia electoral, tal cual se pueden descargar desde: http://descargaresultados.s3-sa-east-1.amazonaws.com/resultados.zip. Los archivos (de tipo DSV), fueron importados sin niguna transformación, son `data.frames` básicos, la mayoría de las columnas son `character`, salvo las que representan cantidades de votos que son númericas. Estas tablas no mutaran en el futuro. 

* descripcion_postulaciones (355.9Kb)
* descripcion_regiones (798.1 kb)
* mesas_totales (98.4 mb)
* mesas_totales_lista (230.4 mb)
* mesas_totales_agrp_politica (182.9 mb)

Requerimiento de memoria total: **512.7 Mb**

Tablas derivadas de las anteriores. La idea es transformar los datos en tablas que respeten mejor un modelo relacional. Estas tablas están en pleno procesos de creación y modificación. Usarlas con esta información en mente.

* agrupaciones (13.8 kb)
* categorias (49.4 kb)
* circuitos (741.5 Kb)
* distritos (4.3 kb)
* listas (261.3 kb)
* mesas (8.8 mb)
* meta_agrupaciones 10 kb)
* secciones (67.7 kb)
* votos (83.9 MB)

Requerimiento de memoria total: **94.5 Mb**

Este modelo elimina mucha de la redundancia de datos de los archivos originales, se generaron también `id's` numéricos para reducir los requrimientos de memoria. Claro, que las consultas requieren ir agregando las relaciones. Por ejemplo, para consultar el total de votos de cada agrupación en la elección de presidente, habría que hacer algo así:

    library("tidyverse")
    library("paso2019")
    
    votos %>% 
      left_join(listas, by = "id_lista") %>% 
      left_join(agrupaciones, by = "id_agrupacion") %>% 
      left_join(categorias, by = "id_categoria") %>% 
      left_join(meta_agrupaciones, by = "id_meta_agrupacion") %>% 
      filter(nombre_categoria == "Presidente y Vicepresidente de la República") %>% 
      group_by(nombre_meta_agrupacion, votos_totales) %>% 
      summarise(votos = sum(votos)) %>% 
      mutate(porcentaje = votos / votos_totales) %>% 
      select(nombre_meta_agrupacion, votos, porcentaje ) %>% 
      arrange(-votos)
      
    # A tibble: 10 x 3
    # Groups:   nombre_agrupacion [10]
       nombre_agrupacion                                 votos porcentaje
       <chr>                                             <dbl>      <dbl>
     1 FRENTE DE TODOS                                11622428    0.492  
     2 JUNTOS POR EL CAMBIO                            7825208    0.331  
     3 CONSENSO FEDERAL                                2007035    0.0849 
     4 FRENTE DE IZQUIERDA Y DE TRABAJADORES - UNIDAD   697776    0.0295 
     5 FRENTE NOS                                       642662    0.0272 
     6 UNITE POR LA LIBERTAD Y LA DIGNIDAD              533100    0.0226 
     7 MOVIMIENTO AL SOCIALISMO                         173585    0.00735
     8 FRENTE PATRIOTA                                   58575    0.00248
     9 MOVIMIENTO DE ACCION VECINAL                      36324    0.00154
    10 PARTIDO AUTONOMISTA                               32562    0.00138

### Funciones

* **get_telegrama_url**: Para obtener la url de la imagen digitalizada del telegrama

## Instalación

Como cualquier otro paquete mantenido en github.com, el proceso es relativamente sencillo. En primer lugar necesitaremos `devtools`:

    install.packages("devtools")

una vez instalada este paquete, simplemente podremos instalar `paso2019` directamente desde el código fuente del repositorio:

    devtools::install_github("paso2019")

## Requerimientos

Ninguno, salvo `devtools` para poder instalarlo, son datos, y eventualmente alguna que otra función que en principio intentaré que no requiera ningún paquete extra. 
