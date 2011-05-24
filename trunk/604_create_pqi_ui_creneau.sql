-- -----------------------------------------------------------------------------
--           Cr�ation du package d'interface d'affichage des donn�es
--           pour la table CRENEAU
--                      Oracle Version 10g
--                        (10/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de derni�re modification : 14/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE pq_ui_creneau
IS
	--Permet d'afficher tous les cr�neaux et les actions possibles de gestion (avec le menu)
	PROCEDURE manage_creneaux_with_menu;

	--Permet d'afficher tous les cr�neaux et les actions possibles de gestion (sans le menu)
	PROCEDURE manage_creneaux;
	
	--Permet d�afficher un cr�neau existant
	PROCEDURE dis_creneau(
	  vheureDebutCreneau IN CHAR
	, vheureFinCreneau IN CHAR);
	
	-- Ex�cute la proc�dure d'ajout d'un cr�neau et g�re les erreurs �ventuelles.
	PROCEDURE exec_add_creneau(
	  vheureDebutCreneau IN CHAR
	, vheureFinCreneau IN CHAR);
	
	-- Ex�cute la proc�dure de mise � jour d'un cr�neau et g�re les erreurs �ventuelles
	PROCEDURE exec_upd_creneau(
	  vheureDebutCreneau IN CHAR
	, vheureFinCreneau IN CHAR);
	
	-- Ex�cute la proc�dure de suppression d'un cr�neau et g�re les erreurs �ventuelles
	PROCEDURE exec_del_creneau(
	  vheureDebutCreneau IN CHAR);
	  
	-- Ex�cute la proc�dure d�affichage des cr�neaux et g�re les erreurs �ventuelles
	PROCEDURE exec_dis_creneau(
	  vheureDebutCreneau IN CHAR
	, vheureFinCreneau IN CHAR);
	
	-- Affiche le formulaire permettant la saisie d�un nouveau cr�neau
	PROCEDURE form_add_creneau;
	
	-- Affiche le formulaire de saisie permettant la modification d�un cr�neau existant
	PROCEDURE form_upd_creneau(
	  vheureDebutCreneau IN CHAR
	, vheureFinCreneau IN CHAR);
	
	-- Fonction permettant d'extraire les heures d'un cr�neau
	FUNCTION get_heure(
		vcreneau IN CHAR
	)
	RETURN CHAR;
	
	-- Fonction permettant d'extraire les minutes d'un cr�neau
	FUNCTION get_minute(
		vcreneau IN CHAR
	)
	RETURN CHAR;
	
END pq_ui_creneau;
/