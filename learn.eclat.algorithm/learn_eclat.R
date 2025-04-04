library(arules)

transactions <- list(
  c("M", "O", "N", "K", "E", "Y"),  # T100
  c("D", "O", "N", "K", "E", "Y"),  # T200
  c("M", "A", "K", "E"),            # T300 (Diperbaiki)
  c("M", "U", "C", "K", "Y"),       # T400
  c("C", "O", "K", "I", "E")        # T500
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