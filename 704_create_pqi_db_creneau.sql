-- -----------------------------------------------------------------------------
--           Création du package d'interface d'accès à la base de données 
--           pour la table CRENEAU
--                      Oracle Version 10g
--                        (14/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 14/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE pq_db_creneau
IS
	--Permet d’ajouter un créneau
	PROCEDURE add_creneau(
	  vheureDebutCreneau IN CRENEAU.HEURE_DEBUT_CRENEAU%TYPE
	, vheureFinCreneau IN CRENEAU.HEURE_FIN_CRENEAU%TYPE);
	
	--Permet de modifier un créneau existant
	PROCEDURE upd_creneau(
	  vheureDebutCreneau IN CRENEAU.HEURE_DEBUT_CRENEAU%TYPE
	, vheureFinCreneau IN CRENEAU.HEURE_FIN_CRENEAU%TYPE);
	
	--Permet de supprimer un créneau existant
	PROCEDURE del_creneau(
	  vheureDebutCreneau IN CRENEAU.HEURE_DEBUT_CRENEAU%TYPE);
	
END pq_db_creneau;
/