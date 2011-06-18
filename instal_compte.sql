-- -----------------------------------------------------------------------------
--           		Installation du compte du projet
--                      Oracle Version 10g
--                        (29/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 29/05/2011
-- -----------------------------------------------------------------------------

connect SYSTEM/MANAGER
set define off
start 100_create_schema.sql
start 101_grant_schema.sql
