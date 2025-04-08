
install.packages("arules")
install.packages("arulesViz")
install.packages("htmlwidgets")
install.packages("igraph")
install.packages("visNetwork")
library(arules)
library(arulesViz)
library(htmlwidgets)

data <- read.csv('D:/Projects/r_apriori/Learn-Frequent-Pattern-With-R/uts/budidaya_bandeng_2.csv',sep=",")
trans <- as(data, "transactions")

summary(trans)

rules <- apriori(
  trans,
  parameter = list(
    supp = 0.3,
    conf = 0.7,
    target = "rules"
  )
)


inspect(sort(rules, by = "lift"))


plot_fp <- plot(rules, method = "graph", engine = "htmlwidget")
htmlwidgets::saveWidget(plot_fp, file = "fp_growth_rules.html", selfcontained = TRUE)