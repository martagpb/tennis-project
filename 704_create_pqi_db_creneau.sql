-- -----------------------------------------------------------------------------
--           Cr�ation du package d'interface d'acc�s � la base de donn�es 
--           pour la table CRENEAU
--                      Oracle Version 10g
--                        (14/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de derni�re modification : 14/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE pq_db_creneau
IS
	--Permet d�ajouter un cr�neau
	PROCEDURE add_creneau(
	  vheureDebutCreneau IN CRENEAU.HEURE_DEBUT_CRENEAU%TYPE
	, vheureFinCreneau IN CRENEAU.HEURE_FIN_CRENEAU%TYPE);
	
	--Permet de modifier un cr�neau existant
	PROCEDURE upd_creneau(
	  vheureDebutCreneau IN CRENEAU.HEURE_DEBUT_CRENEAU%TYPE
	, vheureFinCreneau IN CRENEAU.HEURE_FIN_CRENEAU%TYPE);
	
	--Permet de supprimer un cr�neau existant
	PROCEDURE del_creneau(
	  vheureDebutCreneau IN CRENEAU.HEURE_DEBUT_CRENEAU%TYPE);
	
END pq_db_creneau;
/