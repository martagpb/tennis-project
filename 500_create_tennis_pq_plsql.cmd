@echo ------------------------------- 
@echo Installation du projet Tennis
@echo Projet realise par J.Gonzalves, D.Invernizzi, R.Joly, M.Leviste
@echo ------------------------------- 

set SQL_PATH=./
sqlplus /NOLOG @%SQL_PATH%create_tennis_pq_plsql.sql