         -- -----------------------------------------------------------------------------
--            Re-fabrication des index de la base de données pour
--                      Oracle Version 10g
--                        (10/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 10/5/2011
-- -----------------------------------------------------------------------------
 
 


ALTER INDEX I_FK_PERSONNE_CODIFICATION rebuild;

ALTER INDEX I_FK_PERSONNE_CODIFICATION2 rebuild;

ALTER INDEX I_FK_TERRAIN_CODIFICATION rebuild;

ALTER INDEX I_FK_ENTRAINEMENT_CODIFICATION rebuild;

ALTER INDEX I_FK_ENTRAINEMENT_PERSONNE rebuild;

ALTER INDEX I_FK_MENSUALITE_ABONNEMENT rebuild;

ALTER INDEX I_FK_ABONNEMENT_PERSONNE rebuild;

ALTER INDEX I_FK_AVOIR_LIEU_ENTRAINEMENT rebuild;

ALTER INDEX I_FK_AVOIR_LIEU_CRENEAU rebuild;

ALTER INDEX I_FK_AVOIR_LIEU_TERRAIN rebuild;

ALTER INDEX I_FK_OCCUPER_CRENEAU rebuild;

ALTER INDEX I_FK_OCCUPER_TERRAIN rebuild;

ALTER INDEX I_FK_OCCUPER_FACTURE rebuild;

ALTER INDEX I_FK_OCCUPER_PERSONNE rebuild;

ALTER INDEX I_FK_OCCUPER_ENTRAINEMENT rebuild;
