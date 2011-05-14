         -- -----------------------------------------------------------------------------
--            Suppression des index de la base de données pour
--                      Oracle Version 10g
--                        (10/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 10/5/2011
-- -----------------------------------------------------------------------------
 
 
 
 
 
DROP INDEX I_FK_PERSONNE_CODIFICATION;

DROP INDEX I_FK_PERSONNE_CODIFICATION2;

DROP INDEX I_FK_TERRAIN_CODIFICATION;

DROP INDEX I_FK_ENTRAINEMENT_CODIFICATION;

DROP INDEX I_FK_ENTRAINEMENT_PERSONNE;

DROP INDEX I_FK_MENSUALITE_ABONNEMENT;

DROP INDEX I_FK_ABONNEMENT_PERSONNE;

DROP INDEX I_FK_AVOIR_LIEU_ENTRAINEMENT;

DROP INDEX I_FK_AVOIR_LIEU_CRENEAU;

DROP INDEX I_FK_AVOIR_LIEU_TERRAIN;

DROP INDEX I_FK_OCCUPER_CRENEAU;

DROP INDEX I_FK_OCCUPER_TERRAIN;

DROP INDEX I_FK_OCCUPER_FACTURE;

DROP INDEX I_FK_OCCUPER_PERSONNE;

DROP INDEX I_FK_OCCUPER_ENTRAINEMENT;

DROP INDEX I_FK_ETRE_ASSOCIE_PERSONNE;

DROP  INDEX I_FK_ETRE_ASSOCIE_OCCUPER;
	
