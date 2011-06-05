 -- -----------------------------------------------------------------------------
--            Suppression de tous les packages du projet Tennis
--                      Oracle Version 10g
--                        (26/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 26/05/2011
-- -----------------------------------------------------------------------------

connect tennis/tennis
set define off
start 690_drop_pq_ui;
start 790_drop_pq_db;