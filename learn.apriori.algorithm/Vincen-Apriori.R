# Memuat library yang diperlukan
library(arules)       # Paket untuk analisis aturan asosiasi (Apriori)
library(arulesViz)    # Paket untuk visualisasi aturan asosiasi
library(magrittr)     # Paket untuk operator pipe (%>%)

# Set working directory (
setwd("E:/MATERI KULIAH SADHAR/Semester 6/Data Mining/Belajar Visualisasi Data R/Learn-Frequent-Pattern-With-R/learn.apriori.algorithm")

# Membaca data transaksi pertama (data_ar1.txt) dengan format 'single'
data_trans1 <- read.transactions(file="dataset/data_ar1.txt", format="single", header=FALSE, sep="", cols=c(1,2), skip=1)

# Menampilkan data transaksi pertama
inspect(data_trans1)

# Membaca data transaksi kedua (data_ar2.txt) dengan format 'basket'
data_trans2 <- read.transactions(file="dataset/data_ar2.txt", format="basket", header=FALSE, sep=",")
inspect(data_trans2)

# Menampilkan daftar item yang ada pada transaksi pertama
data_trans1@itemInfo

# Menampilkan daftar kode transaksi dari transaksi pertama
data_trans1@itemsetInfo

# Menampilkan data transaksi pertama dalam bentuk matrix
data_trans1@data

# Membaca dataset dalam format CSV (untuk keperluan lain)
data_ar1 <- read.csv(file="dataset/data_ar1.csv", sep="")
data_ar1

# Menampilkan frekuensi item (support) pada transaksi pertama
itemFrequency(data_trans1)

# Menampilkan nilai absolut dari frekuensi item
itemFrequency(data_trans1, type="absolute")

# Menyimpan frekuensi item dalam variabel dan mengurutkan dari jumlah terbesar ke terkecil
data1_item <- itemFrequency(data_trans1, type="absolute")
data1_item <- sort(data1_item, decreasing = TRUE)
data1_item

# Menampilkan 3 item terbanyak
data1_item <- data1_item[1:3]
data1_item

# Mengkonversi hasil ke dalam bentuk data frame dengan kolom Nama Produk dan Jumlah
data2_item <- data.frame("Produk" = names(data1_item), "Jumlah" = data1_item, row.names = NULL)
data2_item

# Menyimpan hasil item terbanyak ke dalam file "top3_item.txt"
write.csv(data2_item, file="top3_item.txt", eol = "\r\n")

# Menampilkan grafik item frequency
itemFrequencyPlot(data_trans1)

# Menampilkan itemsets dengan support >= 0.5
freq1 <- inspect(apriori(data_trans1, parameter=list(support=0.5, target="frequent itemsets")))

# Menggunakan algoritma apriori untuk menghasilkan aturan asosiasi
aturan <- apriori(data_trans1)

# Menampilkan hasil aturan asosiasi
inspect(aturan)

# Menyaring aturan yang memiliki item "E" di RHS
inspect(subset(aturan, rhs %in% "E"))

# Menyaring aturan yang memiliki item "A" di LHS
inspect(subset(aturan, lhs %in% "A"))

# Menyaring aturan yang memiliki item "A" di LHS dan item "E" di RHS
inspect(subset(aturan, lhs %in% "A" & rhs %in% 'E'))

# Menentukan aturan asosiasi dengan parameter support dan confidence
rule <- apriori(data_trans1, parameter=list(supp=0.5, confidence=0.8))

# Menampilkan aturan yang dihasilkan
inspect(rule)

# Menyaring aturan yang memiliki "E" di LHS atau RHS dan lift > 1
inspect(subset(aturan, (lhs %in% "E" | rhs %in% "E") & lift > 1))

# Menampilkan aturan yang memiliki item "A" dan "E" di LHS menggunakan %ain% untuk logika AND
inspect(subset(aturan, (lhs %ain% c("A", "E"))))

# Menyaring aturan yang memiliki item "A" dan "E" di LHS menggunakan logika AND
inspect(subset(aturan, (lhs %in% "A" & lhs %in% "E")))

# Plot aturan asosiasi dengan metode 'graph' menggunakan igraph
plot(aturan, method="graph", engine="igraph", shading="lift", control=list(alpha=1))

# Menggunakan scatterplot untuk visualisasi
plot(aturan, method="scatterplot")  # To reduce overplotting, jitter is added! Use jitter = 0 to prevent jitter.

# Menggunakan grouped plot untuk visualisasi
plot(aturan, method="grouped")


