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

CREATE OR REPLACE PACKAGE UI_CRENEAU
IS
	--Permet d’afficher un créneau existant
	PROCEDURE DIS_CRENEAU(
	  vheureDebutCreneau IN CHAR
	, vheureFinCreneau IN CHAR);
	
	-- Exécute la procédure d'ajout d'un créneau et gère les erreurs éventuelles.
	PROCEDURE EXEC_ADD_CRENEAU(
	  vheureDebutCreneau IN CHAR
	, vheureFinCreneau IN CHAR);
	
	-- Exécute la procédure de mise à jour d'un créneau et gère les erreurs éventuelles
	PROCEDURE EXEC_UPD_CRENEAU(
	  vheureDebutCreneau IN CHAR
	, vheureFinCreneau IN CHAR);
	
	-- Exécute la procédure de suppression d'un créneau et gère les erreurs éventuelles
	PROCEDURE EXEC_DEL_CRENEAU(
	  vheureDebutCreneau IN CHAR);
	  
	-- Exécute la procédure d’affichage des créneaux et gère les erreurs éventuelles
	PROCEDURE EXEC_DIS_CRENEAU(
	  vheureDebutCreneau IN CHAR
	, vheureFinCreneau IN CHAR);
	
	-- Affiche le formulaire permettant la saisie d’un nouveau créneau
	PROCEDURE FORM_ADD_CRENEAU;
	
	-- Affiche le formulaire de saisie permettant la modification d’un créneau existant
	PROCEDURE FORM_UPD_CRENEAU(
	  vheureDebutCreneau IN CHAR
	, vheureFinCreneau IN CHAR);
	
END UI_CRENEAU;
/