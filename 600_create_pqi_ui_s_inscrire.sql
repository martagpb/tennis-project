-- -----------------------------------------------------------------------------
--           Création du package d'interface d'affichage des données
--           pour la table S_INSCRIRE
--                      Oracle Version 10g
--                        (10/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 14/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE UI_S_INSCRIRE
IS
	--Permet d’afficher une inscription existante
	PROCEDURE DIS_INSCRIPTION(
	  vnumEntrainement IN NUMBER
	, vnumPersonne IN NUMBER);
	
	-- Exécute la procédure d'ajout d'une inscription et gère les erreurs éventuelles.
	PROCEDURE EXEC_ADD_INSCRIPTION(
	  vnumEntrainement IN NUMBER
	, vnumPersonne IN NUMBER);
	
	-- Exécute la procédure de mise à jour d'une inscription et gère les erreurs éventuelles
	PROCEDURE EXEC_UPD_INSCRIPTION(
	  vnumEntrainement IN NUMBER
	, vnumPersonne IN NUMBER);
	
	-- Exécute la procédure de suppression d'une inscription et gère les erreurs éventuelles
	PROCEDURE EXEC_DEL_INSCRIPTION(
	  vnumEntrainement IN NUMBER
	, vnumPersonne IN NUMBER);
	
	-- Exécute la procédure d’affichage des inscriptions et gère les erreurs éventuelles
	PROCEDURE EXEC_DIS_INSCRIPTION(
	  vnumEntrainement IN NUMBER
	, vnumPersonne IN NUMBER);
	
	-- Affiche le formulaire permettant la saisie d’une nouvelle inscription
	PROCEDURE FORM_ADD_INSCRIPTION;
	
	-- Affiche le formulaire de saisie permettant la modification d’une inscription existante
	PROCEDURE FORM_UPD_INSCRIPTION(
	  vnumEntrainement IN NUMBER
	, vnumPersonne IN NUMBER);
				
END UI_S_INSCRIRE;
/