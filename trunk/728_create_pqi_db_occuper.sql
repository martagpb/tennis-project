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
	  vheureDebutCreneau IN CHAR
	, vnumTerrain IN NUMBER
	, vdateOccupation IN DATE
	, vnumFacture IN NUMBER
	, vnumJoueur IN NUMBER);
	
	--Permet d’ajouter une séance
	PROCEDURE add_seance(
	  vheureDebutCreneau IN CHAR
	, vnumTerrain IN NUMBER
	, vdateOccupation IN DATE
	, vnumEntrainement IN NUMBER
	, vnumSeance IN NUMBER);
	
	--Permet d’ajouter une occupation simple
	PROCEDURE add_occupation(
	  vheureDebutCreneau IN CHAR
	, vnumTerrain IN NUMBER
	, vdateOccupation IN DATE);
	
	--Permet de modifier un entrainement existant
	PROCEDURE upd_occupation(
	  vheureDebutCreneau IN CHAR
	, vnumTerrain IN NUMBER
	, vdateOccupation IN DATE
	, vnumFacture IN NUMBER
	, vnumJoueur IN NUMBER
	, vnumEntrainement IN NUMBER
	, vnumSeance IN NUMBER);
	
	--Permet de supprimer une occupation existante
	PROCEDURE del_occupation(
	  vheureDebutCreneau IN CHAR
	, vnumTerrain IN NUMBER
	, vdateOccupation IN DATE);
	
	--Permet de supprimer une séance au dessus d'une date date donnée
	PROCEDURE del_seance(
	  vheureDebutCreneau IN CHAR
	, vnumTerrain IN NUMBER
	, vdateOccupation IN DATE
	, vnumEntrainement IN NUMBER);
	  
		
END pq_db_occuper;
/