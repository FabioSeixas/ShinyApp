

# Specifications
dry_to_fresh_matter_factor = 0.4

priceTable = read_csv("precos_final.csv")
ton_sell_price = function(PDate, dap, table) {
  
  priceTable %>%
    filter(mes == month(PDate + dap)) %>%
    pull(mediana) * 1000
}

basic_costs = c("Manivas" = 137,
                "Ureia" = 115,
                "Superfosfato" = 475,
                "Cloreto Potássio" = 115,
                "Formicida" = 22,
                "Aração" = 171,
                "Gradagem" = 86,
                "Sulcamento" = 115,
                "Aplicação Fertilizantes" = 200,
                "Transporte Manivas" = 100,
                "Seleção e preparo manivas" = 150,
                "Plantio" = 150,
                "Capinas (4)" = 2400,
                "Aplicação formicida" = 150,
                "Colheita" = 1250)

other_costs_percent = 0.2

irrig_fix_fun = function(lamina){
  if(lamina > 0){
    return(670)
  }
  else return(0)
}

irrig_invest_fun = function(lamina){
  if(lamina > 0){
    return(7446)
  }
  else return(0)
}

irrig_variaveis = function(lamina){
  if(lamina > 0){
    
    lamina = lamina / 0.8
    variaveis = c("bombeamento" = lamina * 2.28,
                  "água" = lamina * 1,
                  "irrigante" = lamina * 2) %>%
      sum()
    
    return(variaveis + (variaveis * 0.5 + 75))
  }
  else return(0)
}

economic_columns = function(x) {
  
  x %>%
  ungroup() %>%
  filter(DAP %in% c(240, 270, 300, 330, 360)) %>% 
  mutate(PMonth = lubridate::month(PDate_norm,
                                   label = T),
         yield_FW = HWAD / dry_to_fresh_matter_factor,
         yield_FW_ton = yield_FW / 1000,
         sell_price = map2_dbl(PDate_norm, DAP, 
                               ~ton_sell_price(.x, .y, priceTable)),
         receita_ha = yield_FW_ton * sell_price,
         custo_basico = sum(basic_costs) * (1 + other_costs_percent),
         custo_irrig_invest = map_dbl(IRRC, irrig_invest_fun),
         custo_irrig_fixo = map_dbl(IRRC, irrig_fix_fun),
         custo_irrig_var = map_dbl(IRRC, irrig_variaveis),
         custo_ha = custo_basico + custo_irrig_fixo + custo_irrig_var,
         yield_thr = custo_ha / sell_price, 
         yield_above = yield_FW_ton / yield_thr,
         margem_bruta = receita_ha - custo_ha,
         relacao = receita_ha / custo_ha,
         resultado = map_int(margem_bruta, 
                             function(x) return(x >= 1)))
  
}


water_applied_plot = function(x) {
  
  x %>%
    filter(DAP == 360) %>%
    ggplot(aes(PDate_norm, IRRC, group = PDate_norm)) +
    geom_boxplot(outlier.shape = NA) +
    scale_y_continuous(labels = scales::comma) +
    scale_x_date(labels = function(x) month(x, label = T),
                 date_breaks = "1 month",
                 name = "Planting Date") +
    labs(title = "Water Applied by Planting Date",
         y = "Total Water Depth (mm)",
         x = "Planting Date") +
    theme_bw() +
    theme(plot.title = element_text(hjust = 0.5, size = 15, face = "bold"))
  
}

water_efic_plot = function(x) {
  
  x %>%
    ggplot(aes(PDate_norm, (yield_FW_ton / IRRC),
               group = PDate_norm)) +
    geom_boxplot() +
    facet_wrap(~DAP, ncol = 1,
               labeller = labeller(DAP = c("240" = "8 Months",
                                           "270" = "9 Months",
                                           "300" = "10 Months",
                                           "330" = "11 Months",
                                           "360" = "12 Months"))) +
    scale_y_continuous(labels = scales::comma) +
    scale_x_date(labels = function(x) month(x, label = T),
                 date_breaks = "1 month",
                 name = "Planting Date") +
    labs(title = "Water Efficiency by Cycle Length",
         y = "Water Efficiency (ton/mm)",
         x = "Planting Date") +
    theme_bw() +
    theme(plot.title = element_text(hjust = 0.5, size = 15, face = "bold"))
  
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
    scale_x_date(labels = function(x) month(x, label = T),
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
    scale_x_date(labels = function(x) month(x, label = T),
                 date_breaks = "1 month",
                 name = "Planting Date") +
    labs(title = "Margin-Costs relation by cicle length",
         y = "Margin-Costs relation",
         x = "Planting Date") +
    geom_hline(yintercept = 1, linetype = "dashed", alpha = 0.4) +
    theme_bw() +
    theme(plot.title = element_text(hjust = 0.5, size = 15, face = "bold"))
  
}


econ_costs_plot = function(x) {
  
  x %>%
    select(starts_with("custo")) %>%
    summarise("Operational" = mean(custo_basico),
              "Investiment (First Year)" = mean(custo_irrig_invest),
              "Irrigation Fixed Costs" = mean(custo_irrig_fixo),
              "Irrigation Variable Costs" = mean(custo_irrig_var)) %>%
    pivot_longer(cols = everything()) %>%
    ggplot(aes(value, 
               reorder(as.factor(name), -value))) +
    geom_bar(stat = "identity",
             orientation = "y",
             color = "black",
             fill = "green3",
             alpha = 0.5) +
    labs(y = "Cost Component") +
    scale_x_continuous(name = "Value (R$/ha)",
                       labels = scales::comma) +
    theme_bw()
}

econ_results_plot = function(x) {
  
  x %>%
    ggplot(aes(yield_FW_ton, 
               group = as.factor(resultado), 
               fill = as.factor(resultado))) +
    geom_histogram(size = 0.7, alpha = 0.5) +
    scale_fill_manual(name='Financial Result', 
                      values=c("1" = "green3", "0" = "red3"),
                      labels = c("Negative", "Positive")) +
    scale_x_continuous(name = "Yield (ton/ha)") +
    labs(subtitle = "First year not included") +
    theme_bw() +
    theme(axis.text.y = element_blank(),
          axis.title.y = element_blank(),
          axis.ticks.y = element_blank())
}


security_plot = function(x) {
  
  x %>%
    mutate(yield_above = map_dbl(yield_above, ~ifelse(.x > 1,
                                                      .x - 1,
                                                      0))) %>%
    group_by(PDate_norm, DAP) %>%
    summarise(yield_above = mean(yield_above)) %>%
    ggplot(aes(PDate_norm, yield_above)) +
    geom_line() +
    facet_wrap(~DAP, ncol = 1,
               labeller = labeller(DAP = c("240" = "8 Months",
                                           "270" = "9 Months",
                                           "300" = "10 Months",
                                           "330" = "11 Months",
                                           "360" = "12 Months"))) +
    scale_x_date(labels = function(x) month(x, label = T),
                 date_breaks = "1 month",
                 name = "Planting Date") +
    scale_y_continuous(name = "Security Margin",
                       labels = scales::percent,
                       breaks = seq(0, 1, 0.2)) +
    labs(title = "Security Margin for Positive Financial Results") +
    theme_bw() +
    theme(plot.title = element_text(hjust = 0.5, size = 15, face = "bold"))
  
}
