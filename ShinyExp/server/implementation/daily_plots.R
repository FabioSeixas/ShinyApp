var_plot = function(x, var, title_axis) {
  
  x %>%
    ggplot(aes_string("DATE", var)) +
    geom_line(aes(color = PMonth)) +
    facet_wrap(~Pyear, ncol = 2,
               scales = "free_x") +
    scale_x_date(labels = function(x) month(x, label = T, 
                                            locale = "US"),
                 date_breaks = "2 month",
                 name = "Date") +
    scale_y_continuous(name = title_axis,
                       labels = scales::comma,
                       breaks = seq(0, 30500, by = 2000)) +
    scale_color_manual(values = RColorBrewer::brewer.pal(name = "Set1", 
                                                         n = 8),
                       name = "Planting Month") +
    theme_bw() +
    theme(axis.title.y = element_text(size = 11, vjust = 3),
          axis.title.y.right = element_text(size = 11, 
                                            vjust = -2,
                                            angle = 90),
          axis.title.x = element_text(size = 11, vjust = -3),
          axis.text = element_text(size = 11),
          legend.text = element_text(size = 11),
          legend.position = "bottom",
          legend.title.align = 0.5,
          legend.title = element_text(face = "bold", size = 11),
          strip.text = element_text(size = 11))
  
}


var_water_plot = function(x, var, title_axis) {
  
  x %>% 
    ggplot(aes_string("DATE", var)) +
    geom_line(aes(color = PMonth)) +
    geom_line(aes(DATE, soil_water * 50, group = PMonth), 
              color = "blue", alpha = 0.2) +
    facet_wrap(~Pyear, ncol = 2,
               scales = "free_x") +
    scale_x_date(labels = function(x) month(x, label = T, 
                                            locale = "US"),
                 date_breaks = "2 month",
                 name = "Date") +
    scale_y_continuous(name = title_axis,
                       labels = scales::comma,
                       breaks = seq(0, 30500, by = 2000),
                       sec.axis = sec_axis(~. / 50,
                                           name = expression(Soil~Extractable~Water~(mm)),
                                           breaks = seq(0, 1000, by = 50))) +
    scale_color_manual(values = RColorBrewer::brewer.pal(name = "Set1", 
                                                         n = 8),
                       name = "Planting Month") +
    theme_bw() +
    theme(axis.title.y = element_text(size = 11, vjust = 3),
          axis.title.y.right = element_text(size = 11, 
                                            vjust = -2,
                                            angle = 90),
          axis.title.x = element_text(size = 11, vjust = -3),
          axis.text = element_text(size = 11),
          legend.text = element_text(size = 11),
          legend.position = "bottom",
          legend.title.align = 0.5,
          legend.title = element_text(face = "bold", size = 11),
          strip.text = element_text(size = 11))
  
}


var_water_photo_plot = function(x, var, title_axis) {
  
  x %>% 
    ggplot(aes_string("DATE", var)) +
    geom_line(aes(color = PMonth)) +
    geom_line(aes(DATE, water_photo * 10000, group = PMonth), 
              color = "blue", alpha = 0.2) +
    facet_wrap(~Pyear, ncol = 2,
               scales = "free_x") +
    scale_x_date(labels = function(x) month(x, label = T, 
                                            locale = "US"),
                 date_breaks = "2 month",
                 name = "Date") +
    scale_y_continuous(name = title_axis,
                       labels = scales::comma,
                       breaks = seq(0, 30500, by = 2000),
                       sec.axis = sec_axis(~. / 10000,
                                           name = "Water Factor for Photosynthesis",
                                           breaks = seq(0, 1000, by = 0.2))) +
    scale_color_manual(values = RColorBrewer::brewer.pal(name = "Set1", 
                                                         n = 8),
                       name = "Planting Month") +
    theme_bw() +
    theme(axis.title.y = element_text(size = 11, vjust = 3),
          axis.title.y.right = element_text(size = 11, 
                                            vjust = -2,
                                            angle = 90),
          axis.title.x = element_text(size = 11, vjust = -3),
          axis.text = element_text(size = 11),
          legend.text = element_text(size = 11),
          legend.position = "bottom",
          legend.title.align = 0.5,
          legend.title = element_text(face = "bold", size = 11),
          strip.text = element_text(size = 11))
}



var_water_growth_plot = function(x, var, title_axis) {
  
  x %>% 
    ggplot(aes_string("DATE", var)) +
    geom_line(aes(color = PMonth)) +
    geom_line(aes(DATE, water_grow * 10000, group = PMonth), 
              color = "blue", alpha = 0.2) +
    facet_wrap(~Pyear, ncol = 2,
               scales = "free_x") +
    scale_x_date(labels = function(x) month(x, label = T, 
                                            locale = "US"),
                 date_breaks = "2 month",
                 name = "Date") +
    scale_y_continuous(name = title_axis,
                       labels = scales::comma,
                       breaks = seq(0, 30500, by = 2000),
                       sec.axis = sec_axis(~. / 10000,
                                           name = "Water Factor for Growth",
                                           breaks = seq(0, 1000, by = 0.2))) +
    scale_color_manual(values = RColorBrewer::brewer.pal(name = "Set1", 
                                                         n = 8),
                       name = "Planting Month") +
    theme_bw() +
    theme(axis.title.y = element_text(size = 11, vjust = 3),
          axis.title.y.right = element_text(size = 11, 
                                            vjust = -2,
                                            angle = 90),
          axis.title.x = element_text(size = 11, vjust = -3),
          axis.text = element_text(size = 11),
          legend.text = element_text(size = 11),
          legend.position = "bottom",
          legend.title.align = 0.5,
          legend.title = element_text(face = "bold", size = 11),
          strip.text = element_text(size = 11))
  
}

var_temp_photo_plot = function(x, var, title_axis) {
  
  x %>% 
    ggplot(aes_string("DATE", var)) +
    geom_line(aes(color = PMonth)) +
    geom_line(aes(DATE, temp_photo * 10000, group = PMonth), 
              color = "blue", alpha = 0.2) +
    facet_wrap(~Pyear, ncol = 2,
               scales = "free_x") +
    scale_x_date(labels = function(x) month(x, label = T, 
                                            locale = "US"),
                 date_breaks = "2 month",
                 name = "Date") +
    scale_y_continuous(name = title_axis,
                       labels = scales::comma,
                       breaks = seq(0, 30500, by = 2000),
                       sec.axis = sec_axis(~. / 10000,
                                           name = "Temperature Factor for Photosynthesis",
                                           breaks = seq(0, 1000, by = 0.2))) +
    scale_color_manual(values = RColorBrewer::brewer.pal(name = "Set1", 
                                                         n = 8),
                       name = "Planting Month") +
    theme_bw() +
    theme(axis.title.y = element_text(size = 11, vjust = 3),
          axis.title.y.right = element_text(size = 11, 
                                            vjust = -2,
                                            angle = 90),
          axis.title.x = element_text(size = 11, vjust = -3),
          axis.text = element_text(size = 11),
          legend.text = element_text(size = 11),
          legend.position = "bottom",
          legend.title.align = 0.5,
          legend.title = element_text(face = "bold", size = 11),
          strip.text = element_text(size = 11))
  
}


var_temp_growth_plot = function(x, var, title_axis) {
  
  x %>% 
    ggplot(aes_string("DATE", var)) +
    geom_line(aes(color = PMonth)) +
    geom_line(aes(DATE, temp_grow * 10000, group = PMonth), 
              color = "blue", alpha = 0.2) +
    facet_wrap(~Pyear, ncol = 2,
               scales = "free_x") +
    scale_x_date(labels = function(x) month(x, label = T, 
                                            locale = "US"),
                 date_breaks = "2 month",
                 name = "Date") +
    scale_y_continuous(name = title_axis,
                       labels = scales::comma,
                       breaks = seq(0, 30500, by = 2000),
                       sec.axis = sec_axis(~. / 10000,
                                           name = "Temperature Factor for Growth",
                                           breaks = seq(0, 1000, by = 0.2))) +
    scale_color_manual(values = RColorBrewer::brewer.pal(name = "Set1", 
                                                         n = 8),
                       name = "Planting Month") +
    theme_bw() +
    theme(axis.title.y = element_text(size = 11, vjust = 3),
          axis.title.y.right = element_text(size = 11, 
                                            vjust = -2,
                                            angle = 90),
          axis.title.x = element_text(size = 11, vjust = -3),
          axis.text = element_text(size = 11),
          legend.text = element_text(size = 11),
          legend.position = "bottom",
          legend.title.align = 0.5,
          legend.title = element_text(face = "bold", size = 11),
          strip.text = element_text(size = 11))
  
}