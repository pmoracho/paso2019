# Requerimientos de memoria


modelo_original <- c("paso2019::descripcion_postulaciones", "paso2019::descripcion_regiones",
                  "paso2019::mesas_totales", "paso2019::mesas_totales_lista",
                  "paso2019::mesas_totales_agrp_politica")


size = 0
for (o in modelo_original) {

  os <- object.size(eval(parse(text=o)))
  message(paste0(o, ": "), appendLF = F)
  print(os, units='auto')

  size = size + os
}
message("Requerimiento de memoria del modelo original: ", appendLF = F); print(size, units='auto')


modelo_nuevo <- c("paso2019::agrupaciones", "paso2019::categorias",
                  "paso2019::circuitos", "paso2019::distritos", "paso2019::listas",
                  "paso2019::mesas", "paso2019::meta_agrupaciones",
                  "paso2019::secciones", "paso2019::votos", "paso2019::establecimientos",
                  "paso2019::scrap_establecimientos_mesas")


size = 0
for (o in modelo_nuevo) {

  os <- object.size(eval(parse(text=o)))
  message(paste0(o, ": "), appendLF = F)
  print(os, units='auto')

  size = size + os
}
message("Requerimiento de memoria del modelo nuevo: ", appendLF = F); print(size, units='auto')

