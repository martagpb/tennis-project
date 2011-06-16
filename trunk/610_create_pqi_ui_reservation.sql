-- -----------------------------------------------------------------------------
--           Cr�ation du package d'interface d'affichage des donn�es
--           pour les r�servations
--                      Oracle Version 10g
--                        (10/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de derni�re modification : 09/06/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE pq_ui_reservation
IS
	--	Affiche la liste des terrains pour avoir acc�s aux plannings
	PROCEDURE liste_terrains;

	--	Affiche le planning d'un terrain � partir de la date sp�cifi�e (pour 7 jours)
	PROCEDURE planning_global(
	  pdateDebut IN VARCHAR2
	, pnumTerrain IN VARCHAR2);
	
	--Affiche le panneau de gestion des r�servations
	PROCEDURE manage_reservations;

	--Affiche une reservation existante
	PROCEDURE dis_reservation(
	  pnumTerrain IN VARCHAR2
	, pdate IN VARCHAR2
	, pheureDebut IN VARCHAR2);
	
	-- Affiche le formulaire de saisie d'une nouvelle reservation
	PROCEDURE form_add_reservation;
	
	-- Affiche le formulaire de saisie d'une nouvelle reservation pour un terrain, une date et un cr�neau donn�
	PROCEDURE form_add_reservation(
	  pnumTerrain IN VARCHAR2
	, pdate IN VARCHAR2
	, pheure IN VARCHAR2);
	
	-- Ex�cute la proc�dure d'ajout d'une reservation et g�re les erreurs �ventuelles.
	PROCEDURE exec_add_reservation(
		  pnumTerrain IN VARCHAR2
		, pdate IN VARCHAR2
		, pheure IN VARCHAR2
		, pnumJoueur IN VARCHAR2);
	
	-- Affiche le formulaire de modification d�une reservation existante
	PROCEDURE form_upd_reservation(
	  pnumTerrain IN VARCHAR2
	, pdate IN VARCHAR2
	, pheure IN VARCHAR2);
	
	-- Ex�cute la proc�dure de mise � jour d'une reservation et g�re les erreurs �ventuelles
	PROCEDURE exec_upd_reservation(
	  pnumTerrainOld IN VARCHAR2
	, pdateOld IN VARCHAR2
	, pheureOld IN VARCHAR2
	, pnumTerrain IN VARCHAR2
	, pdate IN VARCHAR2
	, pheure IN VARCHAR2
	, pnumJoueur IN VARCHAR2);
	
	-- Ex�cute la proc�dure de suppression d'une reservation et g�re les erreurs �ventuelles
	PROCEDURE exec_del_reservation(
		  pnumTerrain IN VARCHAR2
		, pdate IN VARCHAR2
		, pheure IN VARCHAR2);
	  
END pq_ui_reservation;
/