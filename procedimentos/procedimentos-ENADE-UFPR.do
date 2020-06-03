clear all

global diretorio "C:\Users\Raquel\GitHub\economia-ufpr-enade-2018\"

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

/* GERA ALGUMAS ANÁLISES */

log using "$diretorio\Resultados-Economia-ENADE-2018.log", replace

// Iniciamos com uma descrição do banco de dados

// Média, mínimo, máximo e desvio-padrão de todas as variáveis não-string

ds, has(type numeric)

local numericas `r(varlist)'

foreach var of local numericas {
	tab CO_CURSO if CO_CURSO==12571 | CO_CURSO==49468, sum(`var')
}

//Tabulação de todas as variáveis categóricas da base

ds, has(vall)

local categoricas `r(varlist)'

foreach var of local categoricas {
	tab `var' CO_CURSO if CO_CURSO==12571 | CO_CURSO==49468
}

log close

