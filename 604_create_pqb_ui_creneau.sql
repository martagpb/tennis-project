-- -----------------------------------------------------------------------------
--           Création du corps du package d'affichage des données
--           pour la table CRENEAU
--                      Oracle Version 10g
--                        (10/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 18/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pq_ui_creneau
AS
	--Permet d'afficher tous les créneaux et les actions possibles de gestion
	PROCEDURE manage_creneaux
	IS
		rep_css VARCHAR2(255) := pq_ui_param_commun.get_rep_css;
		rep_js VARCHAR2(255)  := pq_ui_param_commun.get_rep_js;
		-- On stocke dans un curseur la liste de tous les créneaux existants
		CURSOR listCreneaux IS
		SELECT 
			CRE.HEURE_DEBUT_CRENEAU
		  , CRE.HEURE_FIN_CRENEAU 
		FROM 
			CRENEAU CRE
		ORDER BY 
			1
		  , 2;
	BEGIN
		htp.htmlOpen;
			htp.headOpen;
				htp.print('<link href="' || rep_css || 'style.css" rel="stylesheet" type="text/css" />'); 
				htp.print('<script language=javascript type="text/javascript" src="' || rep_js || 'create.js"></script>'); 	
			htp.headClose;
			htp.bodyOpen;
				htp.br;				
				htp.print('Gestion des créneaux' || ' (' || htf.anchor('pq_ui_creneau.manage_creneaux','Actualiser')|| ')' );
				htp.br;	
				htp.br;	
				htp.print(htf.anchor('pq_ui_creneau.form_add_creneau','Ajouter un créneau'));
				htp.br;	
				htp.br;	
				htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_creneau.exec_add_creneau', 'POST', cattributes => 'onSubmit="return validerCreneau(this,document)"');
					htp.tableOpen;
					htp.tableheader('Heure de début');
					htp.tableheader('Heure de fin');
					htp.tableheader('Informations');
					htp.tableheader('Mise à jour');
					htp.tableheader('Suppression');
					for currentCreneau in listCreneaux loop
						htp.tableRowOpen;
						htp.tabledata(currentCreneau.HEURE_DEBUT_CRENEAU);
						htp.tabledata(currentCreneau.HEURE_FIN_CRENEAU);					
						htp.tabledata(htf.anchor('pq_ui_creneau.dis_creneau?vheureDebutCreneau='||currentCreneau.HEURE_DEBUT_CRENEAU||'&'||'vheureFinCreneau='||currentCreneau.HEURE_FIN_CRENEAU,'Informations'));
						htp.tabledata(htf.anchor('pq_ui_creneau.form_upd_creneau?vheureDebutCreneau='||currentCreneau.HEURE_DEBUT_CRENEAU||'&'||'vheureFinCreneau='||currentCreneau.HEURE_FIN_CRENEAU,'Mise à jour'));
						htp.tabledata(htf.anchor('pq_ui_creneau.exec_del_creneau?vheureDebutCreneau='||currentCreneau.HEURE_DEBUT_CRENEAU,'Supprimer', cattributes => 'onClick="return confirmerChoix(this,document)"'));
						htp.tableRowClose;
					end loop;	
					htp.tableClose;
				htp.formClose;
			htp.bodyClose;
		htp.htmlClose;
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Gestion des créneaux');
	END manage_creneaux;
	
	--Permet d’afficher un créneau existant
	PROCEDURE dis_creneau(
	  vheureDebutCreneau IN CHAR
	, vheureFinCreneau IN CHAR)
	IS
		rep_css VARCHAR2(255) := pq_ui_param_commun.get_rep_css;
	BEGIN
		htp.htmlOpen;
			htp.headOpen;
				htp.print('<link href="' || rep_css || 'style.css" rel="stylesheet" type="text/css" />'); 
			htp.headClose;
			htp.bodyOpen;
				htp.br;	
				htp.print('Affichage des informations d''un créneau' || ' (' || htf.anchor('pq_ui_creneau.dis_creneau?vheureDebutCreneau='||vheureDebutCreneau||'&'||'vheureFinCreneau='||vheureFinCreneau,'Actualiser')|| ')' );
				htp.br;
				htp.br;					
				htp.print('Le créneau commence à '|| vheureDebutCreneau || ' et se termine à '|| vheureFinCreneau || '.');
				htp.br;
				htp.br;		
				htp.anchor('pq_ui_creneau.manage_creneaux', 'Retourner à la gestion des créneaux');	
			htp.bodyClose;
		htp.htmlClose;
	END dis_creneau;
	
	-- Exécute la procédure d'ajout d'un créneau et gère les erreurs éventuelles.
	PROCEDURE exec_add_creneau(
	  vheureDebutCreneau IN CHAR
	, vheureFinCreneau IN CHAR)
	IS
		rep_css VARCHAR2(255) := pq_ui_param_commun.get_rep_css;
	BEGIN
		htp.htmlOpen;
			htp.headOpen;
				htp.print('<link href="' || rep_css || 'style.css" rel="stylesheet" type="text/css" />'); 
			htp.headClose;
			htp.bodyOpen;
				htp.br;
				pq_db_creneau.add_creneau(vheureDebutCreneau,vheureFinCreneau);
				htp.print('Le créneau qui commence à '|| vheureDebutCreneau || ' et qui se termine à '|| vheureFinCreneau || ' a été ajouté avec succès.');
				htp.br;
				htp.br;			
				pq_ui_creneau.manage_creneaux;
			htp.bodyClose;
		htp.htmlClose;
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Ajout d''un créneau en cours...');
	END exec_add_creneau;
	
	-- Exécute la procédure de mise à jour d'un créneau et gère les erreurs éventuelles
	PROCEDURE exec_upd_creneau(
	  vheureDebutCreneau IN CHAR
	, vheureFinCreneau IN CHAR)
	IS
		rep_css VARCHAR2(255) := pq_ui_param_commun.get_rep_css;
	BEGIN
		htp.htmlOpen;
			htp.headOpen;
				htp.print('<link href="' || rep_css || 'style.css" rel="stylesheet" type="text/css" />'); 
			htp.headClose;
			htp.bodyOpen;
				htp.br;				
				pq_db_creneau.upd_creneau(vheureDebutCreneau,vheureFinCreneau);
				htp.print('Le créneau qui commence à '|| vheureDebutCreneau || ' et qui se termine à '|| vheureFinCreneau || ' a été mise à jour avec succès.');
				htp.br;
				htp.br;			
				pq_ui_creneau.manage_creneaux;
			htp.bodyClose;
		htp.htmlClose;
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Mise à jour d''un créneau en cours...');
	END exec_upd_creneau;
	
	-- Exécute la procédure de suppression d'un créneau et gère les erreurs éventuelles
	PROCEDURE exec_del_creneau(
	  vheureDebutCreneau IN CHAR)
	IS
		rep_css VARCHAR2(255) := pq_ui_param_commun.get_rep_css;
	BEGIN
		htp.htmlOpen;
			htp.headOpen;
				htp.print('<link href="' || rep_css || 'style.css" rel="stylesheet" type="text/css" />'); 
			htp.headClose;
			htp.bodyOpen;
				htp.br;	
				pq_db_creneau.del_creneau(vheureDebutCreneau);
				htp.print('Le créneau qui commençait à '|| vheureDebutCreneau || ' a été supprimé avec succès.');
				htp.br;
				htp.br;			
				pq_ui_creneau.manage_creneaux;
			htp.bodyClose;
		htp.htmlClose;
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Suppression d''un créneau en cours...');
	END exec_del_creneau;
	  
	-- Exécute la procédure d’affichage des créneaux et gère les erreurs éventuelles
	PROCEDURE exec_dis_creneau(
	  vheureDebutCreneau IN CHAR
	, vheureFinCreneau IN CHAR)
	IS
		rep_css VARCHAR2(255) := pq_ui_param_commun.get_rep_css;
	BEGIN
		htp.htmlOpen;
			htp.headOpen;
				htp.print('<link href="' || rep_css || 'style.css" rel="stylesheet" type="text/css" />'); 
			htp.headClose;
			htp.bodyOpen;
				htp.br;				
				pq_ui_creneau.dis_creneau(vheureDebutCreneau,vheureFinCreneau);
				htp.br;		
			htp.bodyClose;
		htp.htmlClose;
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Affichage d''un créneau en cours...');
	END exec_dis_creneau;
	
	-- Affiche le formulaire permettant la saisie d’un nouveau créneau	
	PROCEDURE form_add_creneau
	IS
		rep_css VARCHAR2(255) := pq_ui_param_commun.get_rep_css;
		rep_js VARCHAR2(255)  := pq_ui_param_commun.get_rep_js;
	BEGIN
		htp.htmlOpen;
			htp.headOpen;
				htp.print('<link href="' || rep_css || 'style.css" rel="stylesheet" type="text/css" />'); 
				htp.print('<script language=javascript type="text/javascript" src="' || rep_js || 'create.js"></script>'); 	
			htp.headClose;
			htp.bodyOpen;
				htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_creneau.exec_add_creneau', 'POST', cattributes => 'onSubmit="return validerCreneau(this,document)"');
					htp.tableOpen;
					htp.br;
					htp.print('Création d''un nouveau créneau' || ' (' || htf.anchor('pq_ui_creneau.form_add_creneau','Actualiser')|| ')' );
					htp.br;
					htp.br;
					htp.print('Les champs marqués d''une étoile sont obligatoires.');
					htp.br;
					htp.br;
					htp.tableRowOpen;
						htp.tableData('Heure de début * :', cattributes => 'class="enteteFormulaire"');
						htp.tableData(htf.formText('vheureDebutCreneau',5));
					htp.tableRowClose;	
					htp.tableRowOpen;
						htp.tableData('Heure de fin :', cattributes => 'class="enteteFormulaire"');
						htp.tableData(htf.formText('vheureFinCreneau',5));
					htp.tableRowClose;
					htp.tableRowOpen;
						htp.tableData('');
						htp.tableData(htf.formSubmit(NULL,'Validation'));
					htp.tableRowClose;
					htp.tableClose;
				htp.formClose;
				htp.br;
				htp.anchor('pq_ui_creneau.manage_creneaux', 'Retourner à la gestion des créneaux');
			htp.bodyClose;
		htp.htmlClose;
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Saisie d''un nouveau créneau');
	END form_add_creneau;
	
	
	-- Affiche le formulaire de saisie permettant la modification d’un créneau existant
	PROCEDURE form_upd_creneau(
	  vheureDebutCreneau IN CHAR
	, vheureFinCreneau IN CHAR)
	IS
		rep_css VARCHAR2(255) := pq_ui_param_commun.get_rep_css;
		rep_js VARCHAR2(255)  := pq_ui_param_commun.get_rep_js;
	BEGIN
		htp.htmlOpen;
			htp.headOpen;
				htp.print('<link href="' || rep_css || 'style.css" rel="stylesheet" type="text/css" />'); 
				htp.print('<script language=javascript type="text/javascript" src="' || rep_js || 'create.js"></script>'); 	
			htp.headClose;
			htp.bodyOpen;
				htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_creneau.exec_upd_creneau', 'GET', cattributes => 'onSubmit="return validerCreneau(this,document)"');
					htp.formhidden ('vheureDebutCreneau',vheureDebutCreneau);
					htp.tableOpen;
					htp.br;
					htp.print('Mise à jour d''un créneau' || ' (' || htf.anchor('pq_ui_creneau.form_upd_creneau?vheureDebutCreneau='||vheureDebutCreneau||'&'||'vheureFinCreneau='||vheureFinCreneau,'Actualiser')|| ')' );
					htp.br;
					htp.br;
					htp.tableRowOpen;
						htp.tableData('Heure de début :', cattributes => 'class="enteteFormulaire"');
						htp.tableData(vheureDebutCreneau);
					htp.tableRowClose;	
					htp.tableRowOpen;
						htp.tableData('Heure de fin :', cattributes => 'class="enteteFormulaire"');
						htp.tableData(htf.formText('vheureFinCreneau',5,5,vheureFinCreneau));
					htp.tableRowClose;
					htp.tableRowOpen;
						htp.tableData('');
						htp.tableData(htf.formSubmit(NULL,'Validation'));
					htp.tableRowClose;
					htp.tableClose;
				htp.formClose;
				htp.br;
				htp.anchor('pq_ui_creneau.manage_creneaux', 'Retourner à la gestion des créneaux');
			htp.bodyClose;
		htp.htmlClose;
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Modification d''un créneau');
	END form_upd_creneau;
	
END pq_ui_creneau;
/