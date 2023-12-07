library(readr)
library(tidyverse)
library(dplyr)
library(readxl)
library(ggplot2)
library(tibble)
library(readxl)
library(data.table)
library(openxlsx)

setwd("C:/Users/Tibo/Documents/Demographie/M2S1/UE5 - Diagnostic du territoire")


qpvSortant <- read.csv2(file="./data/qpv_sortant_precoce.csv", encoding = "UTF-8") %>%
  separate(NomQPV, c("Tieks", "EMS"), sep = ": ") %>%
  mutate(EMS = case_when(is.na(EMS) ~ Tieks, T ~ EMS))

qpvSortant$NbJeunesNPrec <- as.numeric(qpvSortant$NbJeunesNPrec)
qpvSortant$NbJeunesPrec <- as.numeric(qpvSortant$NbJeunesPrec)
qpvSortant$TSort <- as.numeric(qpvSortant$TSort)

corresp <- read_excel("./data/table_correspondance_IRIS_EMS.xlsx", sheet = "EMS")
qpvSortant <- qpvSortant %>% left_join(corresp, by = c("EMS" = "LIB_IRIS_EMS"))
write_csv2(qpvSortant,"./data/qpv_sortant_precoce_INSEE.csv")