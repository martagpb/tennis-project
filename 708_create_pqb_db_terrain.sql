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
IS
	--Permet d’ajouter un terrain
	PROCEDURE add_terrain(
	  vcodeSurface IN TERRAIN.CODE_SURFACE%TYPE
	, vnatureSurface IN TERRAIN.NATURE_SURFACE%TYPE
	, vactif IN TERRAIN.ACTIF%TYPE)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		INSERT INTO TERRAIN(CODE_SURFACE, NATURE_SURFACE, ACTIF)
		VALUES(vcodeSurface,vnatureSurface,vactif);  
		COMMIT;
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusée.');
	END add_terrain;
	
	--Permet de modifier un terrain existant
	PROCEDURE upd_terrain(
	  vnumTerrain IN TERRAIN.NUM_TERRAIN%TYPE
	, vcodeSurface IN TERRAIN.CODE_SURFACE%TYPE
	, vnatureSurface IN TERRAIN.NATURE_SURFACE%TYPE
	, vactif IN TERRAIN.ACTIF%TYPE)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
	UPDATE TERRAIN
		SET
		    CODE_SURFACE   = vcodeSurface
		  , NATURE_SURFACE = vnatureSurface
		  , ACTIF          = vactif
		WHERE
			NUM_TERRAIN = vnumTerrain;
		COMMIT;
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusée.');
	END upd_terrain;
	
	--Permet de supprimer un terrain existant
	PROCEDURE del_terrain(
	  vnumTerrain IN TERRAIN.NUM_TERRAIN%TYPE)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		DELETE FROM TERRAIN
		WHERE 
			NUM_TERRAIN = vnumTerrain;
		COMMIT;
		EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusée.');
	END del_terrain;
	
END pq_db_terrain;
/