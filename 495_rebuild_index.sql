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
 
 




DROP INDEX I_FK_PERSONNE_CODIFICATION rebuild;

DROP INDEX I_FK_PERSONNE_CODIFICATION2 rebuild;

DROP INDEX I_FK_TERRAIN_CODIFICATION rebuild;

DROP INDEX I_FK_ENTRAINEMENT_CODIFICATION rebuild;

DROP INDEX I_FK_ENTRAINEMENT_PERSONNE rebuild;

DROP INDEX I_FK_MENSUALITE_ABONNEMENT rebuild;

DROP INDEX I_FK_OCCUPATION_FACTURE rebuild;

DROP INDEX I_FK_OCCUPATION_CRENEAU rebuild;

DROP INDEX I_FK_OCCUPATION_PERSONNE rebuild;

DROP INDEX I_FK_OCCUPATION_ENTRAINEMENT rebuild;

DROP INDEX I_FK_ABONNEMENT_PERSONNE rebuild;

DROP INDEX I_FK_AVOIR_LIEU_ENTRAINEMENT rebuild;

DROP INDEX I_FK_AVOIR_LIEU_CRENEAU rebuild;

DROP INDEX I_FK_AVOIR_LIEU_TERRAIN rebuild;

DROP INDEX I_FK_OCCUPER_CRENEAU rebuild;

DROP INDEX I_FK_OCCUPER_TERRAIN rebuild;

DROP INDEX I_FK_OCCUPER_OCCUPATION rebuild;