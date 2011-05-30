@echo ------------------------------- 
@echo Installation du compte du projet
@echo ------------------------------- 

set SQL_PATH=./
sqlplus /NOLOG @%SQL_PATH%instal_compte.sql
