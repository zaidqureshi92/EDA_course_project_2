NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(stringr)
filt1 <-  NEI %>% select(Emissions, year, SCC) 
filt2 <- SCC %>% filter((str_detect(str_to_lower(SCC.Level.Four), "coal")) & (str_detect(str_to_lower(SCC.Level.One), "comb")))
filt3 <- merge(filt1,filt2, by = "SCC") %>% select(Emissions, year) %>% group_by(year) %>%
  summarise(T_Emissions = sum(Emissions)/10^5)
filt3$year <- as.factor(filt3$year)

png("Plot4.png", width=700, height=700)
with(filt3,barplot(T_Emissions,names.arg = year,xlab = "year", ylab = "total pm2.5 emissions(10^5 tons)", main ="emissions from coal combustion-related sources across US from 1999-2008"))
dev.off()


