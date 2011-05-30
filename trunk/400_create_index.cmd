@echo ------------------------------- 
@echo Creation des index pour la base de donnees
@echo ------------------------------- 

set SQL_PATH=./
sqlplus /NOLOG @%SQL_PATH%create_index.sql
