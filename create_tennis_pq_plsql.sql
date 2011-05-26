-- -----------------------------------------------------------------------------
--           		Installation du projet Tennis
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
Start 200_create_table.sql
Start 210_create_pk.sql
Start 220_create_fk.sql
Start 400_create_index.sql
Start 300_insert_data.sql
