NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEI2 <- head(NEI)
NEI2
head(SCC)
library(lattice)
library(dplyr)
filt <- filter(NEI, year %in% c(1999,2002,2005,2008)) %>% select(Emissions, year) %>% 
  group_by(year) %>%
  summarise(T_Emissions = sum(Emissions)/10^6)
filt$year <- as.factor(filt$year)

png("plot1.png", width=480, height=480)
ggplot(filt, aes(year, T_Emissions)) + geom_bar(stat = "identity") + labs(y = "Emissions (10^6) Tons")
dev.off()


