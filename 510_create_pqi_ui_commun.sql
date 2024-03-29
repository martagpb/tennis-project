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
	
	-- Affiche le d�tail d'une erreur personnalis�e
	PROCEDURE dis_error_custom(
	  vtitre in varchar2
	, vexplicationerreur in varchar2
	, vconseilerreur in varchar2
	, vlienretour  in varchar2
	, vlibellelien in varchar2);	
	
	--Permet d'afficher une erreur personnalis�e lors que l'utilisateur n'a pas les droits d'acc�s pour une page.
	PROCEDURE dis_error_permission_denied;
	
	PROCEDURE aff_header;
	PROCEDURE header;
	PROCEDURE aff_menu(niveau IN NUMBER);
	PROCEDURE aff_menu_niveau_entraineur;
	PROCEDURE aff_menu_niveau_agent_accueil;
	PROCEDURE aff_menu_niveau_administrateur;
	PROCEDURE aff_menu_niveau_autre;
	PROCEDURE aff_footer;
	PROCEDURE deconnect;
	PROCEDURE isAuthorized(niveauP IN NUMBER, permission OUT BOOLEAN);
	PROCEDURE getNiveau(niveau OUT PERSONNE.NIVEAU_DROIT%TYPE);
		
END pq_ui_commun;
/

