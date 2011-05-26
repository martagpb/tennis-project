-- -----------------------------------------------------------------------------
--            Initialisation de la base de données pour
--                      Oracle Version 10g
--                        (10/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 24/5/2011
-- -----------------------------------------------------------------------------


-- A exécuter en tant qu'administrateur !


-- -----------------------------------------------------------------------------
--       CREATION TABLESPACES (DONNEES, INDEX, TEMPORAIRE)
--			(par défaut dans '\oracle\product\10.2.0\serveur\database\')
-- -----------------------------------------------------------------------------

CREATE TABLESPACE TENNIS_DATA
    DATAFILE 'tennis_data.tbs' SIZE 10M
	AUTOEXTEND ON
	ONLINE
	DEFAULT STORAGE	(INITIAL 2M NEXT 2M)
  ;

CREATE TABLESPACE TENNIS_IND
	DATAFILE 'tennis_ind.tbs' SIZE 5M
	AUTOEXTEND ON
	ONLINE
  ;
  
CREATE TEMPORARY TABLESPACE TENNIS_TEMP
	TEMPFILE 'tennis_temp.tbs' SIZE 5M
	AUTOEXTEND ON
  ;

  
-- -----------------------------------------------------------------------------
--       CREATION UTILISATEUR ET PRIVILEGES
-- -----------------------------------------------------------------------------

CREATE USER tennis
	IDENTIFIED BY tennis
	DEFAULT TABLESPACE TENNIS_DATA
	TEMPORARY TABLESPACE TENNIS_TEMP;
	
GRANT ALL PRIVILEGES TO tennis;


-- -----------------------------------------------------------------------------
--       CREATION DAD
-- -----------------------------------------------------------------------------

BEGIN
	DBMS_EPG.create_dad (
		dad_name => 'tennis_dad',
		path => '/tennis_dad/*'
	);
END;
/