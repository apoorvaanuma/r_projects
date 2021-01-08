######################################  Matrices #########################################

#create a matrix

data<- 1:50
A<- matrix(data=data,5,10)
A

A[5,9]

B<-matrix(data=data,5,10,byrow=T)
B


#rbind & cbind

r1<- c(1:6)
r2<- c(7:12)
r3<- c(13:18)

c<-rbind(r1,r2,r3)
c

d<-cbind(r1,r2,r3)
d

#Naming vectors

Sasi<- 1:8
Sasi

#to check if name is available

names(Appu) <- c("a","b","c")
Appu

#to clear assigned name
names(Appu)<- NULL
Appu


#Naming matix dimensions

temp<- rep(c("1","2","3"),4) # repeats 4 times

temp<- rep(c("1","2","3"),times= 4) # repeats 4 times

temp<- rep(c("1","2","3"),each = 4) # repeats each element 4 times

abc<- matrix(temp,3,4)
abc

rownames(abc)<- c("a","b","c")
abc

colnames(abc)<- c("d","e","f","g")
abc

#Changing value

abc[3,4]<-0
abc

#Subset of matrix

x<-1:5
x

x[c(1,4)]
x[3]


########################  Data frames creation from a file ###################################

## to select data file manually

stats<- read.csv(file.choose())
stats

## To set working directory and read data

setwd("D:\\Data Analyst\\sample data sets\\r_projects")


getwd()

rm(stats)

stats<-read.csv("Demographic data\\P2-Demographic-Data.csv")
stats

#------------------Exploring data

nrow(stats)  # number of rows

ncol(stats) # number of cols

head(stats) # gives first 6 rows

head(stats, n= 11) # to get more rows

tail(stats) # gives bottom 6 rows

tail(stats, n=12) # to get more columns

str(stats) # to get structure for datatypes, very different from R UNIF

summary(stats)

runif(stats) # to get uniform distribution


#----------------------using $, to get whole column

stats$Country.Name
stats[,"Country.Name"]

b<-levels(stats$Income.Group)
b

#---------------------Basic operations with a Data frame

#subsetting
stats[1:10,]
stats[c(4,100),]

# a row in data frame stays data frame even after sub setting while a column turns into vector and drop=F is needed

is.data.frame(stats[1,]) # no need to drop=F
is.data.frame(stats[,1])
is.data.frame(stats[,1,drop=F])

#multiply columns

head(stats)
stats$Birth.rate*stats$Internet.users

#add column

head(stats)
stats$Mycalc<- stats$Birth.rate * stats$Internet.users

#add column from non existing columns

stats$xyz<- 1:5
head(stats, n= 20)

#remove column

stats$Mycalc<- NULL
stats$xyz <- NULL
head(stats)

# Filtering data frames

head(stats)
filter<- stats$Internet.users >2
filter
stats[!filter,] # only returns FLASE rows
stats[filter,]  # returns TRUE rows

stats[stats$Birth.rate>44,]
stats[stats$Birth.rate>40 & stats$Internet.users>2 & (stats$Income.Group=="Low income" | stats$Income.Group=="Upper middle income"),]

# to filter on a country

stats[stats$Country.Name=="Malta",]

#----------------------------Introduction to qplot

library(ggplot2)

qplot(data=stats, x=Internet.users, y=Birth.rate)
qplot(data=stats, x=Internet.users, y=Birth.rate, size=3)
qplot(data=stats, x=Internet.users, y=Birth.rate, size=I(3)) # if do not want legend
qplot(data=stats, x=Internet.users, y=Birth.rate, size=I(3),colour = I("blue"))

# for 3 parameters

qplot(data=stats, x=Internet.users, y= Birth.rate, size =I(4), colour= Income.Group)

#---------------another data set to create data frame from vectors


Countries_2012_Dataset <- c("Aruba","Afghanistan","Angola","Albania","United Arab Emirates","Argentina","Armenia","Antigua and Barbuda","Australia","Austria","Azerbaijan","Burundi","Belgium","Benin","Burkina Faso","Bangladesh","Bulgaria","Bahrain","Bahamas, The","Bosnia and Herzegovina","Belarus","Belize","Bermuda","Bolivia","Brazil","Barbados","Brunei Darussalam","Bhutan","Botswana","Central African Republic","Canada","Switzerland","Chile","China","Cote d'Ivoire","Cameroon","Congo, Rep.","Colombia","Comoros","Cabo Verde","Costa Rica","Cuba","Cayman Islands","Cyprus","Czech Republic","Germany","Djibouti","Denmark","Dominican Republic","Algeria","Ecuador","Egypt, Arab Rep.","Eritrea","Spain","Estonia","Ethiopia","Finland","Fiji","France","Micronesia, Fed. Sts.","Gabon","United Kingdom","Georgia","Ghana","Guinea","Gambia, The","Guinea-Bissau","Equatorial Guinea","Greece","Grenada","Greenland","Guatemala","Guam","Guyana","Hong Kong SAR, China","Honduras","Croatia","Haiti","Hungary","Indonesia","India","Ireland","Iran, Islamic Rep.","Iraq","Iceland","Israel","Italy","Jamaica","Jordan","Japan","Kazakhstan","Kenya","Kyrgyz Republic","Cambodia","Kiribati","Korea, Rep.","Kuwait","Lao PDR","Lebanon","Liberia","Libya","St. Lucia","Liechtenstein","Sri Lanka","Lesotho","Lithuania","Luxembourg","Latvia","Macao SAR, China","Morocco","Moldova","Madagascar","Maldives","Mexico","Macedonia, FYR","Mali","Malta","Myanmar","Montenegro","Mongolia","Mozambique","Mauritania","Mauritius","Malawi","Malaysia","Namibia","New Caledonia","Niger","Nigeria","Nicaragua","Netherlands","Norway","Nepal","New Zealand","Oman","Pakistan","Panama","Peru","Philippines","Papua New Guinea","Poland","Puerto Rico","Portugal","Paraguay","French Polynesia","Qatar","Romania","Russian Federation","Rwanda","Saudi Arabia","Sudan","Senegal","Singapore","Solomon Islands","Sierra Leone","El Salvador","Somalia","Serbia","South Sudan","Sao Tome and Principe","Suriname","Slovak Republic","Slovenia","Sweden","Swaziland","Seychelles","Syrian Arab Republic","Chad","Togo","Thailand","Tajikistan","Turkmenistan","Timor-Leste","Tonga","Trinidad and Tobago","Tunisia","Turkey","Tanzania","Uganda","Ukraine","Uruguay","United States","Uzbekistan","St. Vincent and the Grenadines","Venezuela, RB","Virgin Islands (U.S.)","Vietnam","Vanuatu","West Bank and Gaza","Samoa","Yemen, Rep.","South Africa","Congo, Dem. Rep.","Zambia","Zimbabwe")
Codes_2012_Dataset <- c("ABW","AFG","AGO","ALB","ARE","ARG","ARM","ATG","AUS","AUT","AZE","BDI","BEL","BEN","BFA","BGD","BGR","BHR","BHS","BIH","BLR","BLZ","BMU","BOL","BRA","BRB","BRN","BTN","BWA","CAF","CAN","CHE","CHL","CHN","CIV","CMR","COG","COL","COM","CPV","CRI","CUB","CYM","CYP","CZE","DEU","DJI","DNK","DOM","DZA","ECU","EGY","ERI","ESP","EST","ETH","FIN","FJI","FRA","FSM","GAB","GBR","GEO","GHA","GIN","GMB","GNB","GNQ","GRC","GRD","GRL","GTM","GUM","GUY","HKG","HND","HRV","HTI","HUN","IDN","IND","IRL","IRN","IRQ","ISL","ISR","ITA","JAM","JOR","JPN","KAZ","KEN","KGZ","KHM","KIR","KOR","KWT","LAO","LBN","LBR","LBY","LCA","LIE","LKA","LSO","LTU","LUX","LVA","MAC","MAR","MDA","MDG","MDV","MEX","MKD","MLI","MLT","MMR","MNE","MNG","MOZ","MRT","MUS","MWI","MYS","NAM","NCL","NER","NGA","NIC","NLD","NOR","NPL","NZL","OMN","PAK","PAN","PER","PHL","PNG","POL","PRI","PRT","PRY","PYF","QAT","ROU","RUS","RWA","SAU","SDN","SEN","SGP","SLB","SLE","SLV","SOM","SRB","SSD","STP","SUR","SVK","SVN","SWE","SWZ","SYC","SYR","TCD","TGO","THA","TJK","TKM","TLS","TON","TTO","TUN","TUR","TZA","UGA","UKR","URY","USA","UZB","VCT","VEN","VIR","VNM","VUT","PSE","WSM","YEM","ZAF","COD","ZMB","ZWE")
Regions_2012_Dataset <- c("The Americas","Asia","Africa","Europe","Middle East","The Americas","Asia","The Americas","Oceania","Europe","Asia","Africa","Europe","Africa","Africa","Asia","Europe","Middle East","The Americas","Europe","Europe","The Americas","The Americas","The Americas","The Americas","The Americas","Asia","Asia","Africa","Africa","The Americas","Europe","The Americas","Asia","Africa","Africa","Africa","The Americas","Africa","Africa","The Americas","The Americas","The Americas","Europe","Europe","Europe","Africa","Europe","The Americas","Africa","The Americas","Africa","Africa","Europe","Europe","Africa","Europe","Oceania","Europe","Oceania","Africa","Europe","Asia","Africa","Africa","Africa","Africa","Africa","Europe","The Americas","The Americas","The Americas","Oceania","The Americas","Asia","The Americas","Europe","The Americas","Europe","Asia","Asia","Europe","Middle East","Middle East","Europe","Middle East","Europe","The Americas","Middle East","Asia","Asia","Africa","Asia","Asia","Oceania","Asia","Middle East","Asia","Middle East","Africa","Africa","The Americas","Europe","Asia","Africa","Europe","Europe","Europe","Asia","Africa","Europe","Africa","Asia","The Americas","Europe","Africa","Europe","Asia","Europe","Asia","Africa","Africa","Africa","Africa","Asia","Africa","Oceania","Africa","Africa","The Americas","Europe","Europe","Asia","Oceania","Middle East","Asia","The Americas","The Americas","Asia","Oceania","Europe","The Americas","Europe","The Americas","Oceania","Middle East","Europe","Europe","Africa","Middle East","Africa","Africa","Asia","Oceania","Africa","The Americas","Africa","Europe","Africa","Africa","The Americas","Europe","Europe","Europe","Africa","Africa","Middle East","Africa","Africa","Asia","Asia","Asia","Asia","Oceania","The Americas","Africa","Europe","Africa","Africa","Europe","The Americas","The Americas","Asia","The Americas","The Americas","The Americas","Asia","Oceania","Middle East","Oceania","Middle East","Africa","Africa","Africa","Africa")


my_data<-data.frame(Countries_2012_Dataset, Codes_2012_Dataset,Regions_2012_Dataset)
my_data

summary(my_data)

# Change column names

colnames(my_data)<- c("Country", "Codes", "Regions")

head(my_data)

# Or using below method when you know to change column names before hand

rm(my_data)

data<-data.frame(Country=Countries_2012_Dataset, Codes=Codes_2012_Dataset, Regions=Regions_2012_Dataset )
data

summary(data)

str(data)

#-------Merging/Joining data frames, data and stats

merged <- merge(stats,data,by.x="Country.Code", by.y= "Codes") # Join tables and common columns
merged

merged$Country <- NULL

str(merged)

head(merged)

qplot(data=merged,x=Internet.users, y=Birth.rate)

qplot(data=merged,x=Internet.users, y=Birth.rate, colour= Regions)

qplot(data=merged,x=Internet.users, y=Birth.rate, colour= Regions, shape=I(9), size= I(5)) #shapes

qplot(data=merged,x=Internet.users, y=Birth.rate, colour= Regions, shape=I(19), size= I(5), 
      alpha = I(0.7)) # transparency of shapes

qplot(data=merged,x=Internet.users, y=Birth.rate, colour= Regions, shape=I(19), size= I(5), 
      alpha = I(0.7), main= "Demographic Data") 








