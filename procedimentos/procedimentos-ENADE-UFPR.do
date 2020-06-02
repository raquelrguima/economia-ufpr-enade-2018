clear all

global diretorio "C:\Users\Raquel\Desktop\Economia-UFPR-Enade\2018\"

cd "$diretorio\dados"

use microdados_enade_2018, clear

/* FILTROS UFPR */

keep if CO_IES==571

save microdados_enade_ufpr_2018, replace

/* ETIQUETANDO DADOS */

do "$diretorio\procedimentos\label-variables.do"
do "$diretorio\procedimentos\label-values.do"

export excel using "microdados_enade_ufpr_2018.xlsx", firstrow(variables) replace

/* APENAS ALUNOS ECONOMIA UFPR */

keep if CO_CURSO==12571 | CO_CURSO==49468

gen curso=str(50)
replace curso=12571 "CIÊNCIAS ECONÔMICAS - DIURNO" 49468 "CIÊNCIAS ECONÔMICAS NOTURNO"
