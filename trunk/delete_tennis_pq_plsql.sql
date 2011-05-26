 -- -----------------------------------------------------------------------------
--           		Désinstallation du projet Tennis
--                      Oracle Version 10g
--                        (26/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 26/05/2011
-- -----------------------------------------------------------------------------



connect nomprojet/nomprojet
set define off
Start 280_drop_sequence.sql
Start 290_drop_table_cascade.sql
Start 291_purge_reyclebin.sql
-- drop package