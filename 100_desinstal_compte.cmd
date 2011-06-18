@echo ------------------------------- 
@echo Désinstallation du compte du projet
@echo ------------------------------- 

set SQL_PATH=./
sqlplus /NOLOG @%SQL_PATH%desinstal_compte.sql
