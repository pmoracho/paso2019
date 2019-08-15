#' Regiones electorales Argentinas
#'
#' Un dataset conteniendo los nombres de las regiones electorales,
#' derivado del archivo original descripcion_regiones.dsv
#'
#' @format Un data frame con 6298 filas y 2 variables:
#' \describe{
#'   \item{CODIGO_REGION}{Código de la región}
#'   \item{NOMBRE_REGION}{Nombre de la región}
#' }
#'
#' @source \url{http://descargaresultados.s3-sa-east-1.amazonaws.com/resultados.zip}
"descripcion_regiones"

#' Postulaciones a las "Paso 2019"
#'
#' Un dataset conteniendo el detalle de todas las agrupaciones que se han presentado,
#' derivado del archivo original descripcion_postulaciones.dsv
#'
#' @format Un data frame con 1442 filas y 6 variables:
#' \describe{
#'   \item{CODIGO_CATEGORIA}{Código de categoría del voto, ej "Diputados Ciudad Autónoma de Buenos Aires"}
#'   \item{NOMBRE_CATEGORIA}{Nombre de la categoría}
#'   \item{CODIGO_AGRUPACION}{Código de la agrupación política}
#'   \item{NOMBRE_AGRUPACION}{Nombre de la agrupación política}
#' }
#'
#' @source \url{http://descargaresultados.s3-sa-east-1.amazonaws.com/resultados.zip}
"descripcion_postulaciones"

#' Votos por mesa y lista
#'
#' Un dataset conteniendo el detalle de todas las agrupaciones que se han presentado,
#' derivado del archivo original mesas_totales_lista.dsv
#'
#' @format Un data frame con 3665201 filas y 8 variables:
#' \describe{
#'   \item{CODIGO_DISTRITO}{Código de distrito}↕
#'   \item{CODIGO_SECCION}{Código de sección electoral}
#'   \item{CODIGO_CIRCUITO}{Código de circuito}
#'   \item{CODIGO_MESA}{Código de mesa}
#'   \item{CODIGO_CATEGORIA}{Código de categoría de la elección}
#'   \item{CONTADOR}{Sin información disponible}
#'   \item{VALOR}{sin información disponible}
#' }
#'
#' @source \url{http://descargaresultados.s3-sa-east-1.amazonaws.com/resultados.zip}
"mesas_totales_lista"

#' categorias a las que se votó en las Paso 2019
#'
#' Un dataset conteniendo el detalle de todas las categorias de esta elección,
#' deriva de descripcion_postulaciones.dsv
#'
#' @format Un data frame con 1442 filas y 6 variables:
#' \describe{
#'   \item{CODIGO_CATEGORIA}{Código de categoría del voto, ej "Diputados Ciudad Autónoma de Buenos Aires"}
#'   \item{NOMBRE_CATEGORIA}{Nombre de la categoría}
#' }
#'
#' @source \url{http://descargaresultados.s3-sa-east-1.amazonaws.com/resultados.zip}
"categorias"

#' Agrupaciones que participaron en las Paso 2019
#'
#' Un dataset conteniendo el detalle de todas las agrupaciones de esta elección,
#' deriva de descripcion_postulaciones.dsv
#'
#' @format Un data frame con 182 filas y 2 variables:
#' \describe{
#'   \item{CODIGO_AGRUPACION}{Código de la agrupación política}
#'   \item{NOMBRE_AGRUPACION}{Nombre de la agrupación política}
#' }
#'
#' @source \url{http://descargaresultados.s3-sa-east-1.amazonaws.com/resultados.zip}
"agrupaciones"


#' Mesas totales en las Paso 2019
#'
#' Un dataset conteniendo el detalle de todas las mesas de votación de esta elección,
#' deriva de descripcion_postulaciones.dsv
#'
#' @format Un data frame con 100142 filas y 2 variables:
#' \describe{
#'   \item{CODIGO_MESA}{Código de mesa}
#'   \item{ESCRUTADA}{TRUE/FALSE dependiendo si fue o no escrutada}
#' }
#'
#' @source \url{http://descargaresultados.s3-sa-east-1.amazonaws.com/resultados.zip}
"agrupaciones"
