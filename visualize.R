library(ggplot2)
library(viridis)
library(scales)
source('03_summarise.R')

df <- summarise_data(dir = 'data/lviv/')

png(filename = 'lviv.png', width = 1000, height = 1000)

lbls = data.frame(x = rep(as.Date('2016-07-01'), 5), 
                  y = seq(-10, 30, 10), 
                  label = seq(-10, 30, 10))

ggplot(df)+
  geom_hline(yintercept = 0, color = 'gray', size = 0.5)+
  geom_linerange(aes(x = date, ymin = mint, ymax = maxt, color = meant), size = 1)+
  geom_text(aes(x = as.Date('2016-01-01'), y = -50, label = 'Львів',
                family = 'Ubuntu Condensed'), size = 18, color = "#3A3F4A")+
  geom_text(data = lbls, aes(x = x, y = y, label = label,
                family = 'Ubuntu Condensed'), size = 6, color = "#3A3F4A", hjust = 0.5)+
  scale_color_viridis(option = 'magma', end = 0.8, 
                      limits = c(-25, 35),
                      breaks = seq(-20, 30, 10), 
                      labels = as.character(seq(-20, 30, 10)))+
  scale_x_date(date_breaks = '1 month', 
               labels = c('січень', 'лютий', 'березень', 'квітень', 'травень', 'червень',
                          'липень', 'серпень', 'вересень', 'жовтень', 'листопад', 'грудень', ''))+
  scale_y_continuous(limits = c(-50, 40),
                     breaks = seq(-30, 40, 10), 
                     expand = c(0, 0))+
  coord_polar()+
  guides(color = guide_colorbar(title = "cередньодобова температура, C", 
                                raster = F, 
                                title.position = "top"))+
  theme_minimal()+
  theme(
    text = element_text(family = "Ubuntu Condensed", color = "#3A3F4A"),
    panel.grid = element_line(linetype = 'solid', color = 'black', size = 0.75),
    axis.title = element_blank(),
    axis.text.x = element_text(size = 15, hjust = 1),
    axis.text.y = element_blank(),
    legend.position = c(0.5, 0.40),
    legend.direction = 'horizontal',
    legend.key.height = unit(3, "pt"),
    legend.key.width = unit(40, "pt"),
    legend.text = element_text(size = 15),
    legend.title = element_text(size = 15),
    legend.title.align = 0.5,
    plot.background = element_rect(fill = "#EFF2F4"),
    plot.margin = unit(c(1, 1, 1, 1), "cm")
    )

dev.off()
  