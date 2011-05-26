-- -----------------------------------------------------------------------------
--           Création du package d'interface d'accès à la base de données 
--           pour la table ABONNEMENT
--                      Oracle Version 10g
--                        (25/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 25/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE pq_db_abonnement
IS
	--Permet d’ajouter un abonnement
	PROCEDURE add_abonnement(
	  pnumJoueur IN ABONNEMENT.NUM_JOUEUR%TYPE
	, pdateDebut IN ABONNEMENT.DATE_DEBUT_ABONNEMENT%TYPE
	, pduree IN ABONNEMENT.DUREE_ABONNEMENT%TYPE);
	
	--Permet de modifier un abonnement existant
	PROCEDURE upd_abonnement(
	  pnumAbonnement IN ABONNEMENT.NUM_ABONNEMENT%TYPE
	, pnumJoueur IN ABONNEMENT.NUM_JOUEUR%TYPE
	, pdateDebut IN ABONNEMENT.DATE_DEBUT_ABONNEMENT%TYPE
	, pduree IN ABONNEMENT.DUREE_ABONNEMENT%TYPE);
	
	--Permet de supprimer un abonnement existant
	PROCEDURE del_abonnement(
	  pnumAbonnement IN ABONNEMENT.NUM_ABONNEMENT%TYPE);
	
END pq_db_abonnement;
/