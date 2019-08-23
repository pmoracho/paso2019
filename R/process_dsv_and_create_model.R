#' Procesa los dsv de las paso 2019 y genera el modelo de datos.
#' No es necesario correrlo ya que el modelo completo ya se distribuye en
#' el paquete.
#'
process_dsv_and_create_model <- function() {

  require("tidyverse")

  read_dsv <- function(file, colClasses) {
    read.table(file, header = TRUE, sep = "|", quote = "", colClasses = colClasses, stringsAsFactors = FALSE, encoding = "UTF-8")
  }

  descripcion_postulaciones <- read_dsv("ext-data/descripcion_postulaciones.dsv", "character")
  descripcion_regiones <- read_dsv("ext-data/descripcion_regiones.dsv","character")
  mesas_totales <- read_dsv("ext-data/mesas_totales.dsv", c(rep("character",6), "numeric"))
  mesas_totales_lista <- read_dsv("ext-data/mesas_totales_lista.dsv", c(rep("character",7), "numeric"))
  mesas_totales_agrp_politica <- read_dsv("ext-data/mesas_totales_agrp_politica.dsv", c(rep("character",6), "numeric"))

  # Meta_Agrupaciones
  descripcion_postulaciones %>%
    distinct(NOMBRE_AGRUPACION) %>%
    mutate(id = row_number()) %>%
    select(id_meta_agrupacion = id,
           nombre_meta_agrupacion = NOMBRE_AGRUPACION) -> meta_agrupaciones

  # Agregamos los votos en blanco
  meta_agrupacion_vb <- data_frame(id_meta_agrupacion=max(meta_agrupaciones$id_meta_agrupacion + 1),
                                   nombre_meta_agrupacion="VOTOS en BLANCO")
  meta_agrupaciones %>%
    bind_rows(meta_agrupacion_vb) -> meta_agrupaciones

  # Agrupaciones
  descripcion_postulaciones %>%
    distinct(CODIGO_AGRUPACION, NOMBRE_AGRUPACION) %>%
    left_join(meta_agrupaciones, by = c("NOMBRE_AGRUPACION" = "nombre_meta_agrupacion")) %>%
    mutate(id = row_number()) %>%
    select(id_agrupacion = id,
           id_meta_agrupacion,
           codigo_agrupacion = CODIGO_AGRUPACION) -> agrupaciones

  # Agregamos los votos en blanco
  agrupaciones_vb <- data_frame(id_agrupacion = max(agrupaciones$id_agrupacion) + 1,
                                id_meta_agrupacion = meta_agrupacion_vb$id_meta_agrupacion,
                                codigo_agrupacion = 'VB'
  )
  agrupaciones %>%
    bind_rows(agrupaciones_vb) -> agrupaciones

  # Categorias
  descripcion_postulaciones %>%
    distinct(CODIGO_CATEGORIA, NOMBRE_CATEGORIA) %>%
    mutate(id = row_number()) %>%
    select(id_categoria = id,
           codigo_categoria = CODIGO_CATEGORIA,
           nombre_categoria = NOMBRE_CATEGORIA) -> categorias

  # Listas
  descripcion_postulaciones %>%
    distinct(CODIGO_LISTA, NOMBRE_LISTA, CODIGO_AGRUPACION) %>%
    left_join(agrupaciones, by = c("CODIGO_AGRUPACION" = "codigo_agrupacion")) %>%
    mutate(id = row_number()) %>%
    select(id_lista = id,
           id_agrupacion,
           codigo_lista = CODIGO_LISTA,
           nombre_lista = NOMBRE_LISTA) -> listas

  # Agregamos los votos en blanco
  listas_vb <- data_frame(id_lista = max(listas$id_lista) + 1,
                          id_agrupacion = agrupaciones_vb$id_agrupacion,
                          codigo_lista = "VB",
                          nombre_lista = "VOTOS en BLANCO"
  )

  listas %>%
    bind_rows(listas_vb) -> listas

  # Distritos
  mesas_totales_lista %>%
    distinct(CODIGO_DISTRITO) %>%
    left_join(descripcion_regiones, by = c('CODIGO_DISTRITO' = "CODIGO_REGION")) %>%
    mutate(id = row_number()) %>%
    select(id_distrito = id,
           codigo_distrito = CODIGO_DISTRITO,
           nombre_distrito = NOMBRE_REGION) -> distritos

  # Secciones
  mesas_totales_lista %>%
    distinct(CODIGO_SECCION) %>%
    left_join(descripcion_regiones, by = c('CODIGO_SECCION' = "CODIGO_REGION")) %>%
    mutate(id = row_number()) %>%
    select(id_seccion = id,
           codigo_seccion = CODIGO_SECCION ,
           nombre_seccion = NOMBRE_REGION) -> secciones

  # Circuitos
  mesas_totales_lista %>%
    distinct(CODIGO_CIRCUITO) %>%
    left_join(descripcion_regiones, by = c('CODIGO_CIRCUITO' = "CODIGO_REGION")) %>%
    mutate(id = row_number()) %>%
    select(id_circuito = id,
           codigo_circuito = CODIGO_CIRCUITO,
           nombre_circuito = NOMBRE_REGION) -> circuitos

  # Mesas
  mesas_totales_lista %>%
    distinct(CODIGO_MESA, CODIGO_DISTRITO, CODIGO_SECCION, CODIGO_CIRCUITO) %>%
    left_join(distritos, by = c('CODIGO_DISTRITO' = "codigo_distrito")) %>%
    left_join(secciones, by = c('CODIGO_SECCION' = "codigo_seccion")) %>%
    left_join(circuitos, by = c('CODIGO_CIRCUITO' = "codigo_circuito")) %>%
    mutate(id = row_number()) %>%
    select(id_mesa = id,
           id_distrito,
           id_seccion,
           id_circuito,
           codigo_mesa = CODIGO_MESA)  -> mesas


  # votos
  mesas_totales_lista %>%
    distinct(CODIGO_MESA, CODIGO_CATEGORIA, CODIGO_LISTA, VOTOS_LISTA) %>%
    left_join(categorias, by=c("CODIGO_CATEGORIA" = "codigo_categoria")) %>%
    left_join(listas, by=c("CODIGO_LISTA" = "codigo_lista")) %>%
    left_join(mesas, by=c("CODIGO_MESA" = "codigo_mesa")) %>%
    mutate(id = row_number()) %>%
    select(id_voto = id,
           id_mesa,
           id_categoria,
           id_lista,
           votos = VOTOS_LISTA) -> votos

  # Votos en blanco
  mesas_totales %>%
    filter(CONTADOR == "VB") %>%
    rename("VOTOS_LISTA" = VALOR) %>%
    mutate(NOMBRE_AGRUPACION = "EN BLANCO") %>%
    left_join(categorias, by=c("CODIGO_CATEGORIA" = "codigo_categoria")) %>%
    left_join(listas, by=c("CONTADOR" = "codigo_lista")) %>%
    left_join(mesas, by=c("CODIGO_MESA" = "codigo_mesa")) %>%
    mutate(id = max(votos$id_voto) + row_number()) %>%
    select(id_voto = id,
           id_mesa,
           id_categoria,
           id_lista,
           votos = VOTOS_LISTA) -> votos_vb

  votos %>%
    bind_rows(votos_vb) -> votos

  # Actualizo escrutadas
  mesas %>%
    left_join(votos %>%
                group_by(id_mesa) %>%
                summarise(votos = sum(votos),
                          escrutada = votos > 0),
              by  = "id_mesa"
    ) %>%
    select(id_mesa,
           id_distrito,
           id_seccion,
           id_circuito,
           codigo_mesa,
           escrutada) -> mesas


  # Totales de votos por categoria
  votos %>%
    group_by(id_categoria) %>%
    summarise(votos = sum(votos)) %>%
    left_join(categorias, by = "id_categoria") %>%
    select(id_categoria,
           codigo_categoria,
           nombre_categoria,
           votos_totales = votos)  %>%
    as.data.frame() -> categorias

  usethis::use_data(meta_agrupaciones, overwrite = TRUE)
  usethis::use_data(agrupaciones, overwrite = TRUE)
  usethis::use_data(categorias, overwrite = TRUE)
  usethis::use_data(listas, overwrite = TRUE)
  usethis::use_data(mesas, overwrite = TRUE)
  usethis::use_data(votos, overwrite = TRUE)
  usethis::use_data(distritos, overwrite = TRUE)
  usethis::use_data(secciones, overwrite = TRUE)
  usethis::use_data(circuitos, overwrite = TRUE)

  # glimpse(meta_agrupaciones)
  # glimpse(agrupaciones)
  # glimpse(categorias)
  # glimpse(listas)
  # glimpse(mesas)
  # glimpse(votos)
  # glimpse(distritos)
  # glimpse(secciones)
  # glimpse(circuitos)

}
