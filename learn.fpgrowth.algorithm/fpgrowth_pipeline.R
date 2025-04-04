# ================================
# 1. INSTALL & LOAD PACKAGES
# ================================
install.packages(c("arules", "arulesViz", "visNetwork", "plotly", "htmlwidgets", "webshot2"))
library(arules)
library(arulesViz)
library(visNetwork)
library(plotly)
library(htmlwidgets)
library(webshot2)

# ================================
# 2. DATA TRANSAKSI
# ================================
data <- list(
  c("M", "O", "N", "K", "E", "Y"),
  c("D", "O", "N", "K", "E", "Y"),
  c("M", "A", "K", "E"),
  c("M", "U", "C", "K", "Y"),
  c("C", "O", "O", "K", "I", "E")
)
trans <- as(data, "transactions")

# ================================
# 3. FP-GROWTH (Apriori)
# ================================
rules <- apriori(trans, parameter = list(supp = 0.6, conf = 0.8, target = "rules"))
inspect(sort(rules, by = "lift")[1:10])

# ================================
# 4. VISUALISASI SCATTERPLOT
# ================================
png("rules_scatter.png", width = 800, height = 600)
plot(rules, method = "scatterplot", measure = c("support", "confidence"), shading = "lift")
dev.off()

# ================================
# 5. VISUALISASI 3D PLOTLY
# ================================
df_plot <- data.frame(
  support = quality(rules)$support,
  confidence = quality(rules)$confidence,
  lift = quality(rules)$lift,
  label = labels(rules)
)

plot3d <- plot_ly(
  data = df_plot,
  x = ~support,
  y = ~confidence,
  z = ~lift,
  type = 'scatter3d',
  mode = 'markers',
  marker = list(size = 5, color = ~lift, colorscale = "Viridis"),
  text = ~label
) %>% layout(
  title = "3D Scatter Plot of Association Rules",
  scene = list(
    xaxis = list(title = "Support"),
    yaxis = list(title = "Confidence"),
    zaxis = list(title = "Lift")
  )
)

Sys.setenv(RSTUDIO_PANDOC = "C:/Users/LENOVO/Documents/pandoc-3.6.4")
saveWidget(plot3d, "rules_plotly.html", selfcontained = TRUE)

# ================================
# 6. VISNETWORK INTERAKTIF (FIXED)
# ================================
if (length(rules) > 0) {
  full_df <- as(rules, "data.frame")
  full_df$lhs <- as.character(full_df$lhs)
  full_df$rhs <- as.character(full_df$rhs)
  rule_df <- subset(full_df, lhs != "{}" & rhs != "{}")[1:min(10, nrow(full_df)), ]

  lhs_items <- unique(unlist(strsplit(gsub("[{}]", "", rule_df$lhs), ",")))
  rhs_items <- unique(unlist(strsplit(gsub("[{}]", "", rule_df$rhs), ",")))
  lhs_items <- trimws(lhs_items[!is.na(lhs_items) & lhs_items != ""])
  rhs_items <- trimws(rhs_items[!is.na(rhs_items) & rhs_items != ""])
  all_items <- unique(c(lhs_items, rhs_items))

  if (length(all_items) > 0) {
    nodes <- data.frame(
      id = all_items,
      label = all_items,
      group = ifelse(all_items %in% lhs_items & all_items %in% rhs_items, "both",
                     ifelse(all_items %in% lhs_items, "lhs", "rhs")),
      font = list(size = 20, color = "black"),
      shape = "dot",
      size = 30,
      stringsAsFactors = FALSE
    )

    edges <- data.frame()
    for (i in 1:nrow(rule_df)) {
      lhs <- unlist(strsplit(gsub("[{}]", "", rule_df$lhs[i]), ","))
      rhs <- unlist(strsplit(gsub("[{}]", "", rule_df$rhs[i]), ","))
      for (l in lhs) {
        for (r in rhs) {
          if (trimws(l) != "" && trimws(r) != "") {
            edges <- rbind(edges, data.frame(from = trimws(l), to = trimws(r)))
          }
        }
      }
    }

    network_plot <- visNetwork(nodes, edges, height = "600px", width = "100%") %>%
      visEdges(arrows = "to", color = list(color = "#999999")) %>%
      visOptions(highlightNearest = TRUE, nodesIdSelection = TRUE) %>%
      visGroups(groupname = "lhs", color = "#80dfff", shape = "box") %>%
      visGroups(groupname = "rhs", color = "#baffc9", shape = "ellipse") %>%
      visGroups(groupname = "both", color = "#fcd5ce", shape = "diamond") %>%
      visLegend(position = "right", main = "Item Class") %>%
      visLayout(randomSeed = 123)

    saveWidget(network_plot, "visnetwork_plot.html", selfcontained = TRUE)
    webshot("visnetwork_plot.html", "visnetwork_plot.png", vwidth = 1000, vheight = 700, delay = 3)

  } else {
    message("❌ Tidak ada item yang valid untuk divisualisasikan.")
  }
} else {
  message("❌ Tidak ditemukan aturan asosiasi yang memenuhi threshold.")
}

# ================================
# DONE 🎉 Semua visualisasi selesai
# ================================
