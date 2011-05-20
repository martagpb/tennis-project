-- -----------------------------------------------------------------------------
--  Création du package d'interface des  méthodes communes et utiles
--  qui ne concernent pas l'affichage de données pour l'utilisateur.
--                      Oracle Version 10g
--                        (14/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 17/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE pq_ui_param_commun
IS

	-- Fonction permettant de retourner le chemin complet du répertoire CSS
	FUNCTION get_rep_css
	RETURN VARCHAR2;	
	
	-- Fonction permettant de retourner le chemin complet du répertoire JavaScript (JS)
	FUNCTION get_rep_js
	RETURN VARCHAR2;	
	
END pq_ui_param_commun;
/