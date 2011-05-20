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

CREATE OR REPLACE PACKAGE pq_ui_s_inscrire
IS
	--Permet d’afficher une inscription existante
	PROCEDURE dis_inscription(
	  vnumEntrainement IN NUMBER
	, vnumPersonne IN NUMBER);
	
	-- Exécute la procédure d'ajout d'une inscription et gère les erreurs éventuelles.
	PROCEDURE exec_add_inscription(
	  vnumEntrainement IN NUMBER
	, vnumPersonne IN NUMBER);
	
	-- Exécute la procédure de mise à jour d'une inscription et gère les erreurs éventuelles
	PROCEDURE exec_upd_inscription(
	  vnumEntrainement IN NUMBER
	, vnumPersonne IN NUMBER);
	
	-- Exécute la procédure de suppression d'une inscription et gère les erreurs éventuelles
	PROCEDURE exec_del_inscription(
	  vnumEntrainement IN NUMBER
	, vnumPersonne IN NUMBER);
	
	-- Exécute la procédure d’affichage des inscriptions et gère les erreurs éventuelles
	PROCEDURE exec_dis_inscription(
	  vnumEntrainement IN NUMBER
	, vnumPersonne IN NUMBER);
	
	-- Affiche le formulaire permettant la saisie d’une nouvelle inscription
	PROCEDURE form_add_inscription;
	
	-- Affiche le formulaire de saisie permettant la modification d’une inscription existante
	PROCEDURE form_upd_inscription(
	  vnumEntrainement IN NUMBER
	, vnumPersonne IN NUMBER);
				
END pq_ui_s_inscrire;
/