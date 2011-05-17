-- -----------------------------------------------------------------------------
--           Création du package d'interface d'affichage des données
--           qui sont communes à plusieurs tables
--                      Oracle Version 10g
--                        (14/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 17/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE pq_ui_commun
IS
	-- Affiche le détail d'une erreur oracle
	PROCEDURE dis_error(
	  vnumero in varchar2
	, vliberreur in varchar2
	, vactionencours in varchar2);	
	
	-- Fonction permettant de retourner le chemin complet du répertoire CSS
	FUNCTION get_rep_css
	RETURN VARCHAR2;	
	
	-- Fonction permettant de retourner le chemin complet du répertoire JavaScript (JS)
	FUNCTION get_rep_js
	RETURN VARCHAR2;	
	
END pq_ui_commun;
/