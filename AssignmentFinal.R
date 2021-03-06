##author:Yan Zeng
##Date:5-12-2013
##title:function of plot timeseries of different class
##input:modis 23 image of a year,classification image,classification table


update.packages(checkBuilt=TRUE, ask = FALSE)
library(raster)
library(sp)
library(ggplot2)

source('subfunctions.R')
source('Mainfunction.R')

##download data

data<-dl_from_dropbox('Lesson8_YanZeng.zip','68nn2jigyklz8mh')
unzip(file.path(datdir, "Lesson8_YanZeng.zip"), exdir = datdir)
# 
# # ##set work directory of r file
# # 
##make classfication table ClassTable<-data.frame(classcode=c(1:16)) 
ClassTable$class<-c('Evergreen Needleaf forest','evergreen broadleaf forst','deciduous needleleaf forest','deciduous broadleaf forest','mixed
forests','closed shrublands','open shrublands','woody savannas','savannas','grasslands','permanent wetlands','croplands','urban and
built-up','cropland/natural vegetation mosaic','snow and ice','barren or sparsely vegetated') 
ClassTable$cols <- c("chartreuse","darkolivegreen1","darkgreen","chartreuse4","darkolivegreen4","brown", "lightpink", "yellow","dark grey","chartreuse3","cyan","burlywood","red","orange","white","beige")
save(ClassTable,file="ClassTableofModisLandCover.RData")

##import LandCovermap 
LandCover<-raster('MCD12Q1.A2005001.h18v03.005.2011085003115_Land_Cover_Type_1.tif')
LandCover[LandCover==0]<-NA
plot(LandCover) ##plot with meaningful legned 
plot(LandCover, col=ClassTable$cols, legend=FALSE,main='MODIS Landcover map') 
legend('bottomright',legend=ClassTable$class, fill=ClassTable$cols,cex=0.6) 
##make a list of modis data 
list <- list.files(pattern="\\NDVI.tif$",recursive = TRUE) # without directories 
modis<-stack(x=list) 
save(LandCover,file='ModisLandCover.RData') 
save(modis,file='ModisDataofyear2012.RData')


##call function
MakeHistofMean(modis,LandCover)
TimeSeriesofModis(modis,LandCover,ClassTable)

