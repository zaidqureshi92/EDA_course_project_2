library(base)
library(dplyr)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
filt <-  filter(NEI, fips == "24510") %>% select(Emissions, year) %>% 
  group_by(year) %>%
  summarise(T_Emissions = sum(Emissions)) 
filt$year <- as.factor(filt$year)
png("plot2.png", width=480, height=480)

with(filt,barplot(T_Emissions,names.arg = year,xlab = "year", ylab = "emissions", main ="Total emissions in Baltimore City from 1999 to 2008"))
dev.off()
