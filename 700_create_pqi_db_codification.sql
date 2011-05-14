-- -----------------------------------------------------------------------------
--           Création du package d'interface d'accès à la base de données 
--           pour la table CODIFICATION
--                      Oracle Version 10g
--                        (10/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 14/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE DB_CODIFICATION
IS
	--Permet d’ajouter une codification
	PROCEDURE ADD_CODIFICATION(
	  vcode IN CHAR
	, vnature IN VARCHAR2
	, vlibelle IN VARCHAR2);	
	
	--Permet de modifier une codification existante
	PROCEDURE UPD_CODIFICATION(
	  vcode IN CHAR
	, vnature IN VARCHAR2
	, vlibelle IN VARCHAR2);	
	
	--Permet de supprimer une codification existante
	PROCEDURE DEL_CODIFICATION(
	  vcode IN CHAR
	, vnature IN VARCHAR2);
	
END DB_CODIFICATION;
/