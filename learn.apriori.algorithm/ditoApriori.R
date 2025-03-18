install.packages("arules")
library(arules)
library(arulesViz)
library(ggplot2)
library(magrittr)

# Cek working directory
getwd()

# Baca data transaksi
data_trans1 <- read.transactions(
  file = 'D://Projects/r_apriori/Learn-Frequent-Pattern-With-R/learn.apriori.algorithm/items.csv',
  sep = ","
)

# Periksa transaksi yang telah dimuat
inspect(data_trans1)

# Menampilkan daftar item
data_trans1@itemInfo

# Menampilkan Data
data_trans1@data

# Menampilkan Item frequency
itemFrequency(data_trans1, type="absolute")

# Simpan dan urutkan item frequency dalam bentuk absolute
data1_item <- sort(itemFrequency(data_trans1, type="absolute"), decreasing = TRUE)
data1_item

# Tampilkan tiga item paling sering muncul
data1_item[1:3]

# Konversi ke transaksi
trans <- as(data_trans1, "transactions")

# Gunakan nilai support yang lebih rendah agar hasil tidak NULL
freq1 <- apriori(data_trans1, parameter=list(support=0.5, target="frequent itemsets"))

inspect(freq1)

aturan <- apriori(data_trans1)
inspect(aturan)

#Plotting Frequent Item
freq <- itemFrequencyPlot(data_trans1)
freq

# inspect(subset(aturan,rhs %in% "E"))

rule <- apriori(data_trans1,parameter = list(supp=0.6 , confidence=0.8))
inspect(rule)

scatterPlot <- plot(aturan,method = "scatterplot")
scatterPlot

groupedPlot <- plot(aturan,method = "grouped")
groupedPlot