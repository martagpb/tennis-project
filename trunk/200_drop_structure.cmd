@echo ------------------------------- 
@echo Suppression de la structure de la base de donnees
@echo ------------------------------- 

set SQL_PATH=./
sqlplus /NOLOG @%SQL_PATH%drop_structure.sql
