-- -----------------------------------------------------------------------------
--         Cr�ation de la structure de la base de donn�es
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
start 200_create_table.sql
start 210_create_pk.sql
start 220_create_fk.sql
start 240_create_sequence.sql
start 250_create_trigger.sql
