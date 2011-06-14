-- -----------------------------------------------------------------------------
--           Cr�ation du package d'interface d'acc�s � la base de donn�es 
--           pour la table OCCUPER
--                      Oracle Version 10g
--                        (10/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de derni�re modification : 14/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE pq_db_reservation
IS
	--Permet d�ajouter une r�servation
	PROCEDURE add_reservation(
	  vheureDebutCreneau IN OCCUPER.HEURE_DEBUT_CRENEAU%TYPE
	, vnumTerrain IN OCCUPER.NUM_TERRAIN%TYPE
	, vdateOccupation IN OCCUPER.DATE_OCCUPATION%TYPE
	, vnumFacture IN OCCUPER.NUM_FACTURE%TYPE
	, vnumJoueur IN OCCUPER.NUM_JOUEUR%TYPE);

	--Ajouter une personne invit�e � une r�servation
	PROCEDURE add_etre_associe(
	  vheureDebutCreneau IN ETRE_ASSOCIE.HEURE_DEBUT_CRENEAU%TYPE
	, vnumTerrain IN ETRE_ASSOCIE.NUM_TERRAIN%TYPE
	, vdateOccupation IN ETRE_ASSOCIE.DATE_OCCUPATION%TYPE
	, vnumPersonne IN ETRE_ASSOCIE.NUM_PERSONNE%TYPE);

	--Permet de supprimer une reservation existante
	PROCEDURE del_reservation(
	  vheureDebutCreneau IN OCCUPER.HEURE_DEBUT_CRENEAU%TYPE
	, vnumTerrain IN OCCUPER.NUM_TERRAIN%TYPE
	, vdateOccupation IN OCCUPER.DATE_OCCUPATION%TYPE);		

	--Permet de supprimer une personne invit�e � une r�servation
	PROCEDURE del_etre_associe(
	  vheureDebutCreneau IN ETRE_ASSOCIE.HEURE_DEBUT_CRENEAU%TYPE
	, vnumTerrain IN ETRE_ASSOCIE.NUM_TERRAIN%TYPE
	, vdateOccupation IN ETRE_ASSOCIE.DATE_OCCUPATION%TYPE
	, vnumPersonne IN ETRE_ASSOCIE.NUM_PERSONNE%TYPE);
	
END pq_db_reservation;
/