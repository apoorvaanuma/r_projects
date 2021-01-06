diamonds <- read.csv(file.choose())

install.packages("ggplot2")

ggplot(data=diamonds, 
       aes(x=carat, y=price, colour=clarity))+
  geom_point(alpha=0.1)+
  geom_smooth()

qplot(data=diamonds, carat,price,color=clarity,facets=.~clarity)
