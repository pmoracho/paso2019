#' Obtener la url de la imagen digitalizada del telegrama
#'
#' @param base_url El path base, default: "https://www.resultados2019.gob.ar/opt/jboss/rct/tally/pages".
#' @param codigo_mesa El código de mesa
#' @return una url.
#'
#' @examples
#'
#' get_telegrama_url("0100100001X")
#' get_telegrama_url("0100100001X", base_url = "https://www.resultados2019.gob.ar/opt/jboss/rct/tally/pages")
#'
get_telegrama_url <- function(codigo_mesa,
                              base_url = "https://www.resultados2019.gob.ar/opt/jboss/rct/tally/pages"
                              ) {
  paste0(base_url, "/", mesa, "/1.png")
}
