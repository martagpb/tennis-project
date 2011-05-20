-- -----------------------------------------------------------------------------
--  Création du corps du package des méthodes communes et utiles
--  qui ne concernent pas l'affichage de données pour l'utilisateur.
--                      Oracle Version 10g
--                        (14/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 19/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pq_ui_param_commun
AS
		
	-- Fonction permettant de retourner le chemin complet du répertoire CSS
	FUNCTION get_rep_css
	RETURN VARCHAR2
	IS
		rep_css VARCHAR2(255) := '/public/css/';
	BEGIN
		RETURN rep_css;
	END;
	
	-- Fonction permettant de retourner le chemin complet du répertoire JavaScript (JS)
	FUNCTION get_rep_js
	RETURN VARCHAR2
	IS
		rep_js VARCHAR2(255) := '/public/js/';
	BEGIN
		RETURN rep_js;
	END;
	
END pq_ui_param_commun;
/