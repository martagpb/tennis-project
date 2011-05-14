-- -----------------------------------------------------------------------------
--           Création du package d'interface d'accès à la base de données 
--           pour la table S_INSCRIRE
--                      Oracle Version 10g
--                        (10/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 14/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE DB_S_INSCRIRE
IS
	--Permet d’ajouter une inscription
	PROCEDURE ADD_INSCRIPTION(
	  vnumEntrainement IN NUMBER
	, vnumPersonne IN NUMBER);
	
	--Permet de modifier une inscription existante
	PROCEDURE UPD_INSCRIPTION(
	  vnumEntrainement IN NUMBER
	, vnumPersonne IN NUMBER);
	
	--Permet de supprimer une inscription existante
	PROCEDURE DEL_INSCRIPTION(
	  vnumEntrainement IN NUMBER
	, vnumPersonne IN NUMBER);
		
END DB_S_INSCRIRE;
/