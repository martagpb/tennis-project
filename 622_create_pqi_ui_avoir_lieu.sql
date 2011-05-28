-- -----------------------------------------------------------------------------
--           Création du package d'interface d'affichage des données
--           pour la table AVOIR_LIEU
--                      Oracle Version 10g
--                        (10/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 14/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE pq_ui_avoir_lieu
IS
	--renvoi les terrains disponible pour une heure et un jour donné
	PROCEDURE exec_test_dipo_avoir_lieu(
	  vnumJourTest IN NUMBER
	 ,vheureDebutCreneauTest IN CHAR
	 ,vnumEntrainementTest IN NUMBER);
	 
	-- Exécute la procédure d'ajout d'une séance d'un entrainement et gère les erreurs éventuelles.
	PROCEDURE exec_add_avoir_lieu(
	  vnumJour IN NUMBER
	, vheureDebutCreneau IN CHAR
	, vnumTerrain IN NUMBER
	, vnumEntrainement IN NUMBER);
	
	-- Exécute la procédure de suppression d'une séance d'un entrainement et gère les erreurs éventuelles
	PROCEDURE exec_del_avoir_lieu(
	  vnumJour IN NUMBER
	, vheureDebutCreneau IN CHAR
	, vnumTerrain IN NUMBER
	, vnumEntrainement IN NUMBER);
	  
	-- Affiche le formulaire permettant la saisie d'une nouvelle séance d'un entrainement
	PROCEDURE form_add_avoir_lieu(
	  vnumEntrainement IN NUMBER);
	
	-- Affiche le test de disponibilité des terrains
	PROCEDURE aff_add_avoir_lieu(
		vnumEntrainement IN NUMBER);

	-- Affiche le test de disponibilité des terrains
	PROCEDURE aff_test_avoir_lieu(
		vnumEntrainement IN NUMBER);
		
END pq_ui_avoir_lieu;
/