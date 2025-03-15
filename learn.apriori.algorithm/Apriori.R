
install.packages("arules")
library(arules)

transactions <- list(
  c("M", "O", "N", "K", "E", "Y"),
  c("D", "O", "N", "K", "E", "Y"),
  c("M", "O", "N", "K", "E"),
  c("M", "U", "C", "K", "Y"),
  c("C", "O", "O", "K", "I", "E")
)

trans <- as(transactions, "transactions")

rules <- apriori(trans, parameter = list(supp = 0.6, conf = 0.8, target = "rules"))

inspect(apriori(trans, parameter = list(supp = 0.6, target = "frequent itemsets")))

inspect(rules)

rules_sorted <- sort(rules, by = "lift", decreasing = TRUE)
inspect(rules_sorted)
