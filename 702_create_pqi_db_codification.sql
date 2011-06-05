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

CREATE OR REPLACE PACKAGE pq_db_codification
IS
	--Permet d’ajouter une codification
	PROCEDURE add_codification(
	  vcode IN CODIFICATION.CODE%TYPE
	, vnature IN CODIFICATION.NATURE%TYPE
	, vlibelle IN CODIFICATION.LIBELLE%TYPE);	
	
	--Permet de modifier une codification existante
	PROCEDURE upd_codification(
	  vcode IN CODIFICATION.CODE%TYPE
	, vnature IN CODIFICATION.NATURE%TYPE
	, vlibelle IN CODIFICATION.LIBELLE%TYPE);
	
	--Permet de supprimer une codification existante
	PROCEDURE del_codification(
	  vcode IN CODIFICATION.CODE%TYPE
	, vnature IN CODIFICATION.NATURE%TYPE);
	
	-- Fonction permettant de retourner le libellé d'une condification en indiquant le code et la nature de la codification
	FUNCTION get_libelle(
	  vcode IN CODIFICATION.CODE%TYPE
	, vnature IN CODIFICATION.NATURE%TYPE)
	RETURN VARCHAR2;
	
END pq_db_codification;
/