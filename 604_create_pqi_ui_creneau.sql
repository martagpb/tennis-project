-- -----------------------------------------------------------------------------
--           Création du package d'interface d'affichage des données
--           pour la table CRENEAU
--                      Oracle Version 10g
--                        (10/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 14/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE pq_ui_creneau
IS
	--Permet d'afficher tous les créneaux et les actions possibles de gestion (avec le menu)
	PROCEDURE manage_creneaux_with_menu;

	--Permet d'afficher tous les créneaux et les actions possibles de gestion (sans le menu)
	PROCEDURE manage_creneaux;
	
	--Permet d’afficher un créneau existant
	PROCEDURE dis_creneau(
	  vheureDebutCreneau IN CHAR
	, vheureFinCreneau IN CHAR);
	
	-- Exécute la procédure d'ajout d'un créneau et gère les erreurs éventuelles.
	PROCEDURE exec_add_creneau(
	  vheureDebutCreneau IN CHAR
	, vheureFinCreneau IN CHAR);
	
	-- Exécute la procédure de mise à jour d'un créneau et gère les erreurs éventuelles
	PROCEDURE exec_upd_creneau(
	  vheureDebutCreneau IN CHAR
	, vheureFinCreneau IN CHAR);
	
	-- Exécute la procédure de suppression d'un créneau et gère les erreurs éventuelles
	PROCEDURE exec_del_creneau(
	  vheureDebutCreneau IN CHAR);
	  
	-- Exécute la procédure d’affichage des créneaux et gère les erreurs éventuelles
	PROCEDURE exec_dis_creneau(
	  vheureDebutCreneau IN CHAR
	, vheureFinCreneau IN CHAR);
	
	-- Affiche le formulaire permettant la saisie d’un nouveau créneau
	PROCEDURE form_add_creneau;
	
	-- Affiche le formulaire de saisie permettant la modification d’un créneau existant
	PROCEDURE form_upd_creneau(
	  vheureDebutCreneau IN CHAR
	, vheureFinCreneau IN CHAR);
	
	-- Fonction permettant d'extraire les heures d'un créneau
	FUNCTION get_heure(
		vcreneau IN CHAR
	)
	RETURN CHAR;
	
	-- Fonction permettant d'extraire les minutes d'un créneau
	FUNCTION get_minute(
		vcreneau IN CHAR
	)
	RETURN CHAR;
	
END pq_ui_creneau;
/