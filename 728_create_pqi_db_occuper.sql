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

CREATE OR REPLACE PACKAGE pq_db_occuper
IS
	--Permet d’ajouter une réservation
	PROCEDURE add_reservation(
	  vheureDebutCreneau IN OCCUPER.HEURE_DEBUT_CRENEAU%TYPE
	, vnumTerrain IN OCCUPER.NUM_TERRAIN%TYPE
	, vdateOccupation IN OCCUPER.DATE_OCCUPATION%TYPE
	, vnumFacture IN OCCUPER.NUM_FACTURE%TYPE
	, vnumJoueur IN OCCUPER.NUM_JOUEUR%TYPE);
	
	--Permet d’ajouter une séance
	PROCEDURE add_seance(
	  vheureDebutCreneau IN OCCUPER.HEURE_DEBUT_CRENEAU%TYPE
	, vnumTerrain IN OCCUPER.NUM_TERRAIN%TYPE
	, vdateOccupation IN OCCUPER.DATE_OCCUPATION%TYPE
	, vnumEntrainement IN OCCUPER.NUM_ENTRAINEMENT%TYPE
	, vnumSeance IN OCCUPER.NUM_SEANCE%TYPE);
	
	--Permet d’ajouter une occupation simple
	PROCEDURE add_occupation(
	  vheureDebutCreneau IN OCCUPER.HEURE_DEBUT_CRENEAU%TYPE
	, vnumTerrain IN OCCUPER.NUM_TERRAIN%TYPE
	, vdateOccupation IN OCCUPER.DATE_OCCUPATION%TYPE);
	
	--Permet de modifier un entrainement existant
	PROCEDURE upd_occupation(
	  vheureDebutCreneau IN OCCUPER.HEURE_DEBUT_CRENEAU%TYPE
	, vnumTerrain IN OCCUPER.NUM_TERRAIN%TYPE
	, vdateOccupation IN OCCUPER.DATE_OCCUPATION%TYPE
	, vnumFacture IN OCCUPER.NUM_FACTURE%TYPE
	, vnumJoueur IN OCCUPER.NUM_JOUEUR%TYPE
	, vnumEntrainement IN OCCUPER.NUM_ENTRAINEMENT%TYPE
	, vnumSeance IN OCCUPER.NUM_SEANCE%TYPE);
	
	--Permet de supprimer une occupation existante
	PROCEDURE del_occupation(
	  vheureDebutCreneau IN OCCUPER.HEURE_DEBUT_CRENEAU%TYPE
	, vnumTerrain IN OCCUPER.NUM_TERRAIN%TYPE
	, vdateOccupation IN OCCUPER.DATE_OCCUPATION%TYPE);
	
	--Permet de supprimer une séance au dessus d'une date date donnée
	PROCEDURE del_seance(
	  vheureDebutCreneau IN OCCUPER.HEURE_DEBUT_CRENEAU%TYPE
	, vnumTerrain IN OCCUPER.NUM_TERRAIN%TYPE
	, vdateOccupation IN OCCUPER.DATE_OCCUPATION%TYPE
	, vnumEntrainement IN OCCUPER.NUM_ENTRAINEMENT%TYPE);
		
END pq_db_occuper;
/