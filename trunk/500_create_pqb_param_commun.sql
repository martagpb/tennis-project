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
	
	-- Fonction permettant de retourner le chemin complet du répertoire contenant les images
	FUNCTION get_rep_img
	RETURN VARCHAR2
	IS
		rep_img VARCHAR2(255) := '/public/img/';
	BEGIN
		RETURN rep_img;
	END;
	
	-- Fonction qui retourne 'oui' ou 'non' à la place des valeurs '1' ou '0'
	FUNCTION dis_number_to_yes_or_not(
	   vvalue in NUMBER)
	RETURN VARCHAR2
	IS
		response VARCHAR2(255) := 'indéterminé';
	BEGIN
		CASE vvalue
			WHEN 0 THEN
				response:= 'non';
			WHEN 1 THEN
				response:= 'oui';
		END CASE;
		RETURN response;
	END;
	
END pq_ui_param_commun;
/