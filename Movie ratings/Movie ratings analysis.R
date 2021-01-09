#################################### Movie ratings analysis #####################################################

setwd("D:\\Data Analyst\\sample data sets\\r_projects\\Movie ratings")

getwd()

movies<- read.csv("Movie-Ratings.csv")
head(movies)

colnames(movies)<- c("Film", "Genre", "CriticRatings", "AudienceRating", "Budget", "Year")

head(movies)

str(movies)

summary(movies)

movies$Year <- factor(movies$Year)
movies$Year

levels(movies$Year) # to know distinct movie years

#----------Aesthetics

library(ggplot2)

plot <- ggplot(data=movies, aes(x=CriticRatings, y= AudienceRating))
plot

#---------Geometry

plot <- ggplot(data=movies, aes(x=CriticRatings, y= AudienceRating)) + geom_point()
plot

#---------Add color and size


plot <- ggplot(data=movies, aes(x=CriticRatings, y= AudienceRating, colour= Genre, size = Budget)) + geom_point()
plot

#---------Plotting with layers

plot <- ggplot(data=movies, aes(x=CriticRatings, y= AudienceRating, colour= Genre, size = Budget))
plot

plot+ geom_point()

plot+ geom_line()+ geom_point()

#---------Overriding aesthetics

plot <- ggplot(data=movies, aes(x=CriticRatings, y= AudienceRating, colour= Genre, size = Budget))
plot

#Examples

plot + geom_point(aes(size = CriticRatings))

plot+geom_point(aes(x=Budget))

plot+ geom_line(size=1)+ geom_point()

plot+ geom_point(aes(x=Budget))+xlab("Budget $$$")


#-------Mapping vs Setting

plot <- ggplot(data=movies, aes(x=CriticRatings, y= AudienceRating))

plot+geom_point(aes(colour=Genre)) # through Mapping colour to a variable

plot+ geom_point(colour= "Dark Blue") # through Setting, colour is set to colour


plot+geom_point(aes(size=Budget)) # Map

plot+geom_point(size=2) # Set


#-------Histograms and Density charts


plot <- ggplot(data=movies, aes(x=Budget))

plot+geom_histogram(binwidth = 2)

plot+geom_histogram(binwidth = 2, aes(fill=Genre)) # add colour

plot+geom_histogram(binwidth = 2, aes(fill=Genre), colour= "Black") # add colour and border

plot+geom_density(aes(fill=Genre)) # Density charts

plot+geom_density(aes(fill=Genre), position = "stack")


#------Starting layers

t<- ggplot(data=movies, aes(x=AudienceRating))

t+geom_histogram(binwidth =10, fill= "White", colour="Blue")

t+geom_histogram(binwidth =10, fill= "White", aes(x=CriticRatings), colour="Blue")

t <- ggplot() #skeleton plot
t

#-----Smoothing charts

z<- ggplot(data=movies, aes(x=CriticRatings, y=AudienceRating, colour= Genre))

z+geom_point()+geom_smooth(fill=NA)

#---Boxplots

z<- ggplot(data=movies, aes(x=Genre, y=AudienceRating, colour= Genre))

z+geom_boxplot()

z+geom_boxplot(size=1.2)

z+geom_boxplot(size=1.2)+geom_point()

z+geom_boxplot(size=1.2)+geom_jitter() # to evenly distribute points

z + geom_jitter()+ geom_boxplot(size=1.2, alpha=0.1) # alpha for transparency of boxes in box plot



#------Using Facets, to segregate with whatever filter

a<- ggplot(data=movies, aes(x=Budget))

a+geom_histogram(binwidth =10,aes(fill=Genre), colour="Black")

a+geom_histogram(binwidth =10,aes(fill=Genre), colour="Black") + facet_grid(Genre~., scales="free")

a+geom_histogram(binwidth =10,aes(fill=Genre), colour="Black") + facet_grid(Year~., scales="free")


#---Scatter plots


b<- ggplot(data=movies, aes(x=CriticRatings, y=AudienceRating, colour= Genre))

b+geom_point(size=3)

b+geom_point(size=3)+ facet_grid(Genre~.)

b+geom_point(size=3) + facet_grid(.~Year)

b+geom_point(size=3) + facet_grid(Genre~Year)

b+geom_point(size=3) + geom_smooth()+ facet_grid(Genre~Year)

b+geom_point(aes(size=Budget)) + geom_smooth()+ facet_grid(Genre~Year)


#------Coordinates

c<- ggplot(data=movies, aes(x=CriticRatings, y=AudienceRating, colour= Genre, size=Budget))

c+geom_point()

c+ geom_point() + xlim(50,100) +ylim(50,100) # to remove negative coordinates and limit required coordinates

d <- ggplot(data=movies, aes(x=Budget))

d+ geom_histogram(binwidth = 10, aes(fill=Genre), colour = "Black") + ylim(0,100)

# But cutting limits does not represesnt whole data, so we zoom in

d+ geom_histogram(binwidth = 10, aes(fill=Genre), colour = "Black") + coord_cartesian(ylim=c(0,50))

# so zooming in chart that was originally not clear

b+geom_point(aes(size=Budget)) + geom_smooth()+ facet_grid(Genre~Year) + coord_cartesian(ylim=c(0,100))


#---------Themes

e<- ggplot(data=movies, aes(x=Budget))

hist<-e+geom_histogram(binwidth=10, aes(fill=Genre), colour="Black")

hist

#label

hist+xlab("Money")+ylab("No.of Movies") 

#label formatting

hist+xlab("Money")+ylab("No.of Movies") + theme (axis.title.x = element_text (colour="DarkGreen", size=30)
,axis.title.y=element_text(colour="Red", size=30))

# tick mark formatting

hist+xlab("Money")+ylab("No.of Movies") + theme (axis.title.x = element_text (colour="DarkGreen", size=30)
                                                 ,axis.title.y=element_text(colour="Red", size=30),
                                                 axis.text.x= element_text(size=20),
                                                 axis.text.y= element_text(size=20))

# Title and legend


hist+xlab("Money")+ylab("No.of Movies") + 
  ggtitle("Movie Budget Dist") +
  theme (axis.title.x = element_text (colour="DarkGreen", size=30)
                                                 ,axis.title.y=element_text(colour="Red", size=30),
                                                 axis.text.x= element_text(size=20),
                                                 axis.text.y= element_text(size=20),
                                                 
                                                 legend.title=element_text(size=30),
                                                 legend.text=element_text(size=20),
                                                 legend.position = c(1,1),
                                                 legend.justification = c(1,1),
         
         plot.title = element_text(colour="DarkBlue",
         size =40, family = "Courier"))




