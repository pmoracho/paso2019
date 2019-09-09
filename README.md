<!-- badges: start -->
  [![Travis build status](https://travis-ci.org/pmoracho/paso2019.svg?branch=master)](https://travis-ci.org/pmoracho/paso2019)
  <!-- badges: end -->

# paso2019

Paquete de datos con los resultados del escrutinio de las "Paso 2019" de Argentina, tal cual como los publica la **[Dirección Nacional Electoral (DINE)](https://www.argentina.gob.ar/interior/dine)**.

## Contenido

### Datos

Los datos están actualizados al `12/08/2019 05:03:06 (-03:00 UTC)` según informa la **DINE**.

**Importante**:

Hay algunas inconsistencias en los datos, que en algún momento puede llamar la atención. Por empezar hay una diferencia entre las tres tablas de mesas descargadas del sitio oficial de los resultados:

* Dentro de las tablas originales, pudimos constatar, que `mesas_totales` tiene 100,142  mesas, 6 mesas menos que el resto de las tablas (`mesas_totales_lista` y `mesas_totales_agrp_politica`), esto no tiene mucho impacto, por que en el modelo de datos nuevo, usamos `mesas_totales_lista` para armar prácticamente toda la información.

* La otra inconsistencia notable, es entre, ésta información y la que se publica en la página web: https://resultados.gob.ar/, la mesas escrutadas según esta página son 100,156 mesas, los datos descargados, indican en el mejor de los casos 100,148 mesas, es decir 8 mesas menos.

### Establecimientos

Los datos de los locales o establecimientos de votación no forman parte de los archivos compartidos por el sitio. Estos datos se construyeron por un trabajo de "scrapping" del sitio web, por lo que hay que tomarlos con cuidado. En principio, no han quedado mesas sin relacionar a un establecimiento, y un muestreo aleatorio da resultados consistentes. Para controlar todos los datos de una mesa en particular, se puede hacer:

    library("tidyverse")
    library("paso2019")
  
    votos %>%
      left_join(mesas, by = "id_mesa") %>%
      filter(codigo_mesa == "2102208133X") %>%
      left_join(circuitos, by = "id_circuito") %>%
      left_join(secciones, by = "id_seccion") %>%
      left_join(distritos, by = "id_distrito") %>%
      left_join(listas, by = "id_lista") %>%
      left_join(agrupaciones, by = "id_agrupacion") %>%
      left_join(meta_agrupaciones, by = "id_meta_agrupacion") %>%
      left_join(categorias, by = "id_categoria") %>%
      left_join(establecimientos, by = "id_establecimiento") %>%
      select(nombre_distrito,
             nombre_seccion,
             nombre_circuito,
             nombre_establecimiento,
             codigo_mesa,
             nombre_categoria,
             nombre_meta_agrupacion,
             votos) %>%
      View()


#### Modelo original

El modelo original representa las tablas originales distribuidas por la justicia electoral, tal cual se pueden acceder desde: http://descargaresultados.s3-sa-east-1.amazonaws.com/resultados.zip. Los archivos (de tipo DSV), fueron importados sin ninguna transformación importante, son `data.frames` básicos, la mayoría de las columnas son `character`, salvo las que representan cantidades de votos que son numéricas.

* `descripcion_postulaciones` (355.9 Kb)
* `descripcion_regiones` (798.1 kb)
* `mesas_totales` (98.4 mb)
* `mesas_totales_lista` (230.4 mb)
* `mesas_totales_agrp_politica` (182.9 mb)

Otros

* `scrap_establecimientos_mesas` (533.8 mb)

Requerimiento de memoria total: **406.4Mb**

#### Modelo nuevo

![Modelo nuevo](doc/img/modelo_paso2019.png)

Son tablas derivadas de las anteriores. La idea es transformar los datos en tablas que respeten mejor un modelo relacional. Estas tablas están en pleno procesos de creación y modificación, eventualmente podrá cambiar algo.

* `agrupaciones` (15.3 kb)
* `categorias` (49.4 kb)
* `circuitos` (741.5 Kb)
* `distritos` (4.3 kb)
* `listas` (272.7 kb)
* `mesas` (9.3 mb)
* `meta_agrupaciones` (10.4 kb)
* `secciones` (67.7 kb)
* `votos` (107.4 MB)
* `establecimientos` (2.3 MB)

Requerimiento de memoria total: **120.1 Mb**

Este modelo elimina mucha de la redundancia de datos de los archivos originales, se generaron también `id's` numéricos para cada tabla, y así reducir los requerimientos de memoria. Claro, que las consultas requieren ir agregando varias relaciones. Por ejemplo, para consultar el total de votos de cada agrupación en la elección de presidente, habría que hacer algo así:

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
      
    # A tibble: 11 x 3
    # Groups:   nombre_meta_agrupacion [11]
       nombre_meta_agrupacion                            votos porcentaje
       <chr>                                             <dbl>      <dbl>
     1 FRENTE DE TODOS                                11622428    0.477  
     2 JUNTOS POR EL CAMBIO                            7825208    0.321  
     3 CONSENSO FEDERAL                                2007035    0.0823 
     4 VOTOS en BLANCO                                  758988    0.0311 
     5 FRENTE DE IZQUIERDA Y DE TRABAJADORES - UNIDAD   697776    0.0286 
     6 FRENTE NOS                                       642662    0.0264 
     7 UNITE POR LA LIBERTAD Y LA DIGNIDAD              533100    0.0219 
     8 MOVIMIENTO AL SOCIALISMO                         173585    0.00712
     9 FRENTE PATRIOTA                                   58575    0.00240
    10 MOVIMIENTO DE ACCION VECINAL                      36324    0.00149
    11 PARTIDO AUTONOMISTA                               32562    0.00134


Los procesos de importación, tanto de los archivos, como los de la "captura" de los datos de la web, como así también la creación del nuevo modelo, puede consultarse y verificarse mirando los scripts (en el orden de ejecución):

* `tools/download_and_process_establecimientos.R`: descarga y procesa todos los archivos `json` para generar la tabla de `scrap_establecimientos_mesas`, dónde tenemos código de mesa y nombre del establecimiento
* `tools/process_dsv_and_create_model.R`: Procesamos los DSV originales, para crear las tablas originales y el nuevo modelo

### Funciones públicas

* **get_telegrama_url()**: Para generar la url de la imagen digitalizada del telegrama
* **view_telegrama()**: Para ver la imagen del telegrama

## Instalación

Como cualquier otro paquete mantenido en github.com, el proceso es relativamente sencillo. En primer lugar necesitaremos `devtools`:

    install.packages("devtools")

una vez instalada este paquete, simplemente podremos instalar `paso2019` directamente desde el código fuente del repositorio:

    devtools::install_github("pmoracho/paso2019")

## Requerimientos

Ninguno en particular, salvo `devtools` para poder instalar este paquete, son datos, y eventualmente alguna que otra función que en principio intentaré que no requiera ningún paquete extra. 

## Actualizaciones

* 2019/10/05 - Versión `0.2.0` incorporamos `establecimientos`
* 2019/08/28 - Incorporamos view_telegrama()
* 2019/08/22 - Incorporamos los votos en blanco
