-- -----------------------------------------------------------------------------
--                Installation complète du projet
--                      Oracle Version 10g
--                        (29/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 04/06/2011
-- -----------------------------------------------------------------------------

connect system/manager
start instal_compte.sql

start 102_connect_schema.sql
set define off
start drop_structure.sql
start create_structure.sql
start create_index.sql
start insert_data.sql
start create_tennis_pq_plsql.sql
