
germ_reactive = function(x){
  
  x %>%
    group_by(TRAT, RUN) %>%
    filter(DAP %in% c(360)) %>%
    distinct(TRAT, RUN)
}

germ_success_reactive = function(x, y){
  
  x %>%
    right_join(y, by = c("TRAT", "RUN")) %>%
    filter(DAP == 0) %>%
    select(DATE) %>%
    mutate(month = lubridate::month(DATE, label = T),
           day = lubridate::day(DATE)) %>%
    group_by(month) %>%
    summarise(success = n(),
              success_perc = success / 62)
  
}

germ_fails_reactive = function(x, y){
  
  x %>%
    anti_join(y, by = c("TRAT", "RUN")) %>%
    filter(DAP == 0) %>%
    select(DATE) %>%
    mutate(month = lubridate::month(DATE, label = T),
           day = lubridate::day(DATE)) %>%
    group_by(month) %>%
    summarise(fails = n(),
              fails_perc = fails / 62)
  
}

germ_success_abs = function(x){
  
  color = RColorBrewer::brewer.pal(name = "Set1", n = 1)
  
  x %>%
    ggplot(aes(month, success)) +
    geom_col(fill = color[2], color = "black") +
    labs(y = "Germination Success",
         x = "Planting Month") +
    theme_bw()

}

germ_success_perc = function(x){
  
  color = RColorBrewer::brewer.pal(name = "Set1", n = 1)
  
  x %>%
    ggplot(aes(month, success_perc)) +
    geom_col(fill = color[2], color = "black") +
    labs(y = "Germination Success frequency",
         x = "Planting Month") +
    scale_y_continuous(labels = scales::label_percent()) +
    theme_bw() 
  
}

germ_fails_abs = function(x){
  
  color = RColorBrewer::brewer.pal(name = "Set1", 
                                   n = 1)
  
  x %>%
    ggplot(aes(month, fails)) +
    geom_col(fill = color[1], color = "black") +
    labs(y = "Germination fails",
         x = "Planting Month") +
    theme_bw()
  
}

germ_fails_perc = function(x){
  
  color = RColorBrewer::brewer.pal(name = "Set1", 
                                   n = 1)
  
  x %>%
    ggplot(aes(month, fails_perc)) +
    geom_col(fill = color[1], color = "black") +
    labs(y = "Germination fails",
         x = "Planting Month") +
    scale_y_continuous(labels = scales::label_percent()) +
    theme_bw()
  
}