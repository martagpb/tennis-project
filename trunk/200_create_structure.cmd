@echo ------------------------------- 
@echo Creation de la structure de la base de donnees
@echo ------------------------------- 

set SQL_PATH=./
sqlplus /NOLOG @%SQL_PATH%create_structure.sql
