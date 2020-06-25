

# Specifications
dry_to_fresh_matter_factor = 0.4
ton_sell_price = 200

basic_costs = c("Manivas" = 137,
                "Ureia" = 115,
                "Superfosfato" = 475,
                "Cloreto Potássio" = 115,
                "Formicida" = 22,
                "Aração" = 171,
                "Gradagem" = 86,
                "Sulcamento" = 115,
                "Aplicação Fertilizantes" = 92,
                "Transporte Manivas" = 46,
                "Seleção e preparo manivas" = 69,
                "Plantio" = 69,
                "Capinas (4)" = 1096,
                "Aplicação formicida" = 69,
                "Colheita" = 571)

other_costs_percent = 0.12


economic_columns = function(x) {
  
  x %>%
  ungroup() %>%
  filter(DAP %in% c(240, 270, 300, 330, 360)) %>% 
  mutate(PMonth = lubridate::month(PDate_norm,
                                   label = T),
         yield_FW = HWAD / dry_to_fresh_matter_factor,
         yield_FW_ton = yield_FW / 1000,
         receita_ha = yield_FW_ton * ton_sell_price,
         custo_basico = sum(basic_costs) * (1 + other_costs_percent),
         custo_irrig = IRRC * 100,
         custo_ha = custo_basico + custo_irrig,
         custo_ton = custo_ha / yield_FW_ton,
         margem_bruta = receita_ha - custo_ha,
         relacao = receita_ha / custo_ha,
         resultado = map_int(margem_bruta, 
                             function(x) return(x >= 1)))
  
}


security_columns = function(x, threshold) {
  
  x %>%
    mutate(acima_seguranca = yield_FW_ton - threshold,
           margem_seguranca = map2_dbl(acima_seguranca, yield_FW_ton,
                                       function(.x, .y){
                                         if(.x >= 0){
                                           return((.x / .y))
                                         }
                                         return(0)
                                       }))
}


security_percent_above = function(x, threshold) {
  
  (sum(x$margem_seguranca >= threshold) / sum(x$resultado > 0)) * 100 -> value
  
  return(sym(paste(round(value, 2), "%")))
  
}

gross_margin_plot = function(x) {
  
  x %>%
    ggplot(aes(PDate_norm, margem_bruta, group = PDate_norm)) +
    geom_boxplot(outlier.shape = NA) +
    facet_wrap(~DAP, ncol = 1,
               labeller = labeller(DAP = c("240" = "8 Months",
                                           "270" = "9 Months",
                                           "300" = "10 Months",
                                           "330" = "11 Months",
                                           "360" = "12 Months"))) +
    scale_y_continuous(labels = scales::comma) +
    scale_x_date(labels = function(x) month(x, label = T, 
                                            locale = "US"),
                 date_breaks = "1 month",
                 name = "Planting Date") +
    labs(title = "Gross Margin by cicle length",
         y = "Gross Margin",
         x = "Planting Date") +
    geom_hline(yintercept = 0, linetype = "dashed", alpha = 0.4) +
    theme_bw() +
    theme(plot.title = element_text(hjust = 0.5, size = 15, face = "bold"))
  
}


margin_costs_rel_plot = function(x) {
  
  x %>%
    ggplot(aes(PDate_norm, relacao, group = PDate_norm)) +
    geom_boxplot(outlier.shape = NA) +
    facet_wrap(~DAP, ncol = 1,
               labeller = labeller(DAP = c("240" = "8 Months",
                                           "270" = "9 Months",
                                           "300" = "10 Months",
                                           "330" = "11 Months",
                                           "360" = "12 Months"))) +
    scale_x_date(labels = function(x) month(x, label = T, 
                                            locale = "US"),
                 date_breaks = "1 month",
                 name = "Planting Date") +
    labs(title = "Margin-Costs relation by cicle length",
         y = "Margin-Costs relation",
         x = "Planting Date") +
    geom_hline(yintercept = 1, linetype = "dashed", alpha = 0.4) +
    theme_bw() +
    theme(plot.title = element_text(hjust = 0.5, size = 15, face = "bold"))
  
}


econ_results_plot = function(x) {
  
  x %>%
    ggplot(aes(yield_FW_ton, 
               group = as.factor(resultado), 
               fill = as.factor(resultado))) +
    geom_density(size = 0.7, alpha = 0.5) +
    scale_fill_manual(name='Financial Result', 
                      values=c("1" = "green3", "0" = "red3"),
                      labels = c("Negative", "Positive")) +
    scale_x_continuous(name = "Yield (ton/ha)") +
    theme_bw() +
    theme(axis.text.y = element_blank(),
          axis.title.y = element_blank(),
          axis.ticks.y = element_blank())
}


econ_security_plot = function(x) {
  
  x %>%
    ggplot(aes(margem_seguranca)) +
    geom_density(alpha = 0.3, size = 0.8, fill = "green3", color = "black") +
    scale_x_continuous(name = "Security Margin",
                       labels = scales::percent,
                       breaks = seq(0, 0.6, 0.1)) +
    labs(title = "Security Margin for Positive Financial Results") +
    theme_bw() +
    theme(axis.text.y = element_blank(),
          axis.title.y = element_blank(),
          axis.ticks.y = element_blank(),
          plot.title = element_text(hjust = 0.5, size = 15, face = "bold"))
  
}