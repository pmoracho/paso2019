#' Descarga y procesa la informacio ón de los establecimientos
#'
download_and_process_establecimientos <- function() {

  base_url <- 'https://www.resultados2019.gob.ar/assets/data'
  for (i in 1:9999) {
    num <- as.character(i)
    file <-  paste0(base_url,
                    "/sites/",
                    ifelse(nchar(num) < 4, "0", substr(num, 1, 1)),
                    '/r',
                    num,
                    '.json')
    destfile <- paste0("tools/", "r",num,".json")
    tryCatch({
        download.file(file, mode="w", destfile = destfile, quiet=TRUE)
        print(paste(file, "OK"))
    },
    error = function(e) {
        print(paste(file, "No descargado"))
    })
    file <-  paste0(base_url,
                    "/precincts/",
                    ifelse(nchar(num) < 4, "0", substr(num, 1, 1)),
                    '/s',
                    num,
                    '.json')
    destfile <- paste0("tools/", "s",num,".json")
    tryCatch({
      download.file(file, mode="w", destfile = destfile, quiet=TRUE)
      print(paste(file, "OK"))
    },
    error = function(e) {
      print(paste(file, "No descargado"))
    })
  }

  library(jsonlite)
  library(tidyverse)
  library(purrr)

  list.files("tools/", pattern="r.*\\.json", full.names=TRUE) %>%
    map(fromJSON) %>%
    bind_rows() %>%
    select(cc, n, chd) -> df1

  list.files("tools/", pattern="s.*\\.json", full.names=TRUE) %>%
    map(fromJSON) %>%
    bind_rows() %>%
    select(c, cc) -> df2

  # establecimientos
  df1 %>%
    unnest(chd) %>%
    mutate(codigo_circuito = substr(cc, 1, 11)) %>%
    select(cc, codigo_circuito, n, everything()) %>%
    setNames(c("codigo_establecimiento", "codigo_circuito", "nombre_establecimiento", "mesa_id_interno")) %>%
    left_join(df2, by=c("mesa_id_interno" = "c")) %>%
    select(codigo_establecimiento, codigo_circuito, nombre_establecimiento, codigo_mesa =cc) -> df3
}

