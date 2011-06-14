-- -----------------------------------------------------------------------------
--          Cr�ation de tous les packages de l'application
--                      Oracle Version 10g
--                        (29/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de derni�re modification : 29/05/2011
-- -----------------------------------------------------------------------------

connect tennis/tennis
set define off
start 510_create_pqi_ui_commun.sql
SHOW ERRORS
start 500_create_pqi_param_commun.sql
SHOW ERRORS
start 702_create_pqi_db_codification.sql
SHOW ERRORS
start 702_create_pqb_db_codification.sql
SHOW ERRORS
start 726_create_pqi_db_personne.sql
SHOW ERRORS
start 726_create_pqb_db_personne.sql
SHOW ERRORS
start 626_create_pqi_ui_personne.sql
SHOW ERRORS
start 626_create_pqb_ui_personne.sql
SHOW ERRORS
start 620_create_pqi_ui_create_account.sql
SHOW ERRORS
start 628_create_pqi_ui_mon_compte.sql
SHOW ERRORS
start 628_create_pqb_ui_mon_compte.sql
SHOW ERRORS
start 601_create_pqi_ui_accueil.sql
SHOW ERRORS
start 600_create_pqi_ui_login.sql
SHOW ERRORS
start 510_create_pqb_ui_commun.sql
SHOW ERRORS
start 500_create_pqb_param_commun.sql
SHOW ERRORS
start 600_create_pqb_ui_login.sql
SHOW ERRORS
start 704_create_pqi_db_creneau.sql
SHOW ERRORS
start 704_create_pqb_db_creneau.sql
SHOW ERRORS
start 706_create_pqi_db_facture.sql
SHOW ERRORS
start 706_create_pqb_db_facture.sql
SHOW ERRORS
start 708_create_pqi_db_terrain.sql
SHOW ERRORS
start 708_create_pqb_db_terrain.sql
SHOW ERRORS
start 712_create_pqi_db_entrainement.sql
SHOW ERRORS
start 712_create_pqb_db_entrainement.sql
SHOW ERRORS
start 714_create_pqi_db_abonnement.sql
SHOW ERRORS
start 714_create_pqb_db_abonnement.sql
SHOW ERRORS
start 728_create_pqi_db_occuper.sql
SHOW ERRORS
start 728_create_pqb_db_occuper.sql
SHOW ERRORS 
start 722_create_pqi_db_avoir_lieu.sql
SHOW ERRORS
start 722_create_pqb_db_avoir_lieu.sql
SHOW ERRORS
start 724_create_pqi_db_s_inscrire.sql
SHOW ERRORS
start 724_create_pqb_db_s_inscrire.sql
SHOW ERRORS
start 602_create_pqi_ui_codification.sql
SHOW ERRORS
start 601_create_pqb_ui_accueil.sql
SHOW ERRORS
start 602_create_pqb_ui_codification.sql
SHOW ERRORS
start 604_create_pqi_ui_creneau.sql
SHOW ERRORS
start 604_create_pqb_ui_creneau.sql
SHOW ERRORS
start 606_create_pqi_ui_facture.sql
SHOW ERRORS
start 606_create_pqb_ui_facture.sql
SHOW ERRORS
start 608_create_pqi_ui_terrain.sql
SHOW ERRORS
start 608_create_pqb_ui_terrain.sql
SHOW ERRORS
start 624_create_pqi_ui_s_inscrire.sql
SHOW ERRORS
start 624_create_pqb_ui_s_inscrire.sql
SHOW ERRORS
start 612_create_pqi_ui_entrainement.sql
SHOW ERRORS
start 612_create_pqb_ui_entrainement.sql
SHOW ERRORS
start 613_create_pqi_ui_entrainement_entraineur.sql
SHOW ERRORS
start 613_create_pqb_ui_entrainement_entraineur.sql
SHOW ERRORS
start 614_create_pqi_ui_abonnement.sql
SHOW ERRORS
start 614_create_pqb_ui_abonnement.sql
SHOW ERRORS
start 620_create_pqb_ui_create_account.sql
SHOW ERRORS
start 622_create_pqi_ui_avoir_lieu.sql
SHOW ERRORS
start 622_create_pqb_ui_avoir_lieu.sql
SHOW ERRORS