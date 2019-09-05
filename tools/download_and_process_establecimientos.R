#' Descarga y procesa la informacio ón de los establecimientos
#'
download_establecimientos <- function() {

  base_url <- 'https://www.resultados2019.gob.ar/assets/data'
  for (i in 12786:15000) {
    num <- as.character(i)
    num <- paste0(ifelse(nchar(num) < 4, "0", ""), num)
    p1 <- substr(num, nchar(num)-2,nchar(num))
    p2 <- substr(num, 1 ,nchar(num)-3)

    # file <-  paste0(base_url,
    #                 "/sites/",
    #                 p2,
    #                 '/r',
    #                 num,
    #                 '.json')
    # destfile <- paste0("tools/", "r",num,".json")
    # tryCatch({
    #     download.file(file, mode="w", destfile = destfile, quiet=TRUE)
    #     print(paste(file, "OK"))
    # },
    # error = function(e) {
    #     print(paste(file, "No descargado"))
    # })
    file <-  paste0(base_url,
                    "/precincts/",
                    p2,
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
}

process_establecimientos <- function() {

  library(jsonlite)
  library(tidyverse)
  library(purrr)

  data_frame(filename = list.files("tools/", pattern="r.*\\.json")) %>%
    mutate(file_contents = map(filename,
                               ~ fromJSON(file.path("tools", .)))
    ) %>%
    unnest() %>%
    unnest(chd) %>%
    select(filename, c, cc, n, chp, chd) -> df1


  data_frame(filename = list.files("tools/", pattern="s.*\\.json")) %>%
    mutate(file_contents = map(filename,
                               ~ fromJSON(file.path("tools", .)))
    ) %>%
    unnest() %>%
    select(filename, c, cc, n) -> df2

  # establecimientos/mesas
  df1 %>%
    mutate(codigo_circuito = substr(cc, 1, 11)) %>%
    select(cc, codigo_circuito, n, chd) %>%
    setNames(c("codigo_establecimiento", "codigo_circuito", "nombre_establecimiento", "mesa_id_interno")) %>%
    left_join(df2, by=c("mesa_id_interno" = "c")) %>%
    select(codigo_establecimiento, codigo_circuito, nombre_establecimiento, codigo_mesa =cc) -> scrap_establecimientos

  # Establecimientos sin mesas
  mesas %>%
    inner_join(circuitos, by = "id_circuito") %>%
    inner_join(secciones, by = "id_seccion") %>%
    inner_join(distritos, by = "id_distrito") %>%
    inner_join(  scrap_establecimientos %>%
                   filter(is.na(codigo_mesa)) %>%
                   distinct(), by = "codigo_circuito") %>%
    select(codigo_establecimiento, nombre_establecimiento,
           nombre_distrito, nombre_seccion, nombre_circuito) %>%
    distinct()

  manuales <- read.table(text = "codigo_establecimiento codigo_mesa
  020500003645318 0205000024X
  020500003645318 0205000025X
  020500003645318 0205000026X
  020500003645318 0205000027X
  020500003645318 0205000024X
  0203800302A12794 0203800423X
  0203800302A12794 0203800424X
  0203800302A12794 0203800425X
  0203800302A12794 0203800426X
  0203800302A12794 0203800427X
  0203800302A12794 0203800423X
  0206200026350113 0206209009E
  0206200026350113 0206209010E
  0206200026350113 0206209011E
  0206200026350113 0206209012E
  0206200026350113 0206209013E
  0206200026350113 0206209014E
  0206200026350113 0206209015E
  0206200026350113 0206209016E
  0209200078712324 0209200606X
  0209200078712324 0209200607X
  0209200078712324 0209200608X
  0209200078712324 0209200609X
  0209200078712324 0209200610X
  0209200078712324 0209200611X
  0209200078712324 0209200612X
  0209200078712324 0209200613X
  0209200078712324 0209200614X
  0209200078712324 0209200615X
  020930007978132 0209300001X
  020930007978132 0209300002X
  020930007978132 0209300003X
  020930007978132 0209300004X
  020930007978132 0209300005X
  020930007978132 0209300006X
  020930007978132 0209300007X
  020930007978132 0209300008X
  020930007978132 0209300009X
  05007000040121 0500701538X
  05007000040121 0500701539X
  05007000040121 0500701540X
  05007000040121 0500701S41X
  05007000040121 0500701S42X
  05007000040121 0500701543X
  05007000040121 0500701544X
  08003000067154 0800301052X
  1000800071A165 1000801563X
  1000800071A165 1000801564X
  1401200066A261 1401201946X
  1401200066A261 1401201947X
  1401200066A261 1401201948X
  16013000074273 1601301666X
  16013000074273 1601301667X
  1900100008A69 1900100537X
  1900100008A69 1900100538X
  2000100000324 2000100172X
  2000100000324 2000100173X
  2000100000324 2000100174X
  2000100000324 200010017SX
  2000100000324 2000100176X
  2000100000324 2000100177X
  2000100000324 2000100178X
  2000100000324 2000100179X
  2101300033025029 2101304270X
  2101300033025029 2101304271X
  2101300033025029 2101304Z72X
  2101300033025029 2101304273X
  2101300033025029 2101304274X
  2101300033025029 2101304275X
  2101300033025029 2101304276X
  2101300033025029 2101304277X
  2102200025524896 2102208133X
", header=TRUE, stringsAsFactor=FALSE)

  for (e in unique(manuales$codigo_establecimiento)) {
    scrap_establecimientos$codigo_mesa[scrap_establecimientos$codigo_establecimiento == e] <- manuales$codigo_mesa[manuales$codigo_establecimiento == e]
  }

  usethis::use_data(scrap_establecimientos, overwrite = TRUE)

}
