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

CREATE OR REPLACE PACKAGE DB_TERRAIN
IS
	--Permet d’ajouter un terrain
	PROCEDURE ADD_TERRAIN(
	  vnumTerrain IN NUMBER
	, vcodeSurface IN CHAR
	, vnatureSurface IN VARCHAR2
	, vactif IN NUMBER);
	
	--Permet de modifier un terrain existant
	PROCEDURE UPD_TERRAIN(
	  vnumTerrain IN NUMBER
	, vcodeSurface IN CHAR
	, vnatureSurface IN VARCHAR2
	, vactif IN NUMBER);
	
	--Permet de supprimer un terrain existant
	PROCEDURE DEL_TERRAIN(
	  vnumTerrain IN NUMBER);
	
END DB_TERRAIN;
/