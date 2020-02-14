NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

names(SCC)
unique(SCC[,"SCC.Level.Two"])


filt1 <-  filter(NEI, fips == "24510") %>% select(Emissions, year, SCC) 
filt2 <- SCC %>% filter((str_detect(str_to_lower(SCC.Level.Two), "vehicle")))
filt3 <- merge(filt1,filt2, by = "SCC") %>% select(Emissions, year) %>% group_by(year) %>%
  summarise(T_Emissions = sum(Emissions))
filt3$year <- as.factor(filt3$year)

png("plot5.png", width=600, height=700)
with(filt3,barplot(T_Emissions,names.arg = year,xlab = "year", ylab = "total pm2.5 emissions(Tons)", main ="emissions from motor vehicle from 1999–2008 in Baltimore City"))
dev.off()
