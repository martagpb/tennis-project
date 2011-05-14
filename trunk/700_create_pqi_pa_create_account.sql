          -- -----------------------------------------------------------------------------
--            Création de l'interface du package pq_pa_create_account de la base de données pour
--                      Oracle Version 10g
--                        (10/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 14/5/2011
-- -----------------------------------------------------------------------------
 
 
 
CREATE OR REPLACE PACKAGE pq_pa_create_account
AS 
	PROCEDURE create_account ( lastname IN VARCHAR2,  firstname IN VARCHAR2,login IN VARCHAR2,password IN VARCHAR2,mail IN VARCHAR2,phone IN VARCHAR2,street IN VARCHAR2,postal IN VARCHAR2,city IN VARCHAR2) ;
END pq_pa_create_account;
/