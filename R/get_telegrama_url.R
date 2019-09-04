#' Obtener la url de la imagen digitalizada del telegrama
#'
#' @param base_url El path base, default: "https://www.resultados2019.gob.ar/opt/jboss/rct/tally/pages".
#' @param codigo_mesa El código de mesa
#' @return una url.
#'
#' @export
#' @examples
#'
#' library("paso2019")
#'
#' get_telegrama_url("0100100001X")
#'
get_telegrama_url <- function(codigo_mesa,
                              base_url = "https://www.resultados2019.gob.ar/opt/jboss/rct/tally/pages"
                              ) {
  paste0(base_url, "/", codigo_mesa, "/1.png")
}
