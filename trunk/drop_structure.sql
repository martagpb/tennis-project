-- -----------------------------------------------------------------------------
--         Création de la structure de la base de données
--                      Oracle Version 10g
--                        (29/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 29/05/2011
-- -----------------------------------------------------------------------------

connect tennis/tennis
set define off
start 290_drop_table_cascade.sql
start 280_drop_sequence.sql
start 291_purge_reyclebin.sql
