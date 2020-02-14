NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

names(SCC)
unique(SCC[,"SCC.Level.Two"])


filt1 <-  filter(NEI, fips %in% c("24510","06037")) %>% select(Emissions, year, SCC, fips) 
filt2 <- SCC %>% filter((str_detect(str_to_lower(SCC.Level.Two), "vehicle")))
filt3 <- merge(filt1,filt2, by = "SCC") %>% select(Emissions, year,fips) %>% group_by(year,fips) %>%
  summarise(T_Emissions = sum(Emissions))
filt3$year <- as.factor(filt3$year)

vehiclesBaltimoreNEI <- filt3[filt3$fips == 24510,]
vehiclesBaltimoreNEI$city <- "Baltimore City"
vehiclesLANEI <- filt3[filt3$fips=="06037",]
vehiclesLANEI$city <- "Los Angeles County"
filt4 <- rbind(vehiclesBaltimoreNEI,vehiclesLANEI)


png("plot6.png", width=1000, height=1000)
ggplot(filt4, aes(x=year,y = T_Emissions)) +geom_bar(stat = "identity")+ facet_wrap(~city) +
  ggtitle("Motor vehicle source emissions \nBaltimore City and Los Angeles County") +
  xlab("year") + ylab("Emissions")


dev.off()
