#' Get the url path to the "telegram" of a particular "mesa"
#'
#' @param base_url A base path, default: "https://www.resultados2019.gob.ar/opt/jboss/rct/tally/pages".
#' @param mesa The "mesa" code.
#' @return A url.
#'
#' @examples
#' get_telegrama_url("0100100001X")
#' get_telegrama_url("0100100001X", base_url = "https://www.resultados2019.gob.ar/opt/jboss/rct/tally/pages")
#'
get_telegrama_url <- function(mesa,
                              base_url = "https://www.resultados2019.gob.ar/opt/jboss/rct/tally/pages"
                              ) {
  paste0(base_url, "/", mesa, "/1.png")

}
