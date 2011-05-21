-- -----------------------------------------------------------------------------
--  Cr�ation du package d'interface des  m�thodes communes
--  qui permettent l'affichage de donn�es pour l'utilisateur.
--                      Oracle Version 10g
--                        (14/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de derni�re modification : 17/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE pq_ui_commun
IS
	-- Affiche le d�tail d'une erreur oracle
	PROCEDURE dis_error(
	  vnumero in varchar2
	, vliberreur in varchar2
	, vactionencours in varchar2);	
	
	PROCEDURE aff_header(niveau IN NUMBER);
	PROCEDURE aff_menu(niveau IN NUMBER);
	PROCEDURE aff_menu_niveau1;
	PROCEDURE aff_menu_niveau2;
	PROCEDURE aff_menu_niveau3;
	PROCEDURE aff_footer;
		
END pq_ui_commun;
/