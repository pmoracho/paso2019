controlar_mesa <- function(codigo_mesa) {

  library("tidyverse")
  library("paso2019")

  votos %>%
    left_join(mesas, by = "id_mesa") %>%
    filter(codigo_mesa == codigo_mesa) %>%
    left_join(circuitos, by = "id_circuito") %>%
    left_join(secciones, by = "id_seccion") %>%
    left_join(distritos, by = "id_distrito") %>%
    left_join(listas, by = "id_lista") %>%
    left_join(agrupaciones, by = "id_agrupacion") %>%
    left_join(meta_agrupaciones, by = "id_meta_agrupacion") %>%
    left_join(categorias, by = "id_categoria") %>%
    left_join(establecimientos, by = "id_establecimiento") %>%
    select(nombre_distrito,
           nombre_seccion,
           nombre_circuito,
           nombre_establecimiento,
           codigo_mesa,
           nombre_categoria,
           nombre_meta_agrupacion,
           votos) %>%
    View()
}
