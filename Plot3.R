library(ggplot2)
library(dplyr)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


filt1 <-  filter(NEI, fips == "24510") %>% select(Emissions, year, SCC) 
filt2 <- SCC %>% filter(Data.Category %in% c("Nonpoint","Point","Nonroad","Onroad")) %>% select(SCC, Data.Category)
filt3 <- merge(filt1,filt2, by = "SCC")
filt3 %>% group_by(year, Data.Category) %>% summarise(T_Emissions = sum(Emissions)) 
filt3$year <- as.factor(filt3$year)

png("plot3.png", width=480, height=480)
ggplot(filt3, aes(x=year,y = Emissions)) +geom_bar(stat = "identity")+ facet_wrap(~Data.Category)
dev.off()



