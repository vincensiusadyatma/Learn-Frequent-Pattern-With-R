
install.packages("arules")
install.packages("arulesViz")
install.packages("htmlwidgets")
install.packages("igraph")
install.packages("visNetwork")

# Load Library
library(arules)
library(arulesViz)
library(htmlwidgets)

# Data transaksi
transactions <- list(
  c("M", "O", "N", "K", "E", "Y"),  # T100
  c("D", "O", "N", "K", "E", "Y"),  # T200
  c("M", "A", "K", "E"),            # T300
  c("M", "U", "C", "K", "Y"),       # T400
  c("C", "O", "K", "I", "E")        # T500
)

trans <- as(transactions, "transactions")

#  ECLAT frequent itemsets
freq_items <- eclat(trans, parameter = list(support = 0.5, maxlen = 10))
inspect(freq_items)

# Bangun aturan asosiasi dari itemsets
rules <- ruleInduction(freq_items, trans, confidence = 0.8)
inspect(sort(rules, by = "lift"))

#  Buat visualisasi interaktif dan simpan ke HTML
plot_obj <- plot(rules, method = "graph", engine = "htmlwidget")
htmlwidgets::saveWidget(plot_obj, file = "eclat_rules.html", selfcontained = TRUE)
