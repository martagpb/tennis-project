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
	  vheureDebutCreneau IN CHAR
	, vheureFinCreneau IN CHAR);
	
	--Permet de modifier un créneau existant
	PROCEDURE upd_creneau(
	  vheureDebutCreneau IN CHAR
	, vheureFinCreneau IN CHAR);
	
	--Permet de supprimer un créneau existant
	PROCEDURE del_creneau(
	  vheureDebutCreneau IN CHAR);
	
END pq_db_creneau;
/