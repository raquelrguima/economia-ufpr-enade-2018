##################################################################################
# MEC/INEP/DAES (Diretoria de Avaliação da Educação Superior) #
# Coordenação Geral de Controle de Qualidade da Educação Superior #
#--------------------------------------------------------------------------------#
# Programa: #
# R_input_enade_2018.R (Pasta "INPUTS") #
#--------------------------------------------------------------------------------#
# Descrição: #
# Programa para Leitura dos Microdados do enade 2018 #
# #
#********************************************************************************#

setwd("C:/Users/Raquel/Desktop/Economia-UFPR-Enade/2018/dados")

microdados_enade <- read.table("microdados_enade_2018.txt",header = TRUE, sep=";", dec = ".", 
	colClasses=c(DS_VT_ACE_OFG="character",DS_VT_ACE_OCE="character"))

for (colname in names(microdados_enade)) {
  if (is.character(microdados_enade[[colname]])) {
    microdados_enade[[colname]] <- as.factor(microdados_enade[[colname]])
  }
}

library(foreign)
write.dta(microdados_enade, "microdados_enade_2018.dta")
