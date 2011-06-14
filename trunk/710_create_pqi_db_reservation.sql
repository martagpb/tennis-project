-- -----------------------------------------------------------------------------
--           Création du package d'interface d'accès à la base de données 
--           pour la table OCCUPER
--                      Oracle Version 10g
--                        (10/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 14/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE pq_db_reservation
IS

	--Permet d’ajouter une réservation
	PROCEDURE add_reservation(
	  pnumTerrain IN OCCUPER.NUM_TERRAIN%TYPE
	, pdate IN OCCUPER.DATE_OCCUPATION%TYPE
	, pheure IN OCCUPER.HEURE_DEBUT_CRENEAU%TYPE
	, pnumJoueur IN OCCUPER.NUM_JOUEUR%TYPE);
	
	--Permet d’ajouter une réservation
	PROCEDURE add_reservation(
	  pnumTerrain IN OCCUPER.NUM_TERRAIN%TYPE
	, pdateOccupation IN OCCUPER.DATE_OCCUPATION%TYPE
	, pheureDebutCreneau IN OCCUPER.HEURE_DEBUT_CRENEAU%TYPE
	, pnumFacture IN OCCUPER.NUM_FACTURE%TYPE
	, pnumJoueur IN OCCUPER.NUM_JOUEUR%TYPE);

	--	Met à jour une réservation
	PROCEDURE upd_reservation(
	  pnumTerrain IN OCCUPER.NUM_TERRAIN%TYPE
	, pdate IN OCCUPER.DATE_OCCUPATION%TYPE
	, pheure IN OCCUPER.HEURE_DEBUT_CRENEAU%TYPE
	, pnumJoueur IN OCCUPER.NUM_JOUEUR%TYPE);
	
	--Permet de supprimer une reservation existante
	PROCEDURE del_reservation(
	  vnumTerrain IN OCCUPER.NUM_TERRAIN%TYPE
	, vdateOccupation IN OCCUPER.DATE_OCCUPATION%TYPE
	, vheureDebutCreneau IN OCCUPER.HEURE_DEBUT_CRENEAU%TYPE);		

	--Ajouter une personne invitée à une réservation
	PROCEDURE add_etre_associe(
	  vheureDebutCreneau IN ETRE_ASSOCIE.HEURE_DEBUT_CRENEAU%TYPE
	, vnumTerrain IN ETRE_ASSOCIE.NUM_TERRAIN%TYPE
	, vdateOccupation IN ETRE_ASSOCIE.DATE_OCCUPATION%TYPE
	, vnumPersonne IN ETRE_ASSOCIE.NUM_PERSONNE%TYPE);

	--Permet de supprimer une personne invitée à une réservation
	PROCEDURE del_etre_associe(
	  vheureDebutCreneau IN ETRE_ASSOCIE.HEURE_DEBUT_CRENEAU%TYPE
	, vnumTerrain IN ETRE_ASSOCIE.NUM_TERRAIN%TYPE
	, vdateOccupation IN ETRE_ASSOCIE.DATE_OCCUPATION%TYPE
	, vnumPersonne IN ETRE_ASSOCIE.NUM_PERSONNE%TYPE);
	
END pq_db_reservation;
/