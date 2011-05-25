        -- -----------------------------------------------------------------------------
--            Analyse de la structure de la base de données pour
--                      Oracle Version 10g
--                        (10/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 10/5/2011
-- -----------------------------------------------------------------------------
 


ANALYZE TABLE FACTURE VALIDATE STRUCTURE CASCADE;

ANALYZE TABLE CRENEAU VALIDATE STRUCTURE CASCADE;

ANALYZE TABLE TERRAIN VALIDATE STRUCTURE CASCADE;

ANALYZE TABLE ENTRAINEMENT VALIDATE STRUCTURE CASCADE;

ANALYZE TABLE MENSUALITE VALIDATE STRUCTURE CASCADE;

ANALYZE TABLE ABONNEMENT VALIDATE STRUCTURE CASCADE;

ANALYZE TABLE ETRE_AFFECTE VALIDATE STRUCTURE CASCADE;

ANALYZE TABLE ETRE_ASSOCIE VALIDATE STRUCTURE CASCADE;

ANALYZE TABLE S_INSCRIRE VALIDATE STRUCTURE CASCADE;

ANALYZE TABLE AVOIR_LIEU VALIDATE STRUCTURE CASCADE;

ANALYZE TABLE PERSONNE VALIDATE STRUCTURE CASCADE;

ANALYZE TABLE CODIFICATION VALIDATE STRUCTURE CASCADE;

ANALYZE TABLE OCCUPER VALIDATE STRUCTURE CASCADE;