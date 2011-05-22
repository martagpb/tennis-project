-- -----------------------------------------------------------------------------
--           Création du package d'interface d'affichage des données
--           pour la table TERRAIN
--                      Oracle Version 10g
--                        (14/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 21/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE pq_ui_terrain
IS
	--Permet d'afficher tous les terrains et les actions possibles de gestion avec le menu
	PROCEDURE manage_terrains_with_menu;
	
	--Permet d'afficher tous les terrains et les actions possibles de gestion (sans le menu)
	PROCEDURE manage_terrains;
	
	--Permet d’afficher un terrain existant
	PROCEDURE dis_terrain(
	  vnumTerrain IN NUMBER
	, vcodeSurface IN CHAR
	, vnatureSurface IN VARCHAR2
	, vactif IN NUMBER);
	
	-- Exécute la procédure d'ajout d'un terrain et gère les erreurs éventuelles.
	PROCEDURE exec_add_terrain(
	  vcodeSurface IN CHAR
	, vnatureSurface IN VARCHAR2
	, vactif IN NUMBER);
	
	-- Exécute la procédure de mise à jour d'un terrain et gère les erreurs éventuelles
	PROCEDURE exec_upd_terrain(
	  vnumTerrain IN NUMBER
	, vcodeSurface IN CHAR
	, vnatureSurface IN VARCHAR2
	, vactif IN NUMBER);
	
	-- Exécute la procédure de suppression d'un terrain et gère les erreurs éventuelles
	PROCEDURE exec_del_terrain(
	  vnumTerrain IN NUMBER);
	
	-- Exécute la procédure d’affichage des terrains et gère les erreurs éventuelles
	PROCEDURE exec_dis_terrain(
	  vnumTerrain IN NUMBER
	, vcodeSurface IN CHAR
	, vnatureSurface IN VARCHAR2
	, vactif IN NUMBER);
	
	-- Affiche le formulaire permettant la saisie d’un nouveau terrain
	PROCEDURE form_add_terrain;
	
	-- Affiche le formulaire de saisie permettant la modification d’un terrain existant
	PROCEDURE form_upd_terrain(
	  vnumTerrain IN NUMBER
	, vcodeSurface IN CHAR
	, vnatureSurface IN VARCHAR2
	, vactif IN NUMBER);
		
END pq_ui_terrain;
/