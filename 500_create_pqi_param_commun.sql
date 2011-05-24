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
	
	-- Fonction permettant de retourner le chemin complet du répertoire contenant les images
	FUNCTION get_rep_img
	RETURN VARCHAR2;	
			
	-- Fonction qui retourne 'oui' ou 'non' à la place des valeurs '1' ou '0'
	FUNCTION dis_number_to_yes_or_not(
	   vvalue in NUMBER)
	RETURN VARCHAR2;
	
END pq_ui_param_commun;
/