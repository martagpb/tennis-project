       -- -----------------------------------------------------------------------------
--            Création de l'interface du package pq_ui_login de la base de données pour
--                      Oracle Version 10g
--                        (10/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 14/5/2011
-- -----------------------------------------------------------------------------
 
 
 
 
CREATE OR REPLACE PACKAGE pq_ui_login
AS 
	PROCEDURE login;
	PROCEDURE check_login ( login IN VARCHAR2,  password IN VARCHAR2);
END pq_ui_login;
/