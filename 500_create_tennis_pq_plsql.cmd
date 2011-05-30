@echo ------------------------------- 
@echo Creation de l'application du projet
@echo ------------------------------- 

set SQL_PATH=./
sqlplus /NOLOG @%SQL_PATH%create_tennis_pq_plsql.sql