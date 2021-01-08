#_--------------Covid data set

Covid<- read.csv("D:\\Data Analyst\\sample data sets\\r_projects\\Covid 19 Data\\COVID19_line_list_data.csv")

install.packages(Hmisc)

library(Hmisc)

describe(Covid)

# Cleaning up death column

Covid$death_dummy <- as.integer((Covid$death != 0))

unique(Covid$death_dummy)

#To find death rate

Percent_died <- (sum(Covid$death_dummy)/ nrow(Covid))
Percent_died

# Comparing death rates by Age

dead <- subset(Covid, death_dummy==1)
alive <- subset(Covid, death_dummy == 0)

mean(dead$age, na.rm= TRUE)
mean(alive$age, na.rm= TRUE )

# to test if it is statically significant

t.test(alive$age, dead$age, alternative = "two.sided", conf.level = 0.95)


# Comparing death rates by Gender

men <- subset(Covid, gender == "Male")
women <- subset(Covid, gender == "Female")

mean(men$death_dummy, na.rm= TRUE)
mean(women$death_dummy, na.rm= TRUE )

t.test(men$death_dummy, women$death_dummy, alternative = "two.sided", conf.level = 0.95)
