# R basics

# Data variables

# Integer

#L denotes integer, used only while performing arithmatic operations

x <-2L
typeof(x)

#double
y <-2.5

#complex
z <- 3 + 2i
typeof(z)

#character
a<- "b"

#logical
a1<- TRUE


#-----------------------
  
# Arithmatic operations
  
A <- 15
B <- 20

C <- A+B

var1<- 3.5
var2<- 4

result <- var1/var2

# square root
ab<- sqrt(var2)


#to join 2 characters

greet <- "Hello"
who<- "Sai"

when<- paste(greet,who)
when


# Logical operators
#Equal to ==
# Not equal !=
# |,>,<,>=,<=&, !, isTRUE(x)

abc<-  !(5>1)
def<- 5<2

abc|def

4>5
4==5


#Loops

#While(logical expression){condition}

a<-0

while(a<10){
  a <- a+1
print(a)
}


#For loop, used in vectors to indicate sequence
#for(iterations of the loop){}

for(i in 1:6){
  print("Hello R")
}


for(i in 10:15){
  print(i)
}

#generate random numbers

a<- rnorm(1)
a

if(a<0){
  b <- "Negative"
}else if(a>0){
  b<- "Positive"
  }else
  {b<-"Equal to 0"
  }
print(b)

##### Hit ratio of random number between -1 and +1 

N <- 10000000
counter<-0
  
for (i in rnorm(N)){
  if(i<1 & i>-1){
    counter <- counter+1
  }
}
answer <- counter/N
answer



##############    Vectors, array can be only of 1 data type

abc<- c(1,2,3,4,56)
abc2<- c("ab","cd","ef")

# sequence can be denoted as :
# seq(1,5) and 1:5 gives same answer

#seq(start of seq, end of seq, step)

seq(1,20,3)

# rep() to replicate

d<- rep(9,60)
d

# vector is used to create a combination of data types in create, seq or repeat

# to access single value, []

a<- c(1,2,3,4,5)
a

a[1] # first value
a[-1] # everything but first value
a[1:4] #first 4 char

a[seq(1,5,2)]

a<- c(1,2,33,4,56)
b<- c(1,-5,4,7,98)
d<- a+b
d

e<- a-b
e

f<-a/b
f

g<- a*b
g

#####

N<- 20000000

a<- rnorm(N)
b<- rnorm(N)

c<- a*b #vectorized approach
c

d<- rep(NA,N) #de-vectorised approach
for(i in 1:N){
  d[i] <- a[i] * b[i]
}
d


--------------
  
a<- 1:5
b<- 6:10
c<- a+b
c

a<-rep("Sasi",100)
a

#function to activate a package is LIBRARY