
#install.packages("arules")
library(arules)

transactions <- list(
  c("M", "O", "N", "K", "E", "Y"),  # T100
  c("D", "O", "N", "K", "E", "Y"),  # T200
  c("M", "A", "K", "E"),            # T300 (Diperbaiki)
  c("M", "U", "C", "K", "Y"),       # T400
  c("C", "O", "K", "I", "E")        # T500
)

trans <- as(transactions, "transactions")

rules <- apriori(trans, parameter = list(supp = 0.6, conf = 0.8, target = "rules"))

inspect(apriori(trans, parameter = list(supp = 0.6, target = "frequent itemsets")))

inspect(rules)

rules_sorted <- sort(rules, by = "lift", decreasing = TRUE)
inspect(rules_sorted)
