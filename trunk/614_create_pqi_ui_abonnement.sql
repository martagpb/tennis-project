-- -----------------------------------------------------------------------------
--           Création du package d'interface d'affichage des données
--           pour la table ABONNEMENT
--                      Oracle Version 10g
--                        (25/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 25/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE pq_ui_abonnement
IS
	--Permet d'afficher tous les abonnements et les actions possibles de gestion (avec le menu)
	PROCEDURE manage_abonnements;
	
	--Permet d’afficher un abonnement existant
	PROCEDURE dis_abonnement(
	  pnumAbonnement IN VARCHAR2
	);
	
	-- Affiche le formulaire permettant la saisie d’un nouvel abonnement
	PROCEDURE form_add_abonnement;
	
	-- Exécute la procédure d'ajout d'un abonnement et gère les erreurs éventuelles.
	PROCEDURE exec_add_abonnement(
	  pnumJoueur IN VARCHAR2
	, pdateDebut IN VARCHAR2
	, pduree IN VARCHAR2);
	
	-- Exécute la procédure de suppression d'un abonnement et gère les erreurs éventuelles
	PROCEDURE exec_del_abonnement(
	  pnumAbonnement IN VARCHAR2);

END pq_ui_abonnement;
/