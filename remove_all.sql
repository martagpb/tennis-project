-- -----------------------------------------------------------------------------
--                Désinstallation complète du projet
--                      Oracle Version 10g
--                        (29/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 04/06/2011
-- -----------------------------------------------------------------------------

connect tennis/tennis
set define off
start delete_tennis_pq_plsql.sql
start delete_data.sql
start drop_index.sql
start drop_structure.sql
--start desinstal_compte.sql (Commentaire à supprimer dès que la suppression des "TABLESPSACES" fonctionnent correctement).



