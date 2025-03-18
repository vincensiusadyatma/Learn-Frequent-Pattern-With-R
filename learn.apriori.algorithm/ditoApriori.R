# Memuat pustaka yang diperlukan
library(arules)      # Pustaka untuk algoritma Apriori
library(arulesViz)   # Pustaka untuk visualisasi aturan asosiasi
library(ggplot2)     # Pustaka untuk visualisasi data
library(magrittr)    # Pustaka untuk operator piping (%>%)
library(igraph)      # Pustaka untuk graf
library(ggraph)      # Pustaka untuk visualisasi graf dengan ggplot2

# Memeriksa direktori kerja saat ini
getwd()

# Membaca data transaksi dari file CSV
data_trans1 <- read.transactions(
  file = 'E:/MATERI KULIAH SADHAR/Semester 6/Data Mining/Belajar Visualisasi Data R/Learn-Frequent-Pattern-With-R/learn.apriori.algorithm/dataset/items.csv',
  sep = ","
)

# Memeriksa transaksi yang telah dimuat
inspect(data_trans1)

# Menampilkan daftar item yang ada dalam transaksi
data_trans1@itemInfo

# Menampilkan data transaksi
data_trans1@data

# Menampilkan frekuensi item dalam transaksi (dalam bentuk absolut)
itemFrequency(data_trans1, type="absolute")

# Menyimpan dan mengurutkan frekuensi item dalam urutan menurun berdasarkan frekuensi absolut
data1_item <- sort(itemFrequency(data_trans1, type="absolute"), decreasing = TRUE)
data1_item

# Menampilkan tiga item yang paling sering muncul
data1_item[1:3]

# Mengonversi transaksi ke format transaksi
trans <- as(data_trans1, "transactions")

# Menggunakan nilai support yang lebih rendah agar hasil tidak NULL
freq1 <- apriori(data_trans1, parameter=list(support=0.5, target="frequent itemsets"))
inspect(freq1)

# Menampilkan aturan yang ditemukan
aturan <- apriori(data_trans1)
inspect(aturan)

# Menampilkan item yang sering muncul
freq <- itemFrequencyPlot(data_trans1)
freq

# Menggunakan aturan yang berisi item 'E' pada sisi kanan (rhs)
# inspect(subset(aturan,rhs %in% "E"))

# Menyaring aturan dengan nilai support dan confidence tertentu
rule <- apriori(data_trans1, parameter = list(supp=0.6, confidence=0.8))
inspect(rule)

# Visualisasi aturan asosiasi dengan metode scatter plot
scatterPlot <- plot(aturan, method = "scatterplot")
scatterPlot

# Visualisasi aturan asosiasi dengan metode grouped
groupedPlot <- plot(aturan, method = "grouped")
groupedPlot

# Visualisasi aturan asosiasi dengan metode graph menggunakan engine igraph
graphs <- plot(aturan, method="graph", engine = "igraph", control=list(layout=igraph::with_fr()))
graphs

