library(arules)

transactions <- list(
  c("A", "C", "D"),  # T100
  c("B", "C", "E"),  # T200
  c("A", "B", "C", "E"),            # T300 (Diperbaiki)
  c("B", "E")      # T400
)
trans <- as(transactions, "transactions")
inspect(trans)

trans

freq1 <- eclat(trans, parameter = list(support = 0.5, target = "frequent itemsets"))
inspect(freq1)

freq2 <- eclat(trans)
freq2

inspect(freq2)

rules <- ruleInduction(freq1, confidence = .8)
rules

inspect(sort(rules, by = 'lift'))