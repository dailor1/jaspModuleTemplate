VariabilityChart <- function(jaspResults, dataset, options) {

  # 1. Verifica se o usuario ja inseriu a variavel Y e pelo menos um fator
  ready <- options$yVariable != "" && length(options$factors) > 0
  if (!ready) return()

  yVar <- options$yVariable
  xVars <- unlist(options$factors)

  # 2. Leitura dos dados a partir da interface do JASP
  if (is.null(dataset)) {
    dataset <- .readDataSetToEnd(columns.as.numeric = yVar, columns.as.factor = xVars)
  }

  # 3. Prepara o container do grafico na aba de resultados
  if (is.null(jaspResults[["varChart"]])) {
    plot <- createJaspPlot(title = "Variability Chart (ccOpex)", width = 700, height = 450)
    plot$dependOn(c("yVariable", "factors"))
    jaspResults[["varChart"]] <- plot

    # Chama a funcao interna que desenha o grafico
    p <- .generateVariabilityPlot(dataset, yVar, xVars)
    plot$plotObject <- p
  }
}

.generateVariabilityPlot <- function(dataset, yVar, xVars) {
  # Carrega os pacotes necessarios para a logica ccOpex
  library(ggplot2)
  library(ggh4x)
  library(dplyr)
  library(rlang)

  # Calcula a media dos subgrupos para a linha de referencia
  dataset_summary <- dataset %>%
    group_by(across(all_of(xVars))) %>%
    mutate(Mean = mean(!!sym(yVar), na.rm = TRUE)) %>%
    ungroup()

  # Cria a formula dinamica para os eixos aninhados
  facet_formula <- as.formula(paste("~", paste(xVars, collapse = " + ")))

  # Constroi o grafico estilo Minitab
  p <- ggplot(dataset_summary, aes(x = 1, y = !!sym(yVar))) +
    geom_jitter(width = 0.15, alpha = 0.6, color = "#005EB8") + 
    geom_segment(aes(x = 0.5, xend = 1.5, y = Mean, yend = Mean), color = "black", linewidth = 1) +
    facet_nested(facet_formula, switch = "x", scales = "free_x") +
    theme_bw() +
    theme(
      strip.placement = "outside",
      strip.background = element_rect(fill = "#f8f9fa", color = "black"),
      axis.text.x = element_blank(),
      axis.ticks.x = element_blank(),
      panel.spacing = unit(0, "lines"),
      panel.grid.major.x = element_blank()
    ) +
    labs(x = "Subgroups", y = yVar)

  return(p)
}
