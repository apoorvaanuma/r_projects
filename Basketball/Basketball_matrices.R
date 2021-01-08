# To fetch a value

Salary
Salary["LeBronJames","2012"]

Goalspergame<-round(FieldGoals/Games,2)
Goalspergame

Goalspergame["ChrisPaul","2012"]

#Transpose a matrix

t(Games)

#Subset of matrix

Games
Games[1:3,6:10]
Games[,c(1,9)]
Games[c(1,8),]

is.matrix(Games[c(1,8),])

# For R to return Matrices even when given funtions Games[1,] or Games[,10], write

Games[1,,drop=F]

b<-MinutesPlayed[1,,drop=F]
b
matplot(t(b), type = "b", pch = 15:18, col=c(1:4,6))

legend("bottomleft", inset =0.01, legend=Players[1],col=c(1:4,6),pch=12:18,horiz = F)

# Function to repeat code

myplot<-function(){

  b<-MinutesPlayed[4,,drop=F]
  b
  matplot(t(b), type = "b", pch = 15:18, col=c(1:4,6))
  
  legend("bottomleft", inset =0.01, legend=Players[4],col=c(1:4,6),pch=12:18,horiz = F)
  
}

myplot()

# to replace with a variable

myplot<-function(rows){
  
  b<-MinutesPlayed[rows,,drop=F]
  b
  matplot(t(b), type = "b", pch = 15:18, col=c(1:4,6))
  
  legend("bottomleft", inset =0.01, legend=Players[rows],col=c(1:4,6),pch=12:18,horiz = F)
  
}

myplot(1:10)


# including both columns, rows and tables

myplot<-function(data,rows){
  
  b<-data[rows,,drop=F]
  b
  matplot(t(b), type = "b", pch = 15:18, col=c(1:4,6))
  
  legend("bottomleft", inset =0.01, legend=Players[rows],col=c(1:4,6),pch=12:18,horiz = F)
  
}

myplot(Salary,1:10) # data table name and numbers of rows we want in visualization, can skip that if want to include all rows



# Insights

#Salary

myplot(Salary,1:10)
        