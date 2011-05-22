-- -----------------------------------------------------------------------------
--           Création du package d'interface d'accès à la base de données 
--           pour la table TERRAIN
--                      Oracle Version 10g
--                        (10/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 21/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pq_db_terrain
AS
	--Permet d’ajouter un terrain
	PROCEDURE add_terrain(
	  vcodeSurface IN CHAR
	, vnatureSurface IN VARCHAR2
	, vactif IN NUMBER)
	IS
	BEGIN
		INSERT INTO TERRAIN(CODE_SURFACE, NATURE_SURFACE, ACTIF)
		VALUES(vcodeSurface,vnatureSurface,vactif);  
		COMMIT;
	END add_terrain;
	
	--Permet de modifier un terrain existant
	PROCEDURE upd_terrain(
	  vnumTerrain IN NUMBER
	, vcodeSurface IN CHAR
	, vnatureSurface IN VARCHAR2
	, vactif IN NUMBER)
	IS
	BEGIN
	UPDATE TERRAIN
		SET
		    CODE_SURFACE   = vcodeSurface
		  , NATURE_SURFACE = vnatureSurface
		  , ACTIF          = vactif
		WHERE
			NUM_TERRAIN = vnumTerrain;
		COMMIT;
	END upd_terrain;
	
	--Permet de supprimer un terrain existant
	PROCEDURE del_terrain(
	  vnumTerrain IN NUMBER)
	IS
	BEGIN
		DELETE FROM TERRAIN
		WHERE 
			NUM_TERRAIN = vnumTerrain;
		COMMIT;
	END del_terrain;
	
END pq_db_terrain;
/