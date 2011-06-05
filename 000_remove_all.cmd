@echo ------------------------------- 
@echo Desinstallation complete du projet
@echo ------------------------------- 

set SQL_PATH=./
sqlplus /NOLOG @%SQL_PATH%remove_all.sql
