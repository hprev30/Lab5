#peru-----
install.packages('readxl')
library('readxl')
alaska <- read_xlsx("C:/Users/hjp4906/Desktop/Lab5/Alaska.xlsx")
peru <- read_xlsx("C:/Users/hjp4906/Desktop/Lab5/Peru.xlsx")
gom <- read.csv(file = "C:/Users/hjp4906/Desktop/Lab5/GOM.csv")

library(stringr)
install.packages('stringr')
peru.a <- as.numeric(str_extract(peru$LAT, '^[0-9]+'))
peru.b <- str_extract(peru$LAT, '[0-9]*\\.?[0-9A-Za-z]*S')
peru.c <- as.numeric(str_extract(peru.b, '^[0-9]*\\.?[0-9]*'))
str(peru.c)

peru.min <- peru.c/60
peru.deg <- (peru.a + peru.min)*-1
peru$LAT <- peru.deg

peru.a.lon <- as.numeric(str_extract(peru$LONG, '^[0-9]+'))
peru.b.lon <- str_extract(peru$LONG, '[0-9]*\\.?[0-9A-Za-z]*$')
peru.c.lon <- as.numeric(str_extract(peru.b.lon, '^[0-9]*\\.?[0-9]*'))
str(peru.c)

deg_long <- (peru.a.lon + peru.c.lon/60)*-1
peru$LONG <- deg_long
write.csv(x=peru, file='peru.fixed.csv')
#-----


yr <- as.character(alaska$year)
mo <- as.character(alaska$month)
mo <- str_c("0", mo, sep="")
yr_mo <- str_c(yr, mo, sep='-')
yr_mo <- as.POSIXct(strptime(x=yr_mo, format = "%Y-%m"))
view(yr_mo)

alaska$date <- yr_mo
write.csv(x=alaska, file='alaska.fixed.csv')
write.tab(x=alaska, file='alaska,fixed.txt')



gom.yr <- as.character(gom$Year)
gom.mo <- as.character(gom$Month)
gom.mo <- str_pad(gom.mo, 2, pad = '0')
gom.day <- as.character(gom$Day)
gom.day <- str_pad(gom.day, 2, pad='0')
yr.mo.day <- str_c(gom.yr, gom.mo, gom.day, sep='-')
yr.mo.day <- as.POSIXct(strptime(x=yr.mo.day, format= "%Y-%m-%d"))
gom$date <- yr.mo.day
write.csv(x=gom, file='gom.fixed.csv')
