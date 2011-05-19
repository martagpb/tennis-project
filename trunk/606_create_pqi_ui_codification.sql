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

CREATE OR REPLACE PACKAGE pq_ui_codification
IS
	--Permet d’afficher une codification existante
	PROCEDURE dis_codification(
	  vcode IN CHAR
	, vnature IN VARCHAR2);
	
	-- Exécute la procédure d'ajout d'une codification et gère les erreurs éventuelles
	PROCEDURE exec_add_codification(
	  vcode IN CHAR
	, vnature IN VARCHAR2
	, vlibelle IN VARCHAR2);
	
	-- Exécute la procédure de mise à jour d'une codification et gère les erreurs éventuelles
	PROCEDURE exec_upd_codification(
	  vcode IN CHAR
	, vnature IN VARCHAR2
	, vlibelle IN VARCHAR2);
	
	-- Exécute la procédure de suppression d'une codification et gère les erreurs éventuelles
	PROCEDURE exec_del_codification(
	  vcode IN CHAR
	, vnature IN VARCHAR2);
	
	-- Exécute la procédure d’affichage des codifications et gère les erreurs
	PROCEDURE exec_dis_codification(
	  vcode IN CHAR
	, vnature IN VARCHAR2);
	
	-- Affiche le formulaire permettant la saisie d’une nouvelle codification
	PROCEDURE form_add_codification;
	
	-- Affiche le formulaire de saisie permettant la modification d’une codification
	PROCEDURE form_upd_codification(
	  vcode IN CHAR
	, vnature IN VARCHAR2
	, vlibelle IN VARCHAR2);

END pq_ui_codification;
/