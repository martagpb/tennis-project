@echo ------------------------------- 
@echo Suppression de tous les packages du projet
@echo ------------------------------- 

set SQL_PATH=./
sqlplus /NOLOG @%SQL_PATH%delete_tennis_pq_plsql.sql 