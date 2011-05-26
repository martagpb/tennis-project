create or replace
PACKAGE BODY pq_ui_commun
AS
	---Procédure permettant d'afficher les détails d'une erreur d'oracle
	PROCEDURE dis_error(
	  vnumero in varchar2
	, vliberreur in varchar2
	, vactionencours in varchar2)
	IS
	begin
			pq_ui_commun.aff_header;
			htp.print('Détails sur l''erreur d''oracle');
			htp.br;
			htp.br;
			htp.tableopen;
				htp.tablerowopen;
					htp.tabledata('N° :', cattributes => 'class="enteteFormulaire"');
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
			htp.br;
			htp.anchor('pq_ui_login.login', 'Retourner à l''accueil');
		pq_ui_commun.aff_footer;
	END;


	-- Affiche le détail d'une erreur personnalisée
	PROCEDURE dis_error_custom(
	  vtitre in varchar2
	, vexplicationerreur in varchar2
	, vconseilerreur in varchar2
	, vlienretour  in varchar2
	, vlibellelien in varchar2)
	IS
	begin
			htp.br;
			htp.print(vtitre);
			htp.br;
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
	


PROCEDURE aff_accueil
IS
	perm BOOLEAN;
	PERMISSION_DENIED EXCEPTION;
BEGIN
        pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
	IF perm=false THEN
		RAISE PERMISSION_DENIED;
	END IF;
        pq_ui_commun.aff_header;
	htp.print('Accueil');
	pq_ui_commun.aff_footer;
EXCEPTION
	WHEN PERMISSION_DENIED THEN
		 pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusée.');
END;

PROCEDURE isAuthorized (niveauP IN NUMBER, permission OUT BOOLEAN)
IS
        niveauPersonne PERSONNE.NIVEAU_DROIT%TYPE;
        unlog EXCEPTION;
BEGIN
	getNiveau(niveau => niveauPersonne);
        IF niveauPersonne=-1 THEN
          RAISE unlog;
        END IF;
	IF(niveauPersonne<niveauP) THEN
			permission:=false;
	ELSE
			permission:=true;
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
                

PROCEDURE aff_header
	IS
		rep_css VARCHAR2(255) := pq_ui_param_commun.get_rep_css;
		rep_js VARCHAR2(255) := pq_ui_param_commun.get_rep_js;
		rep_img VARCHAR2(255) := pq_ui_param_commun.get_rep_img;
                niveauP NUMBER;
                UNLOG EXCEPTION;
	BEGIN
                getNiveau(niveau => niveauP);
                IF niveauP=-1 THEN
                  RAISE UNLOG;
                END IF;
		htp.htmlOpen;
			htp.headOpen;
				htp.print('<link href="' || rep_css || 'style.css" rel="stylesheet" type="text/css" />');
				htp.print('<script language=javascript type="text/javascript" src="' || rep_js || 'create.js"></script>');
			htp.headClose;
			htp.bodyOpen;
			--logo
			htp.print('<img title="Système de réservation" alt="Logo" src="' || rep_img || 'logo.jpg">');
			pq_ui_commun.aff_menu(niveauP);
			htp.div(cattributes => 'id="corps"');
        EXCEPTION
              WHEN UNLOG THEN
                  pq_ui_login.LOGIN;
	END;


	PROCEDURE aff_menu(niveau IN NUMBER)
	IS
	BEGIN
		CASE niveau
			WHEN 1 THEN
				pq_ui_commun.aff_menu_niveau1;
			WHEN 2 THEN
				pq_ui_commun.aff_menu_niveau2;
			WHEN 3 THEN
				pq_ui_commun.aff_menu_niveau3;
		END CASE;
	END;


	PROCEDURE aff_menu_niveau1
	IS
	BEGIN
		htp.div(cattributes => 'id="menuvisiteur"');
			htp.ulistOpen(cattributes => 'id="ulmenu"');
				htp.listItem;
					htp.anchor('#', 'Accueil');
				htp.print('</li>');
				htp.listItem;
					htp.anchor('#', 'Réservation');
					htp.ulistOpen(cattributes => 'class="niveau2"');
						htp.listItem;
							htp.anchor('#', 'Mes réservation');
						htp.print('</li>');
						htp.listItem;
							htp.anchor('#', 'Nouvelle réservation');
						htp.print('</li>');
					htp.ulistClose;
				htp.print('</li>');
				htp.listItem;
					htp.anchor('#', 'Mon compte');
				htp.print('</li>');
				htp.listItem;
					htp.anchor('#', 'Informations');
				htp.print('</li>');
				htp.listItem;
					htp.anchor('pq_ui_commun.deconnect', 'Deconnexion');
				htp.print('</li>');
			htp.ulistClose;
		htp.print('</div>');
	END;

	PROCEDURE aff_menu_niveau2
	IS
	BEGIN
		htp.div(cattributes => 'id="menuadherent"');
			htp.ulistOpen(cattributes => 'id="ulmenu"');
				htp.listItem;
					htp.anchor('#', 'Accueil');
				htp.print('</li>');
				htp.listItem;
					htp.anchor('#', 'Réservation');
					htp.ulistOpen(cattributes => 'class="niveau2"');
						htp.listItem;
							htp.anchor('#', 'Mes réservation');
						htp.print('</li>');
						htp.listItem;
							htp.anchor('#', 'Nouvelle réservation');
						htp.print('</li>');
					htp.ulistClose;
				htp.print('</li>');
				htp.listItem;
					htp.anchor('#', 'Entrainement');
					htp.ulistOpen(cattributes => 'class="niveau2"');
						htp.listItem;
							htp.anchor('#', 'Mes entrainements');
						htp.print('</li>');
						htp.listItem;
							htp.anchor('#', 'Souscrire');
						htp.print('</li>');
					htp.ulistClose;
				htp.print('</li>');
				htp.listItem;
					htp.anchor('#', 'Mon compte');
				htp.print('</li>');
				htp.listItem;
					htp.anchor('#', 'Informations');
				htp.print('</li>');
				htp.listItem;
					htp.anchor('pq_ui_commun.deconnect', 'Deconnexion');
				htp.print('</li>');
			htp.ulistClose;
		htp.print('</div>');
	END;

	PROCEDURE aff_menu_niveau3
	IS
	BEGIN
		htp.div(cattributes => 'id="menuadmin"');
			htp.ulistOpen(cattributes => 'id="ulmenu"');
				htp.listItem;
					htp.anchor('#', 'Accueil');
				htp.print('</li>');
				htp.listItem;
					htp.anchor('#', 'Réservation');
					htp.ulistOpen(cattributes => 'class="niveau2"');
						htp.listItem;
							htp.anchor('#', 'Mes réservation');
						htp.print('</li>');
						htp.listItem;
							htp.anchor('#', 'Nouvelle réservation');
						htp.print('</li>');
					htp.ulistClose;
				htp.print('</li>');
				htp.listItem;
					htp.anchor('#', 'Entrainement');
					htp.ulistOpen(cattributes => 'class="niveau2"');
						htp.listItem;
							htp.anchor('#', 'Mes entrainements');
						htp.print('</li>');
						htp.listItem;
							htp.anchor('#', 'Souscrire');
						htp.print('</li>');
					htp.ulistClose;
				htp.print('</li>');
				htp.listItem;
					htp.anchor('#', 'Mon compte');
				htp.print('</li>');
				htp.listItem;
					htp.anchor('#', 'Informations');
				htp.print('</li>');
				htp.listItem;
					htp.anchor('#', 'Administration');
					htp.ulistOpen(cattributes => 'class="niveau2"');
						htp.listItem;
							htp.anchor('pq_ui_terrain.manage_terrains_with_menu', 'Gestion des terrains');
						htp.print('</li>');
						htp.listItem;
							htp.anchor('pq_ui_creneau.manage_creneaux_with_menu', 'Gestion des créneaux');
						htp.print('</li>');
					htp.ulistClose;
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
			htp.print('Système de réservation d''un centre de tennis');
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