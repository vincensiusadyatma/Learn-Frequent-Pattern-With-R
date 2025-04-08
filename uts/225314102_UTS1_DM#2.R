library(ggplot2)


bandeng <- read.csv('D:/Projects/r_apriori/Learn-Frequent-Pattern-With-R/uts/budidaya_bandeng_2.csv',sep=",")
str(bandeng)

bandeng <- ggplot(data = bandeng, aes(x=Tahun , y=Volume.Produksi,color=Provinsi))
bandeng + geom_line() + geom_text(aes(label = Volume.Produksi),hjust=-0.2,vjust=-0.5)