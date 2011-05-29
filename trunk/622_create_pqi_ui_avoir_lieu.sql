-- -----------------------------------------------------------------------------
--           Cr�ation du package d'interface d'affichage des donn�es
--           pour la table AVOIR_LIEU
--                      Oracle Version 10g
--                        (10/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de derni�re modification : 14/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE pq_ui_avoir_lieu
IS
	--renvoi les terrains disponible pour une heure et un jour donn�
	PROCEDURE exec_test_dipo_avoir_lieu(
	  vnumJourTest IN NUMBER
	 ,vheureDebutCreneauTest IN CHAR
	 ,vnumEntrainementTest IN NUMBER
	 ,vretourEntraineur IN NUMBER);
	 
	-- Ex�cute la proc�dure d'ajout d'une s�ance d'un entrainement et g�re les erreurs �ventuelles.
	PROCEDURE exec_add_avoir_lieu(
	  vnumJour IN NUMBER
	, vheureDebutCreneau IN CHAR
	, vnumTerrain IN NUMBER
	, vnumEntrainement IN NUMBER
	, vretourEntraineur IN NUMBER);
	
	-- Ex�cute la proc�dure de suppression d'une s�ance d'un entrainement et g�re les erreurs �ventuelles
	PROCEDURE exec_del_avoir_lieu(
	  vnumJour IN NUMBER
	, vheureDebutCreneau IN CHAR
	, vnumTerrain IN NUMBER
	, vnumEntrainement IN NUMBER
	, vretourEntraineur IN NUMBER);
	  
	-- Affiche le formulaire permettant la saisie d'une nouvelle s�ance d'un entrainement
	PROCEDURE form_add_avoir_lieu(
	   vnumEntrainement IN NUMBER
	  ,vretourEntraineur IN NUMBER);
		
END pq_ui_avoir_lieu;
/