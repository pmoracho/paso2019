#' Ver el telegrama de una determinada mesa
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
#' view_telegrama("0100100002X")
#'
view_telegrama <- function(codigo_mesa,
                           base_url = "https://www.resultados2019.gob.ar/opt/jboss/rct/tally/pages"
) {
  imgfile <- paste0(base_url, "/", codigo_mesa, "/1.png")
  destfile <- tempfile(pattern = codigo_mesa,
                       fileext = ".png",
                       tmpdir = tempdir())
  download.file(url = imgfile,
                destfile = destfile,
                mode = "wb")
  browseURL(destfile)
  destfile
}
