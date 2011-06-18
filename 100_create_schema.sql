-- -----------------------------------------------------------------------------
--             G�n�ration du sch�ma de la base de donn�es pour
--                      Oracle Version 10g
--                        (10/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de derni�re modification : 10/5/2011
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
--       CREATION UTILISATEUR 
-- -----------------------------------------------------------------------------

CREATE USER tennis
	IDENTIFIED BY tennis
	DEFAULT TABLESPACE BD50_DATA;
	
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