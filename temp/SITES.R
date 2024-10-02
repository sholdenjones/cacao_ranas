library(iNEXT)
library(ggplot2)
library(devtools)
library(httr)

#https://www.youtube.com/watch?v=24PtDhIYg8g tutorial 

#setwd ('/Users/franciscovelasquez/Desktop/CodeRUB/FCATFROGS')
#read.table('/Users/franciscovelasquez/Desktop/CodeRUB/FCATFROGS/SRT.txt' , fill = T, header = FALSE )
#list.files()


#library(readxl)
#SITESRAR <- read_excel("SITESRAR.xlsx", col_types = c("text", 
#                                                      "numeric", "numeric", "numeric", "numeric", 
#                                                      "numeric", "numeric", "numeric", "numeric", 
#                                                      "numeric", "numeric", "numeric", "numeric", 
#                                                      "numeric", "numeric", "numeric", "numeric", 
#                                                      "numeric", "numeric", "numeric", "numeric", 
#                                                      "numeric"))
#View(SITESRAR)
#Step 1 load the data

#read.table('/Users/franciscovelasquez/Desktop/CodeRUB/FCATFROGS/SRT.txt')

attach(SITESRAR)

dats=SITESRAR

head(dats)

#You can upload more matrix to do one 

#Convert the data frame into a list matrix for inext 

datsi <- as.matrix(apply(dats[,-1],2, as.integer))

#Name as row names

row.names(datsi) <- dats[,1]

head(datsi)

#List the matrix or matrices 

didatsi = list(type=datsi)

str(datsi)

edit = edit(datsi) #to look if all are good 


out <- iNEXT(datsi)
out

ggiNEXT(out, type=1, facet.var="Assemblage")

iNEXT(datsi, q=0, datatype="abundance")

#Alpha diversity  

out.inci = iNEXT(didatsi, q=0, datatype = "abundance") 
out.inci

#SC sampling completeness 

#For ants: 84.62% (n of 65, ci= 78-90) duplication of the sample effort mean into 93.42% of 
#the SC 

#Figures 

FigDivA = ggiNEXT(out.inci, type = 1, color.var <- "Order.q", z <- fortify(out.inc), 
                      z$col <- z$shape <- factor(z$Order.q))  
#Figure alpha diversity 
ggiNEXT(out.inci, type =2)
par(mfrow=c(2,3))

#figures species diversity 
fig1 <- plot(out.inc, col= "Blue")
fig1
#figures sample coverage  
fig2 <-plot(out.inc, type = 2, col= "Blue")
fig2
#figures species diversity against sample coverage   
fig3 <-plot(out.inc, type = 3, col= "Blue")
fig3

ggiNEXT(divant)

#FigD = ggiNEXT(out.inc, type = 1, color.var <- "Order.q", z <- fortify(out.inc), 
#                     z$col <- z$shape <- factor(z$Order.q))  
