library(ggplot2)
library(ggmap)

df <- read.csv('~/AMF/DRC_App/data/DONNEES_KANZALA.csv')

# GEOGRAPHIC

lat <- df$identification.GPS_HH.Latitude
lon <- df$identification.GPS_HH.Longitude
m_lon <- mean(lon, na.rm=T)
m_lat <- mean(lat, na.rm=T)
alt <- df$identification.GPS_HH.Altitude
accuracy <- df$identification.GPS_HH.Accuracy

# IDENTIFICATION

times <- df$identification.date_heure
phone.ids <-  df$identification.phone_id
provinces <- df$identification.aire_de_sante_province
districts <- df$identification.aire_de_sante_district
hz.areas <- df$identification.aire_de_sante_hz
areas <- df$identification.aire_de_sante
villages <- df$identification.nom_village
day.enumeration <- df$identification.LQAS_enum.enumerer_jour
HH <- df$identification.LQAS_enum.enumerer_HH
name.of.heads <- df$identification.nomdechef_HH
phone.numbers <- df$identification.telephone_HH
legal.info <- df$identification.mentions_legales

# DEMOGRAPHICS

resp.ages <- df$legales_non.socio_demographique.age_repondant
resp.sexes <- df$legales_non.socio_demographique.sexe_repondant
num.persons <- df$legales_non.socio_demographique.total_personnes
num.pregnant <- df$legales_non.socio_demographique.nbr_femmes_enceinte
kids.under.five <- df$legales_non.socio_demographique.nbr_enfant_sous_5
malaria.transmitted <- df$legales_non.connaissance_perception.malaria_transmise
sec.malaria <- df$legales_non.connaissance_perception.malaria_transmise_autre
malaria.signs <- df$legales_non.connaissance_perception.malaria_signes
sec.malaria.signs <- df$legales_non.connaissance_perception.malaria_signes_autre
malaria.prev <- df$legales_non.connaissance_perception.malaria_prevenir
prim.malaria.trmt <- df$legales_non.connaissance_perception.malaria_traitment_simple
sec.malaria.trmt <- df$legales_non.connaissance_perception.malaria_traitment_autre

# PREVENTION

HH.prev <- df$legales_non.prevention.prevention_dans_HH
sec.HH.prev <- df$legales_non.prevention.prevention_dans_HH_autre
total.sleeping <- df$legales_non.prevention.tout_personnes_dormi
children.sleeping <- df$legales_non.prevention.enfants_dormi
pregnant.sleeping <- df$legales_non.prevention.enceintes_dormi
at.least.one.net <- df$legales_non.prevention.moins_une_MILD_HH
at.least.one.preg <- df$legales_non.prevention.moins_impregnee_HH

# TREATMENT

children.fever <- df$legales_non.traitement.enfant_fievre
children.benefit <- df$legales_non.traitement.enfant_beneficier
children.medicine <- df$legales_non.traitement.enfant_medicament
children.consulted <- df$legales_non.traitement.consulte_enfant

# DISTRIBUTION

num.good.nets <- df$legales_non.distribution.nbr_bonne_mild
num.places.sleep <- df$legales_non.distribution.place_dormir
nets.returned <- df$legales_non.distribution.MILD_retournees
nets.per.HH <- df$legales_non.distribution.MILD_par_HH
net.brands <- df$legales_non.distribution.MILD_marque
nets.installed <- df$legales_non.distribution.MILD_installees
net.packing <- df$legales_non.distribution.MILD_emballage

# TIMES, ETC

start <- df$start
end <- df$end
device.id <- df$deviceid

# UNKNOWN

# identification.signature_of_chef
# legales_non.prevention.obtenu_MILD_ou
# legales_non.prevention.obtenu_MILD_ou_autre
# legales_non.prevention.IPT_utilisez
# legales_non.distribution.distrbution_summary
# legales_non.distribution.photo_installee

### GEOGRAPHICAL PLOTS ###

p <- ggplot(df)

gps.plot <- p + aes(x=identification.GPS_HH.Latitude, 
                      y=identification.GPS_HH.Longitude,
                      color=identification.GPS_HH.Altitude)
gps.plot <- gps.plot + ggtitle("GPS Points")
gps.plot <- gps.plot + xlab("Latitude")
gps.plot <- gps.plot + ylab("Longitude")
gps.plot <- gps.plot + labs(color = "Altitude")

gps.plot <- gps.plot + geom_point()

gps.plot

map <- get_map(location = c(lon=m_lon, lat=m_lat), zoom=12)

mapPoints <- ggmap(map)
          +  geom_point(aes(x = identification.GPS_HH.Longitude, 
                            y = identification.GPS_HH.Latitude), 
                        data=df)

mapPoints <- mapPoints + labs(title="Nets Installed", size="Number of nets")

mapPoints
