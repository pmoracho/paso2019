# paso2019

Paquete de datos con los resultados del escrutinio de las "Paso 2019" de Argentina.

## Contenido

### Datos

Tablas originales distribuidas por la justicia electoral, tal cual se pueden descargar desde: http://descargaresultados.s3-sa-east-1.amazonaws.com/resultados.zip. Los archivos (de tipo DSV), fueron importados sin niguna transformación, son `data.frames` básicos, la mayoría de las columnas son `character`, salvo las que representan cantidades de votos que son númericas. Estas tablas no mutaran en el futuro 

* descripcion_postulaciones
* descripcion_regiones
* mesas_totales
* mesas_totales_lista
* mesas_totales_agrp_politica

Tablas derivadas de las anteriores. La idea es transformar los datos en tablas que respeten mejor un modelo relacional. Estas tablas están en pleno procesos de creación y modificación. Usarlas con esta información en mente.

* mesas
* categorias
* listas
* agrupaciones
* votos

Este modelo elimina mucha de la redundancia de datos de los archivos originales, se generaron también `id's` numéricos para reducir los requrimientos de memoria. Claro, que las consultas requieren ir agregando las relaciones. Por ejemplo, para consultar el total de votos de cada agrupación en la elección de presidente, habría que hacer algo así:

    library("tidyverse")
    library("paso2019")
    
    votos %>% 
      left_join(listas, by = "id_lista") %>% 
      left_join(agrupaciones, by = "id_agrupacion") %>% 
      left_join(categorias, by = "id_categoria") %>% 
      filter(id_categoria == 137) %>% 
      group_by(nombre_agrupacion) %>% 
      summarise(votos = sum(votos)) %>% 
      arrange(-votos)

    # A tibble: 10 x 2
       nombre_agrupacion                                 votos
       <chr>                                             <dbl>
     1 FRENTE DE TODOS                                11622428
     2 JUNTOS POR EL CAMBIO                            7825208
     3 CONSENSO FEDERAL                                2007035
     4 FRENTE DE IZQUIERDA Y DE TRABAJADORES - UNIDAD   697776
     5 FRENTE NOS                                       642662
     6 UNITE POR LA LIBERTAD Y LA DIGNIDAD              533100
     7 MOVIMIENTO AL SOCIALISMO                         173585
     8 FRENTE PATRIOTA                                   58575
     9 MOVIMIENTO DE ACCION VECINAL                      36324
    10 PARTIDO AUTONOMISTA                               32562

### Funciones

* **get_telegrama_url**: Para obtener la url de la imagen digitalizada del telegrama

## Instalación

Como cualquier otro paquete mantenido en github.com, el proceso es relativamente sencillo. En primer lugar necesitaremos `devtools`:

    install.packages("devtools")

una vez instalada este paquete, simplemente podremos instalar `paso2019` directamente desde el código fuente del repositorio:

    devtools::install_github("paso2019")

## Requerimientos

Ninguno, salvo `devtools` para poder instalarlo, son datos, y eventualmente alguna que otra función que en principio intentaré que no requiera ningún paquete extra. 
