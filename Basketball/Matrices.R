#Matrix basics

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
