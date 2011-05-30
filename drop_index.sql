-- -----------------------------------------------------------------------------
--          Suppression des index pour la base de données
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
start 490_drop_index.sql