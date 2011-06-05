-- -----------------------------------------------------------------------------
--           Création du package d'interface d'accès à la base de données 
--           pour la table TERRAIN
--                      Oracle Version 10g
--                        (10/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 14/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE pq_db_terrain
IS
	--Permet d’ajouter un terrain
	PROCEDURE add_terrain(
	vcodeSurface IN TERRAIN.CODE_SURFACE%TYPE
	, vnatureSurface IN TERRAIN.NATURE_SURFACE%TYPE
	, vactif IN TERRAIN.ACTIF%TYPE);
	
	--Permet de modifier un terrain existant
	PROCEDURE upd_terrain(
	  vnumTerrain IN TERRAIN.NUM_TERRAIN%TYPE
	, vcodeSurface IN TERRAIN.CODE_SURFACE%TYPE
	, vnatureSurface IN TERRAIN.NATURE_SURFACE%TYPE
	, vactif IN TERRAIN.ACTIF%TYPE);
	
	--Permet de supprimer un terrain existant
	PROCEDURE del_terrain(
	  vnumTerrain IN TERRAIN.NUM_TERRAIN%TYPE);
	
END pq_db_terrain;
/