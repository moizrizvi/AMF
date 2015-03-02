library(ggplot2)
library(ggmap)
library(plyr)

DK_FILE = '~/AMF/AMF/data/DONNEES_KANZALA.csv'

df <- read.csv(DK_FILE)
df <- rename(df,
             c('identification.GPS_HH.Latitude' = 'lat',
               'identification.GPS_HH.Longitude' = 'lon',
               'identification.GPS_HH.Altitude' = 'alt',
               'identification.GPS_HH.Accuracy' = 'accuracy',
               'identification.date_heure' = 'times',
               'identification.phone_id' = 'phone.ids',
               'identification.aire_de_sante_province' = 'provinces',
               'identification.aire_de_sante_district' = 'districts',
               'identification.aire_de_sante_hz' = 'hz.areas',
               'identification.aire_de_sante' = 'areas',
               'identification.nom_village' = 'villages',
               'identification.LQAS_enum.enumerer_jour' = 'day.enumeration',
               'identification.LQAS_enum.enumerer_HH' = 'HH',
               'identification.nomdechef_HH' = 'name.of.heads',
               'identification.telephone_HH' = 'phone.numbers',
               'identification.mentions_legales' = 'legal.info',
               'legales_non.socio_demographique.age_repondant' = 'resp.ages',
               'legales_non.socio_demographique.sexe_repondant' = 'resp.sexes',
               'legales_non.socio_demographique.total_personnes' = 'num.persons',
               'legales_non.socio_demographique.nbr_femmes_enceinte' = 'num.pregnant',
               'legales_non.socio_demographique.nbr_enfant_sous_5' = 'kids.under.five',
               'legales_non.connaissance_perception.malaria_transmise' = 'malaria.transmitted',
               'legales_non.connaissance_perception.malaria_transmise_autre' = 'sec.malaria',
               'legales_non.connaissance_perception.malaria_signes' = 'malaria.signs',
               'legales_non.connaissance_perception.malaria_signes_autre' = 'sec.malaria.signs',
               'legales_non.connaissance_perception.malaria_prevenir' = 'malaria.prev',
               'legales_non.connaissance_perception.malaria_traitment_simple' = 'prim.malaria.trmt',
               'legales_non.connaissance_perception.malaria_traitment_autre' = 'sec.malaria.trmt',
               'legales_non.prevention.prevention_dans_HH' = 'HH.prev',
               'legales_non.prevention.prevention_dans_HH_autre' = 'sec.HH.prev',
               'legales_non.prevention.tout_personnes_dormi' = 'total.sleeping',
               'legales_non.prevention.enfants_dormi' = 'children.sleeping',
               'legales_non.prevention.enceintes_dormi' = 'pregnant.sleeping',
               'legales_non.prevention.moins_une_MILD_HH' = 'at.least.one.net',
               'legales_non.prevention.moins_impregnee_HH' = 'at.least.one.preg',
               'legales_non.traitement.enfant_fievre' = 'children.fever',
               'legales_non.traitement.enfant_beneficier' = 'children.benefit',
               'legales_non.traitement.enfant_medicament' = 'children.medicine',
               'legales_non.traitement.consulte_enfant' = 'children.consulted',
               'legales_non.distribution.nbr_bonne_mild' = 'num.good.nets',
               'legales_non.distribution.place_dormir' = 'num.places.sleep',
               'legales_non.distribution.MILD_retournees' = 'nets.returned',
               'legales_non.distribution.MILD_par_HH' = 'nets.per.HH',
               'legales_non.distribution.MILD_marque' = 'net.brands',
               'legales_non.distribution.MILD_installees' = 'nets.installed',
               'legales_non.distribution.MILD_emballage' = 'net.packing',
               'start' = 'start',
               'end' = 'end',
               'deviceid' = 'device.id')
             )

# GEOGRAPHIC

m_lon <- mean(df$lon, na.rm=T)
m_lat <- mean(df$lat, na.rm=T)

# UNKNOWN

# identification.signature_of_chef
# legales_non.prevention.obtenu_MILD_ou
# legales_non.prevention.obtenu_MILD_ou_autre
# legales_non.prevention.IPT_utilisez
# legales_non.distribution.distrbution_summary
# legales_non.distribution.photo_installee

### GEOGRAPHICAL PLOTS ###

p <- ggplot(df)

gps.plot <- p + aes(x=lat, 
                    y=lon,
                    color=alt)
gps.plot <- gps.plot + ggtitle("GPS Points")
gps.plot <- gps.plot + xlab("Latitude")
gps.plot <- gps.plot + ylab("Longitude")
gps.plot <- gps.plot + labs(color = "Altitude")
gps.plot <- gps.plot + geom_point()

DRC <- get_map(location = c(lon=m_lon, lat=m_lat), zoom=12)
DRCMap <- ggmap(DRC, extent = "device", legend = "topleft")

overlay <- stat_density2d(aes(x = lon, y = lat, fill = num.good.nets, na.rm=TRUE),
                          geom = "polygon",
                          data = df)

DRCMap + overlay + inset(grob = ggplotGrob(ggplot() + overlay + theme_inset()),
                         xmin = min(df$lon), xmax = Inf, ymin = -Inf, ymax = min(df$lat)
                         )

mapPoints <- mapPoints + geom_point(aes(x = lat, y = lon, na.rm=TRUE), data=df)
mapPoints <- mapPoints + labs(title="Nets Installed", size="Number of nets")


##### HISTOGRAMS ####

prov.hist <- p + geom_histogram(aes(x=provinces))
prov.hist <- prov.hist + xlab("Count")
prov.hist <- prov.hist + ylab("Province")
prov.hist

dist.hist <- p + geom_histogram(aes(x=districts))
dist.hist <- dist.hist + xlab("Count")
dist.hist <- dist.hist + ylab("Districts")
dist.hist

hz.hist <- p + geom_histogram(aes(x=hz.areas))
hz.hist <- hz.hist + xlab("Count")
hz.hist <- hz.hist + ylab("Health Zone")
hz.hist

area.hist <- p + geom_histogram(aes(x=areas))
area.hist <- area.hist + xlab("Count")
area.hist <- area.hist + ylab("Area")
area.hist



