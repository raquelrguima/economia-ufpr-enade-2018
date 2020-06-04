clear all

global diretorio "C:\Users\Raquel\GitHub\economia-ufpr-enade-2018\"

cd "$diretorio\dados"

use microdados_enade_2018, clear

/* FILTROS UFPR */

keep if CO_IES==571

save microdados_enade_ufpr_2018, replace

/* SOME RECODING */

recode CO_RS_I1 (1 3=6 "SEM RESPOSTA") (2=7 "RESPOSTA ANULADA") (3=1 "MUITO FACIL") (4=2 "FACIL") (5=3 "MEDIO") (6=4 "DIFICIL") (7=5 "MUITO DIFICIL"), gen(CO_RS_I1_2)

recode CO_RS_I2 (1 2=6 "SEM RESPOSTA") (2=7 "RESPOSTA ANULADA")  (3=1 "MUITO FACIL") (4=2 "FACIL") (5=3 "MEDIO") (6=4 "DIFICIL") (7=5 "MUITO DIFICIL"), gen(CO_RS_I2_2)

recode CO_RS_I3 (1 2=6 "SEM RESPOSTA") (2=7 "RESPOSTA ANULADA")  (3=1 "MUITO LONGA") (4=2 "LONGA") (5=3 "ADEQUADA") (6=4 "CURTA") (7=5 "MUITO CURTA"), gen(CO_RS_I3_2)

recode CO_RS_I4 (1 2=6 "SEM RESPOSTA") (2=7 "RESPOSTA ANULADA")  (3=1 "SIM, TODOS") (4=2 "SIM, A MAIORIA") (5=3 "APENAS CERCA DA METADE") (6=4 "POUCOS") (7=5 "NAO, NENHUM"), gen(CO_RS_I4_2)

recode CO_RS_I5 (1 2=6 "SEM RESPOSTA") (2=7 "RESPOSTA ANULADA")  (3=1 "SIM, TODOS") (4=2 "SIM, A MAIORIA") (5=3 "APENAS CERCA DA METADE") (6=4 "POUCOS") (7=5 "NAO, NENHUM"), gen(CO_RS_I5_2)

recode CO_RS_I6 (1 2=6 "SEM RESPOSTA") (2=7 "RESPOSTA ANULADA")  (3=1 "SIM, ATÉ EXCESSIVAS") (4=2 "SIM, EM TODAS ELAS") (5=3 "SIM, NA MAIORIA DELAS") (6=4 "SIM, SOMENTE EM ALGUMAS") (7=5 "NAO, EM NENHUMA DELAS"), gen(CO_RS_I6_2)

recode CO_RS_I7 (1 2=6 "SEM RESPOSTA") (2=7 "RESPOSTA ANULADA") (3=1 "DESCONHECIMENTO DO CONTEUDO") (4=2 "FORMA DIFERENTE DE ABORDAGEM DO CONTEUDO") (5=3 "ESPACO INSUFICIENTE PARA RESOLVER AS QUESTOES") (6=4 "FALTA DE MOTIVACAO PARA FAZER A PROVA") (7=5 "NAO TIVE QUALQUER TIPO DE DIFICULDADE EM RESPONDER A PROVA"), gen(CO_RS_I7_2)

recode CO_RS_I8 (1 2=6 "SEM RESPOSTA") (2=7 "RESPOSTA ANULADA") (3=1 "NAO ESTUDOU AINDA A MAIORIA DESSES CONTEÚDOS") (4=2 "ESTUDOU ALGUNS DESSES CONTEUDOS, MAS NAO OS APRENDEU") (5=3 "ESTUDOU A MAIORIA DESSES CONTEUDOS, MAS NAO OS APRENDEU") (6=4 "ESTUDOU E APRENDEU MUITOS DESSES CONTEUDOS") (7=5 "ESTUDOU E APRENDEU TODOS ESSES CONTEUDOS"), gen(CO_RS_I8_2)

recode CO_RS_I9 (1 2=6 "SEM RESPOSTA") (2=7 "RESPOSTA ANULADA")  (3=1 "MENOS DE UMA HORA") (4=2 "ENTRE UMA E DUAS HORAS") (5=3 "ENTRE DUAS E TRES HORAS") (6=4 "ENTRE TRES E QUATRO HORAS") (7=5 "QUATRO HORAS E NAO CONSEGUI TERMINAR"), gen(CO_RS_I9_2)

/* ETIQUETANDO DADOS */

do "$diretorio\procedimentos\label-values.do"

do "$diretorio\procedimentos\label-variables.do"

export excel using "microdados_enade_ufpr_2018.xlsx", firstrow(variables) nolabel replace

/* APENAS ALUNOS ECONOMIA UFPR */

keep if CO_CURSO==12571 | CO_CURSO==49468

// Modifica label

label define CO_CURSO 12571 "DIURNO" 49468 "NOTURNO"
label values CO_CURSO CO_CURSO

/* GERA ALGUMAS ANÁLISES */

log using "$diretorio\Resultados-Economia-ENADE-2018.log", replace

// Iniciamos com uma descrição do banco de dados

// Média, mínimo, máximo e desvio-padrão de variáveis interessantes para análise

local numericas NU_IDADE NT_GER NT_FG NT_OBJ_FG NT_DIS_FG NT_FG_D1 NT_FG_D1_PT NT_FG_D1_CT NT_FG_D2 NT_FG_D2_CT NT_CE NT_OBJ_CE NT_DIS_CE NT_CE_D1 NT_CE_D2 NT_CE_D3

foreach var of local numericas {
	* Mostra nome variável
	di "*********************************************************************"
	di "Variável `var'"
	di "`: var label `var'''"
	tab CO_CURSO if CO_CURSO==12571 | CO_CURSO==49468, sum(`var')
}

//Tabulação das variáveis categóricas da base interessantes para análise

local categoricas `r(varlist)' ANO_FIM_EM ANO_IN_GRAD CO_RS_I1 CO_RS_I2 CO_RS_I3 CO_RS_I4 CO_RS_I5 CO_RS_I6 CO_RS_I7 CO_RS_I8 CO_RS_I9 QE_I01 QE_I02 QE_I03 QE_I04 QE_I05 QE_I06 QE_I07 QE_I08 QE_I09 QE_I10 QE_I11 QE_I12 QE_I13 QE_I14 QE_I15 QE_I16 QE_I17 QE_I18 QE_I19 QE_I20 QE_I21 QE_I22 QE_I23 QE_I24 QE_I25 QE_I26 QE_I27 QE_I28 QE_I29 QE_I30 QE_I31 QE_I32 QE_I33 QE_I34 QE_I35 QE_I36 QE_I37 QE_I38 QE_I39 QE_I40 QE_I41 QE_I42 QE_I43 QE_I44 QE_I45 QE_I46 QE_I47 QE_I48 QE_I49 QE_I50 QE_I51 QE_I52 QE_I53 QE_I54 QE_I55 QE_I56 QE_I57 QE_I58 QE_I59 QE_I60 QE_I61 QE_I62 QE_I63 QE_I64 QE_I65 QE_I66 QE_I67 QE_I68

foreach var of local categoricas {
	* Mostra nome variável
	di "*********************************************************************"
	di "Variável `var'"
	di "`: var label `var'''"
	tab `var' CO_CURSO if CO_CURSO==12571 | CO_CURSO==49468, col
}

log close

