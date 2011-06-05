@echo ------------------------------- 
@echo Installation complete du projet
@echo ------------------------------- 

set SQL_PATH=./
sqlplus /NOLOG @%SQL_PATH%setup_all.sql
