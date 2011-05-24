-- -----------------------------------------------------------------------------
--  Création du package d'interface des  méthodes communes
--  qui permettent l'affichage de données pour l'utilisateur.
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
	
	-- Affiche le détail d'une erreur personnalisée
	PROCEDURE dis_error_custom(
	  vtitre in varchar2
	, vexplicationerreur in varchar2
	, vconseilerreur in varchar2
	, vlienretour  in varchar2
	, vlibellelien in varchar2);	
	
	PROCEDURE aff_header(niveau IN NUMBER, permission OUT BOOLEAN);
	PROCEDURE aff_menu(niveau IN NUMBER);
	PROCEDURE aff_menu_niveau1;
	PROCEDURE aff_menu_niveau2;
	PROCEDURE aff_menu_niveau3;
	PROCEDURE aff_footer;
	PROCEDURE  aff_accueil;
	PROCEDURE deconnect;
		
END pq_ui_commun;
/