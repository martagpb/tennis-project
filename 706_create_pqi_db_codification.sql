-- -----------------------------------------------------------------------------
--           Cr�ation du package d'interface d'acc�s � la base de donn�es 
--           pour la table CODIFICATION
--                      Oracle Version 10g
--                        (10/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de derni�re modification : 14/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE pq_db_codification
IS
	--Permet d�ajouter une codification
	PROCEDURE add_codification(
	  vcode IN CHAR
	, vnature IN VARCHAR2
	, vlibelle IN VARCHAR2);	
	
	--Permet de modifier une codification existante
	PROCEDURE upd_codification(
	  vcode IN CHAR
	, vnature IN VARCHAR2
	, vlibelle IN VARCHAR2);	
	
	--Permet de supprimer une codification existante
	PROCEDURE del_codification(
	  vcode IN CHAR
	, vnature IN VARCHAR2);
	
END pq_db_codification;
/