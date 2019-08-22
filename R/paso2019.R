#' Regiones electorales Argentinas
#'
#' Un dataset conteniendo los nombres de las regiones electorales,
#' tal como están definidas  en el archivo original descripcion_regiones.dsv.
#' En un mismo archivo están los 3 niveles: distrito, seccion y
#' circuito el CODIGO_REGION es particular para cada una de
#' estas entidades.
#'
#' (ESTRUCTURA ORIGINAL)
#'
#' @format Un data frame con 6,298 filas y 2 variables:
#' \describe{
#'   \item{CODIGO_REGION}{Código de la región}
#'   \item{NOMBRE_REGION}{Nombre de la región}
#' }
#'
#' @source \url{http://descargaresultados.s3-sa-east-1.amazonaws.com/resultados.zip}
"descripcion_regiones"

#' Postulaciones (categorías y agrupaciones)
#'
#' Un dataset conteniendo el detalle de todas las agrupaciones que
#' se han presentado, derivado del archivo original
#' descripcion_postulaciones.dsv
#'
#' (ESTRUCTURA ORIGINAL)
#'
#' @format Un data frame con 1,442 filas y 6 variables
#' \describe{
#'   \item{CODIGO_CATEGORIA}{Código de categoría del voto, ej "Diputados Ciudad Autónoma de Buenos Aires"}
#'   \item{NOMBRE_CATEGORIA}{Nombre de la categoría}
#'   \item{CODIGO_AGRUPACION}{Código de la agrupación política}
#'   \item{NOMBRE_AGRUPACION}{Nombre de la agrupación política}
#'   \item{CODIGO_LISTA}{Código de la lista}
#'   \item{NOMBRE_LISTA}{Nombre de la lista}
#' }
#' @source \url{http://descargaresultados.s3-sa-east-1.amazonaws.com/resultados.zip}
"descripcion_postulaciones"

#' Mesas
#'
#' Un dataset conteniendo el detalle de mesas derivado del archivo
#' original mesas_totales.dsv
#'
#' (ESTRUCTURA ORIGINAL)
#'
#' @format Un data frame con 1,719,9941 filas y 7 variables:
#' \describe{
#'   \item{CODIGO_DISTRITO}{Código de distrito}
#'   \item{CODIGO_SECCION}{Código de sección electoral}
#'   \item{CODIGO_CIRCUITO}{Código de circuito}
#'   \item{CODIGO_MESA}{Código de mesa}
#'   \item{CODIGO_CATEGORIA}{Código de categoría de la elección}
#'   \item{CONTADOR}{Desconocido}
#'   \item{VALOR}{Desconocido}
#' }
#'
#' @source \url{http://descargaresultados.s3-sa-east-1.amazonaws.com/resultados.zip}
"mesas_totales"


#' Votos por agrupación
#'
#' Un dataset conteniendo el detalle de los totales de votos por mesa, abierto hasta la agrupación,
#' derivado del archivo original mesas_totales_agrp_politica.dsv
#'
#' (ESTRUCTURA ORIGINAL)
#'
#' @format Un data frame con 3,665,201 filas y 7 variables:
#' \describe{
#'   \item{CODIGO_DISTRITO}{Código de distrito}
#'   \item{CODIGO_SECCION}{Código de sección electoral}
#'   \item{CODIGO_CIRCUITO}{Código de circuito}
#'   \item{CODIGO_MESA}{Código de mesa}
#'   \item{CODIGO_CATEGORIA}{Código de categoría de la elección}
#'   \item{CODIGO_AGRUPACION}{Código de agrupación}
#'   \item{VOTOS_AGRUPACION}{Cantidad de votos por agrupación}
#' }
#'
#' @source \url{http://descargaresultados.s3-sa-east-1.amazonaws.com/resultados.zip}
"mesas_totales_agrp_politica"

#' Votos por agrupación y  lista
#'
#' Un dataset conteniendo el detalle de los totales de votos por mesa, abierto hasta la lista,
#' derivado del archivo original mesas_totales_lista.dsv
#'
#' (ESTRUCTURA ORIGINAL)
#'
#' @format Un data frame con 3,665,201 filas y 8 variables:
#' \describe{
#'   \item{CODIGO_DISTRITO}{Código de distrito}
#'   \item{CODIGO_SECCION}{Código de sección electoral}
#'   \item{CODIGO_CIRCUITO}{Código de circuito}
#'   \item{CODIGO_MESA}{Código de mesa}
#'   \item{CODIGO_CATEGORIA}{Código de categoría de la elección}
#'   \item{CODIGO_AGRUPACION}{Código de agrupación}
#'   \item{CODIGO_LISTA}{Código de lista}
#'   \item{VOTOS_LISTA}{Cantidad de votos por lista}
#' }
#'
#' @source \url{http://descargaresultados.s3-sa-east-1.amazonaws.com/resultados.zip}
"mesas_totales_lista"

#' meta_agrupaciones
#'
#' Un dataset conteniendo el detalle de todos los partidos. En las tablas originales
#' existen agrupaciones, las cuales se corresponden con los partidos, pero tienen
#' distinto código dependiendo de la categoria  (Presidente, Gobernador, Senadores, etc)
#' y del distrito. Por lo que agregamos el concepto de meta_agrupacion que
#' efectivamete representa al partido.
#'
#' deriva de: descripcion_postulaciones.dsv
#'
#' (MODELO NUEVO)
#'
#' @format Un data frame con 102 filas y 2 variables:
#' \describe{
#'   \item{id_meta_agrupacion}{id numérico generado}
#'   \item{nombre_meta_agrupacion}{Nombre del partido}
#' }
#'
"meta_agrupaciones"

#' Agrupaciones que participaron
#'
#' Un dataset conteniendo el detalle de todas las agrupaciones de esta elección,
#' deriva de descripcion_postulaciones.dsv
#'
#' @format Un data frame con 183 filas y 2 variables:
#' \describe{
#'   \item{id_agrupacion}{id numérico generado}
#'   \item{id_meta_agrupacion}{id a la meta agrupación o partido}
#'   \item{codigo_agrupacion}{código de la agrupación tal como se informa}
#' }
#'
"agrupaciones"

#' Categorias a las que se votó
#'
#' Un dataset conteniendo el detalle de todas las categorias de esta elección,
#' deriva de descripcion_postulaciones.dsv. La categoría representa lo que
#' se está votando.
#'
#' (MODELO NUEVO)
#'
#' @format Un data frame con 204 filas y 4 variables:
#' \describe{
#'   \item{id_categoria}{id numérico generado}
#'   \item{codigo_categoria}{Código del categoría del voto}
#'   \item{nombre_categoria}{Nombre de la categoría}
#'   \item{votos_totales}{Sumatoria de todos los votos en esta categoría}
#' }
#'
"categorias"

#' Listas a las que se votó
#'
#' Un dataset conteniendo el detalle de todas las listas de esta elección,
#' deriva de descripcion_postulaciones.dsv. Un Partido puede tener múltiples
#' listas, las PASO justamente buscan definir estas.
#'
#' (MODELO NUEVO)
#'
#' @format Un data frame con 1443 filas y 6 variables:
#' \describe{
#'   \item{id_lista}{id numérico generado}
#'   \item{id_agrupación}{id a la agrupación de la lista}
#'   \item{código_lista}{código tal como aparece en los archivos originales}
#'   \item{nombre_lista}{nombre de la lista}
#' }
#'
"listas"

#' Mesas totales
#'
#' Un dataset conteniendo el detalle de todas las mesas de votación de esta elección,
#' deriva de mesas_totales_lista.dsv
#'
#' @format Un data frame con 100,148 filas y 2 variables:
#' \describe{
#'   \item{id_mesa}{id numérico generado}
#'   \item{id_distrito}{id del distrito de la mesa (provincia)}
#'   \item{id_seccion}{id del la sección electoral}
#'   \item{id_circuito}{id del circuito}
#'   \item{codigo_mesa}{código de la mesa tal como parece en los datos originales}
#'   \item{escrutada}{la mesa fue escrutada}
#' }
#'
"mesas"

#' Circuitos electorales
#'
#' Un dataset conteniendo el detalle de los circuitos electorales,
#' deriva de mesas_totales_lista.dsv
#'
#' @format Un data frame con 5,649 filas y 3 variables:
#' \describe{
#'   \item{id_circuito}{un id numérico generado para el circuito}
#'   \item{codigo_circuito}{código del circuito de la mesa}
#'   \item{nombre_circuito}{nombre del circuito}
#' }
#'
"circuitos"

#' Distritos electorales (Provincias)
#'
#' Un dataset conteniendo el detalle de los distritos electorales,
#' deriva de mesas_totales_lista.dsv
#'
#' @format Un data frame con 24 filas y 3 variables:
#' \describe{
#'   \item{id_distrito}{un id numérico generado para el distrito}
#'   \item{codigo_distrito}{código de la provincia}
#'   \item{nombre_distrito}{Nombre de la provincia}
#' }
#'
"distritos"

#' Secciones electorales (municipios)
#'
#' Un dataset conteniendo el detalle de las secciones electorales,
#' deriva de mesas_totales_lista.dsv
#'
#' @format Un data frame con 525 filas y 3 variables:
#' \describe{
#'   \item{id_seccion}{un id numérico generado para la sección}
#'   \item{codigo_seccion}{código de la sección}
#'   \item{nombre_seccion}{Nombre de la sección}
#' }
#'
"secciones"

#' Votos
#'
#' Un dataset conteniendo el detalle de los votos totales,
#' deriva de mesas_totales_lista.dsv
#'
#' @format Un data frame con 4,021,306 filas y 5 variables:
#' \describe{
#'   \item{id_voto}{un id numérico generado para el conteo de votos}
#'   \item{id_mesa}{id de la mesa}
#'   \item{id_categoria}{id de la categoría de los votos}
#'   \item{id_lista}{id de la lista}
#'   \item{votos}{Votos totales}
#' }
#'
"votos"
