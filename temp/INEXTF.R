library(iNEXT)
library(ggplot2)
library(devtools)
library(httr)

#https://www.youtube.com/watch?v=24PtDhIYg8g tutorial 

#Step 1 load the data

attach(DH1)

data.ants=read.table("DH1.txt", head= T)

data.ants <- DH1
head(data.ants)


#You can upload more matrix to do one 

#Convert the data frame into a list matrix for inext 

divh <- as.matrix(apply(data.ants[,-1],2, as.integer))

#Name as row names

row.names(divh) <- data.ants[,1]

#List the matrix or matrices 

divant = list(Formicidae=divh)

str(divant)

edit = edit(divant) #to look if all are good 

#Alpha diversity  

out.inc = iNEXT(divant, q=0, datatype = "incidence_raw") 
out.inc

#SC sampling completeness 

#For ants: 84.62% (n of 65, ci= 78-90) duplication of the sample effort mean into 93.42% of 
#the SC 

#Figures 

#FigDivAlpha = ggiNEXT(out.inc, type = 1, color.var <- "Order.q", z <- fortify(out.inc), 
                     # z$col <- z$shape <- factor(z$Order.q)) Revisar 
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

