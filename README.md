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

### Funciones

* **get_telegrama_url**: Para obtener la url de la imagen digitalizada del telegrama

## Instalación

Como cualquier otro paquete mantenido en github.com, el proceso es relativamente sencillo. En primer lugar necesitaremos `devtools`:

    install.packages("devtools")

una vez instalada este paquete, simplemente podremos instalar `paso2019` directamente desde el código fuente del repositorio:

    devtools::install_github("paso2019")

## Requerimientos

Ninguno, salvo `devtools` para poder instalarlo, son datos, y eventualmente alguna que otra función que en principio intentaré que no requiera ningún paquete extra. 
