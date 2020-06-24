

# Specifications
dry_to_fresh_matter_factor = 0.4
sell_price_ton = 200

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
  mutate(yield_FW = HWAD / dry_to_fresh_matter_factor,
         yield_FW_ton = yield_FW / 1000,
         receita_ha = yield_FW_ton * sell_price_ton,
         custo_basico = sum(basic_costs) * (1 + other_costs_percent),
         custo_irrig = IRRC * 100,
         custo_ha = custo_basico + custo_irrig,
         margem_bruta = receita_ha - custo_ha,
         resultado = map_int(margem_bruta, 
                             function(x) return(x > 1)))
  
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