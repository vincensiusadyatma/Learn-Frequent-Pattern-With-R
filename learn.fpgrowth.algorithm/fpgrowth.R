
install.packages("arules")
install.packages("arulesViz")
install.packages("htmlwidgets")
install.packages("igraph")
install.packages("visNetwork")

#Load library
library(arules)
library(arulesViz)
library(htmlwidgets)

# Data transaksi
data <- list(
  c("M", "O", "N", "K", "E", "Y"),    # T100
  c("D", "O", "N", "K", "E", "Y"),    # T200
  c("M", "A", "K", "E"),              # T300
  c("M", "U", "C", "K", "Y"),         # T400
  c("C", "O", "K", "I", "E")          # T500
)

trans <- as(data, "transactions")


# Menambang aturan dengan FP-Growth
rules <- apriori(
  trans,
  parameter = list(
    supp = 0.6,      # minsup 60%
    conf = 0.8,      # minconf 80%
    target = "rules"
  )
)

# 📄 Tampilkan aturan di console--
inspect(sort(rules, by = "lift"))

# 🌐 Buat visualisasi interaktif dan simpan ke HTML
# Gunakan engine = "htmlwidget" agar bisa disimpan sebagai HTML
plot_fp <- plot(rules, method = "graph", engine = "htmlwidget")
# Simpan ke file HTML
htmlwidgets::saveWidget(plot_fp, file = "fp_growth_rules.html", selfcontained = TRUE)

