-- -----------------------------------------------------------------------------
--           Cr�ation du package d'interface d'affichage des donn�es
--           pour la table TERRAIN
--                      Oracle Version 10g
--                        (14/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de derni�re modification : 14/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE UI_TERRAIN
IS
	--Permet d�afficher un terrain existant
	PROCEDURE DIS_TERRAIN(
	  vnumTerrain IN NUMBER
	, vcodeSurface IN CHAR
	, vnatureSurface IN VARCHAR2
	, vactif IN NUMBER);
	
	-- Ex�cute la proc�dure d'ajout d'un terrain et g�re les erreurs �ventuelles.
	PROCEDURE EXEC_ADD_TERRAIN(
	  vnumTerrain IN NUMBER
	, vcodeSurface IN CHAR
	, vnatureSurface IN VARCHAR2
	, vactif IN NUMBER);
	
	-- Ex�cute la proc�dure de mise � jour d'un terrain et g�re les erreurs �ventuelles
	PROCEDURE EXEC_UPD_TERRAIN(
	  vnumTerrain IN NUMBER
	, vcodeSurface IN CHAR
	, vnatureSurface IN VARCHAR2
	, vactif IN NUMBER);
	
	-- Ex�cute la proc�dure de suppression d'un terrain et g�re les erreurs �ventuelles
	PROCEDURE EXEC_DEL_TERRAIN(
	  vnumTerrain IN NUMBER);
	
	-- Ex�cute la proc�dure d�affichage des terrains et g�re les erreurs �ventuelles
	PROCEDURE EXEC_DIS_TERRAIN(
	  vnumTerrain IN NUMBER
	, vcodeSurface IN CHAR
	, vnatureSurface IN VARCHAR2
	, vactif IN NUMBER);
	
	-- Affiche le formulaire permettant la saisie d�un nouveau terrain
	PROCEDURE FORM_ADD_TERRAIN;
	
	-- Affiche le formulaire de saisie permettant la modification d�un terrain existant
	PROCEDURE FORM_UPD_TERRAIN(
	  vnumTerrain IN NUMBER
	, vcodeSurface IN CHAR
	, vnatureSurface IN VARCHAR2
	, vactif IN NUMBER);
		
END UI_TERRAIN;
/