-- -----------------------------------------------------------------------------
--      Cr�ation du corps du package pq_ui_commun de la base de donn�es pour
--                      Oracle Version 10g
--                        (10/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de derni�re modification : 18/5/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pq_ui_commun
IS
	---Proc�dure permettant d'afficher les d�tails d'une erreur d'oracle
	PROCEDURE dis_error(
	  vnumero in varchar2
	, vliberreur in varchar2
	, vactionencours in varchar2)
	IS
	begin
		--pq_ui_commun.aff_header;
			--htp.print('D�tails sur l''erreur d''oracle');
			--htp.br;
			htp.br;
			htp.tableopen;
				htp.tablerowopen;
					htp.tabledata('N� :', cattributes => 'class="enteteFormulaire"');
					htp.tabledata(vnumero);
				htp.tablerowclose;
				htp.tablerowopen;
					htp.tabledata('Description :', cattributes => 'class="enteteFormulaire"');
					htp.tabledata(vliberreur);
				htp.tablerowclose;
				htp.tablerowopen;
					htp.tabledata('Action en cours :', cattributes => 'class="enteteFormulaire"');
					htp.tabledata(vactionencours);
				htp.tablerowclose;
			htp.tableclose;
			htp.br;
			--htp.br;
			--htp.anchor('pq_ui_login.login', 'Retourner � la page d''authentification');
		--pq_ui_commun.aff_footer;
	END;


	-- Affiche le d�tail d'une erreur personnalis�e
	PROCEDURE dis_error_custom(
	  vtitre in varchar2
	, vexplicationerreur in varchar2
	, vconseilerreur in varchar2
	, vlienretour  in varchar2
	, vlibellelien in varchar2)
	IS
	begin
			htp.br;
			htp.print('<div class="error_custom"> ');
				htp.print(vtitre);
			htp.print('</div>');
			htp.br;
			htp.print('Explication : ' || vexplicationerreur);
			htp.br;
			htp.br;
			htp.print('Conseil : ' || vconseilerreur);
			htp.br;
			htp.br;
			htp.anchor(vlienretour, vlibellelien);
		pq_ui_commun.aff_footer;
	END;
	
	--Permet d'afficher une erreur personnalis�e lors que l'utilisateur n'a pas les droits d'acc�s pour une page.
	PROCEDURE dis_error_permission_denied
	IS
	BEGIN
		pq_ui_commun.aff_header;
		pq_ui_commun.dis_error_custom('Acc�s refus� pour la page demand�e','Vous n''avez pas les droits n�cessaires pour acc�der � la page demand�e.','Connectez-vous avec un autre compte ou contactez votre administrateur pour obtenir les droits n�cessaires.','pq_ui_accueil.dis_accueil', 'Retourner � l''accueil');
	END;
		
	--Proc�dure permettant de d�terminer si une personne est autoris�e � acc�der � une page donn�e en retourner une valeur bool�enne
		-- NiveauP : correspond au niveau de droit de la page
		-- permission : contient la valeur bool�enne retourn�e
		-- Retourne : 
			-- true  : si la personne est autoris�e
			-- false : si la personne n'est pas autoris�e
	--Rappel du tableau des droits : (Oui = acc�s autoris� et Non = acc�s refus�)
		--Num�ro | Entraineur | Agent d�accueil | Administrateur
		--  0    |     Oui    |        Oui      |      Oui
		--  1    |     Non    |        Oui      |      Oui
		--  2    |     Oui    |        Non      |      Oui
		--  3    |     Non    |        Non      |      Oui
		--  4    |     Oui    |        Oui      |      Non
		--  5    |     Non    |        Oui      |      Non
		--  6    |     Oui    |        Non      |      Non	
		--  7    |     Non    |        Non      |      Non		
	PROCEDURE isAuthorized (niveauP IN NUMBER, permission OUT BOOLEAN)
	IS
			niveauPersonne PERSONNE.NIVEAU_DROIT%TYPE;
			unlog EXCEPTION;
	BEGIN
		--R�cup�ration du niveau de la personne pour le stocker dans la variable niveauPersonne
		pq_ui_commun.getNiveau(niveau => niveauPersonne);
		--On l�ve une exception personnalis�e si le niveau de la personne vaut -1
		IF niveauPersonne=-1 THEN
		  RAISE unlog;
		END IF;		
		--Si le niveau de la page vaut 0 et que le niveau de la personne vaut 1(entraineur), 2(agent d'accueil) ou 3(administrateur) l'acc�s est autoris�
		IF niveauP=0 and (niveauPersonne=1 or niveauPersonne=2 or niveauPersonne=3) THEN
			permission:=true;
		--Si le niveau de la page vaut 1 et que le niveau de la personne vaut 2(agent d'accueil) ou 3(administrateur) l'acc�s est autoris�
		ELSIF niveauP=1 and (niveauPersonne=2 or niveauPersonne=3) THEN
			permission:=true;		
		--Si le niveau de la page vaut 2 et que le niveau de la personne vaut 1(entraineur)ou 3(administrateur) l'acc�s est autoris�
		ELSIF niveauP=2 and (niveauPersonne=1 or niveauPersonne=3) THEN
			permission:=true;
		--Si le niveau de la page vaut 3 et que le niveau de la personne vaut 3(administrateur) l'acc�s est autoris�
		ELSIF niveauP=3 and niveauPersonne=3 THEN
			permission:=true;
		--Si le niveau de la page vaut 4 et que le niveau de la personne vaut 1(entraineur) ou 2(agent d'accueil) l'acc�s est autoris�
		ELSIF niveauP=4 and (niveauPersonne=1 or niveauPersonne=2) THEN
			permission:=true;
		--Si le niveau de la page vaut 5 et que le niveau de la personne vaut 2(agent d'accueil) l'acc�s est autoris�
		ELSIF niveauP=5 and niveauPersonne=3 THEN
			permission:=true;
		--Si le niveau de la page vaut 6 et que le niveau de la personne vaut 1(entraineur) l'acc�s est autoris�
		ELSIF niveauP=6 and niveauPersonne=1 THEN
			permission:=true;
		--Sinon, dans tous les autres cas, l'acc�s est interdit (Cf. Les "non" dans le tableau des droits ci-dessus).
		ELSE
			permission:=false;
		END IF;
		
	EXCEPTION
		WHEN unlog THEN
			permission:=false;
			pq_ui_login.LOGIN;
	END;

	PROCEDURE getNiveau(niveau OUT PERSONNE.NIVEAU_DROIT%TYPE)
	IS
		target_cookie OWA_COOKIE.cookie;
	BEGIN
		target_cookie := OWA_COOKIE.get('numpersonne');
		SELECT
			NIVEAU_DROIT INTO niveau
		FROM
			PERSONNE
		WHERE
			NUM_PERSONNE=TO_NUMBER(target_cookie.vals(1));
	EXCEPTION
		WHEN others THEN
		   niveau:=-1;
	END;
               
	--Proc�dure permettant d'afficher le header ainsi que le menu tout en prenant en compte le niveau de la personne qui se connecte
	PROCEDURE aff_header
	IS
		niveauP NUMBER;
		UNLOG EXCEPTION;
	BEGIN
		getNiveau(niveau => niveauP);
		IF niveauP=-1 THEN
		  RAISE UNLOG;
		END IF;		
		pq_ui_commun.header;
		pq_ui_commun.aff_menu(niveauP);
		htp.div(cattributes => 'id="corps"');
        EXCEPTION
              WHEN UNLOG THEN
                  pq_ui_login.LOGIN;
	END;
	
	--Proc�dure permettant simplement d'afficher le header (css, javascript et image).
	PROCEDURE header
	IS
		rep_css VARCHAR2(255) := pq_ui_param_commun.get_rep_css;
		rep_js VARCHAR2(255) := pq_ui_param_commun.get_rep_js;
		rep_img VARCHAR2(255) := pq_ui_param_commun.get_rep_img;
	BEGIN		
		htp.htmlOpen;
			htp.headOpen;
				htp.print('<link href="' || rep_css || 'style.css" rel="stylesheet" type="text/css" />');
				htp.print('<script language=javascript type="text/javascript" src="' || rep_js || 'create.js"></script>');
			htp.headClose;
			htp.bodyOpen;
			htp.print('<img title="Syst�me de r�servation" alt="Logo" src="' || rep_img || 'logo.png" class="logo">');
	END;

	PROCEDURE aff_menu(niveau IN NUMBER)
	IS
	BEGIN
		CASE niveau
			WHEN 1 THEN
				pq_ui_commun.aff_menu_niveau_entraineur;
			WHEN 2 THEN
				pq_ui_commun.aff_menu_niveau_agent_accueil;
			WHEN 3 THEN
				pq_ui_commun.aff_menu_niveau_administrateur;
			ELSE
				pq_ui_commun.aff_menu_niveau_autre;
		END CASE;
	END;
PROCEDURE aff_menu_niveau_entraineur
	IS
	BEGIN
		htp.div(cattributes => 'id="menuEntraineur"');
			htp.ulistOpen(cattributes => 'id="ulmenu"');
				htp.listItem;
					htp.anchor('pq_ui_accueil.dis_accueil', 'Accueil');
				htp.print('</li>');
				htp.listItem;
					htp.anchor('#', 'Entrainement');
					htp.ulistOpen(cattributes => 'class="niveau2"');
						htp.listItem;
							htp.anchor('pq_ui_entrainement_entraineur.manage_entrainement_entraineur', 'Mes entrainements');
						htp.print('</li>');
						htp.listItem;
							htp.anchor('pq_ui_entrainement_entraineur.form_add_entrainement_entr', 'Nouvel entrainement');
						htp.print('</li>');
					htp.ulistClose;
				htp.print('</li>');
				htp.listItem;
					htp.anchor('pq_ui_account.exec_dis_account', 'Mon compte');
				htp.print('</li>');
				htp.listItem;
					htp.anchor('pq_ui_commun.deconnect', 'Deconnexion');
				htp.print('</li>');
			htp.ulistClose;
		htp.print('</div>');
	END;

	PROCEDURE aff_menu_niveau_agent_accueil
	IS
	BEGIN
		htp.div(cattributes => 'id="menuAgentAcceuil"');
			htp.ulistOpen(cattributes => 'id="ulmenu"');
				htp.listItem;
					htp.anchor('pq_ui_accueil.dis_accueil', 'Accueil');
				htp.print('</li>');
				htp.listItem;
					htp.anchor('pq_ui_reservation.liste_terrains', 'R�servations');
				htp.print('</li>');
				htp.listItem;
					htp.anchor('#', 'Entrainement');
					htp.ulistOpen(cattributes => 'class="niveau2"');
						htp.listItem;
							htp.anchor('pq_ui_entrainement_entraineur.form_add_entrainement_entr', 'Nouvel entrainement');
						htp.print('</li>');
						htp.listItem;
							htp.anchor('pq_ui_entrainement.manage_entrainement', 'Gestion des entrainements');
						htp.print('</li>');
					htp.ulistClose;
				htp.print('</li>');
				htp.listItem;
					htp.anchor('#', 'Joueur');
					htp.ulistOpen(cattributes => 'class="niveau2"');
						htp.listItem;
							htp.anchor('#', 'Ajouter un joueur');
						htp.print('</li>');
						htp.listItem;
							htp.anchor('#', 'Gestion des joueurs');
						htp.print('</li>');
					htp.ulistClose;
				htp.print('</li>');
				htp.listItem;
					htp.anchor('pq_ui_account.exec_dis_account', 'Mon compte');
				htp.print('</li>');
				htp.listItem;
					htp.anchor('pq_ui_commun.deconnect', 'Deconnexion');
				htp.print('</li>');
			htp.ulistClose;
		htp.print('</div>');
	END;

	PROCEDURE aff_menu_niveau_administrateur
	IS
	BEGIN
		htp.div(cattributes => 'id="menuAdministrateur"');
			htp.ulistOpen(cattributes => 'id="ulmenu"');
				htp.listItem;
					htp.anchor('pq_ui_accueil.dis_accueil', 'Accueil');
				htp.listItem;
					htp.anchor('pq_ui_reservation.liste_terrains', 'R�servations');
				htp.print('</li>');
				htp.listItem;
					htp.anchor('pq_ui_personne.manage_personnes', 'Personnes');
				htp.print('</li>');				
				htp.listItem;
					htp.anchor('pq_ui_entrainement.manage_entrainement', 'Entrainements');
				htp.print('</li>');
				htp.listItem;
					htp.anchor('pq_ui_terrain.manage_terrains_with_menu', 'Terrains');
				htp.print('</li>');
				htp.listItem;
					htp.anchor('pq_ui_creneau.manage_creneaux_with_menu', 'Cr�neaux');
				htp.print('</li>');
				htp.listItem;
					htp.anchor('pq_ui_codification.manage_codification_with_menu', 'Codifications');
				htp.print('</li>');
				htp.listItem;
					htp.anchor('pq_ui_abonnement.manage_abonnements', 'Abonnements');
				htp.print('</li>');
				htp.listItem;
					htp.anchor('pq_ui_facture.manage_factures', 'Factures');
				htp.print('</li>');
				htp.listItem;
					htp.anchor('pq_ui_account.exec_dis_account', 'Mon compte');
				htp.print('</li>');				
				htp.listItem;
					htp.anchor('pq_ui_commun.deconnect', 'Deconnexion');
				htp.print('</li>');
			htp.ulistClose;
		htp.print('</div>');
	END;

	PROCEDURE aff_menu_niveau_autre
	IS
	BEGIN
		htp.div(cattributes => 'id="menuAutre"');
			htp.ulistOpen(cattributes => 'id="ulmenu"');
				htp.listItem;
					htp.anchor('pq_ui_accueil.dis_accueil', 'Accueil');
				htp.print('</li>');				
				htp.listItem;
					htp.anchor('pq_ui_account.exec_dis_account', 'Mon compte');
				htp.print('</li>');
				htp.listItem;
					htp.anchor('pq_ui_commun.deconnect', 'Deconnexion');
				htp.print('</li>');
			htp.ulistClose;
		htp.print('</div>');
	END;

	PROCEDURE aff_footer
	IS
	BEGIN
		htp.print('</div>');
		htp.div(cattributes => 'id="footer"');
			htp.print('Syst�me de r�servation d''un centre de tennis');
		htp.print('</div>');
		htp.bodyClose;
		htp.htmlClose;
	END;
	
	PROCEDURE deconnect
	IS
	BEGIN
		owa_util.mime_header('text/html', false);
                owa_cookie.remove('numpersonne',NULL);
                owa_util.http_header_close;
		pq_ui_login.login;
	END;

END pq_ui_commun;
/