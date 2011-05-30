@echo ------------------------------- 
@echo Suppression des index de la base de donnees
@echo ------------------------------- 

set SQL_PATH=./
sqlplus /NOLOG @%SQL_PATH%drop_index.sql
