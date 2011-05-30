@echo ------------------------------- 
@echo Reconstruction des index de la base de donnees
@echo ------------------------------- 

set SQL_PATH=./
sqlplus /NOLOG @%SQL_PATH%rebuild_index.sql
