rm(list = ls())

getwd()
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(tidyverse)
df <-read_csv("216_2018_1156_MOESM2_ESM.csv")
ncol(df)
wavelengths <- colnames(df)
length(wavelengths)
length(unique(sort(wavelengths, decreasing = TRUE)))

df2 <- df %>% gather(wavelength, heights, 2:1865)

stats <- df2 %>%
  # filter(Herd %in% c("GRH", "PCH")) %>%
  group_by(wavelength) %>%
  summarise(
    meanHeights= mean(is.na(heights)),
    SD = sd(is.na(heights)),
    N = n(),
    SEM = SD/sqrt(N),
    CI = SEM * qt(0.975, N-1))
stats
