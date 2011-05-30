@echo ------------------------------- 
@echo Suppression des donnes dans la base de donnees
@echo ------------------------------- 

set SQL_PATH=./
sqlplus /NOLOG @%SQL_PATH%delete_data.sql
