-- -----------------------------------------------------------------------------
--           Création du package d'interface d'affichage des données
--           pour la table CODIFICATION
--                      Oracle Version 10g
--                        (14/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 14/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE UI_CODIFICATION
IS
	--Permet d’afficher une codification existante
	PROCEDURE DIS_CODIFICATION(
	  vcode IN CHAR
	, vnature IN VARCHAR2);
	
	-- Exécute la procédure d'ajout d'une codification et gère les erreurs éventuelles
	PROCEDURE EXEC_ADD_CODIFICATION(
	  vcode IN CHAR
	, vnature IN VARCHAR2
	, vlibelle IN VARCHAR2);
	
	-- Exécute la procédure de mise à jour d'une codification et gère les erreurs éventuelles
	PROCEDURE EXEC_UPD_CODIFICATION(
	  vcode IN CHAR
	, vnature IN VARCHAR2
	, vlibelle IN VARCHAR2);
	
	-- Exécute la procédure de suppression d'une codification et gère les erreurs éventuelles
	PROCEDURE EXEC_DEL_CODIFICATION(
	  vcode IN CHAR
	, vnature IN VARCHAR2);
	
	-- Exécute la procédure d’affichage des codifications et gère les erreurs
	PROCEDURE EXEC_DIS_CODIFICATION(
	  vcode IN CHAR
	, vnature IN VARCHAR2);
	
	-- Affiche le formulaire permettant la saisie d’une nouvelle codification
	PROCEDURE FORM_ADD_CODIFICATION;
	
	-- Affiche le formulaire de saisie permettant la modification d’une codification
	PROCEDURE FORM_UPD_CODIFICATION(
	  vcode IN CHAR
	, vnature IN VARCHAR2
	, vlibelle IN VARCHAR2);

END UI_CODIFICATION;
/