install.packages("arules")
install.packages("arulesViz")
library(arules)
library(arulesViz)


# MEMASUKKAN DATA TRANSAKSI
data <- list(
  c("M", "O", "N", "K", "E", "Y"),    # T100
  c("D", "O", "N", "K", "E", "Y"),    # T200
  c("M", "A", "K", "E"),              # T300
  c("M", "U", "C", "K", "Y"),         # T400
  c("C", "O", "O", "K", "I", "E")     # T500
)

trans <- as(data, "transactions")
inspect(trans)

# MENAMBANG ATURAN DENGAN FP-GROWTH
rules <- apriori(
  trans,
  parameter = list(
    supp = 0.6,     # support ≥ 60%
    conf = 0.8,     # confidence ≥ 80%
    target = "rules"
  )
)

# CETAK ATURAN YANG DITEMUKAN
inspect(sort(rules, by = "lift"))

# PLOTTING VISUALISASI

# a. Default scatter plot
plot(rules)

# b. Grouped matrix (cocok untuk >10 aturan)
plot(rules, method = "grouped")

# c. Graph-based (jaringan antar item)
plot(rules, method = "graph", control = list(type = "items"))

# d. Matrix support vs lift
plot(rules, method = "matrix", measure = c("support", "lift"))

# MENYIMPAN PLOT KE PNG
png("grafik_asosiasi_fp_growth.png", width = 800, height = 600)
plot(rules, method = "graph", control = list(type = "items"))
dev.off()
