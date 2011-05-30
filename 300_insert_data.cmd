@echo ------------------------------- 
@echo Insertion des donnees dans la base de donnees
@echo ------------------------------- 

set SQL_PATH=./
sqlplus /NOLOG @%SQL_PATH%insert_data.sql
