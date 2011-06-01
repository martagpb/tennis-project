-- -----------------------------------------------------------------------------
--           Cr�ation du package d'interface d'affichage des donn�es
--           pour la table CODIFICATION
--                      Oracle Version 10g
--                        (14/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de derni�re modification : 31/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pq_ui_codification
AS
	--Permet d'afficher toutes les codifications et les actions possibles de gestion (avec le menu)
	PROCEDURE manage_codification_with_menu
	IS		
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
        pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		pq_ui_commun.aff_header;
			pq_ui_codification.manage_codification;
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�e.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Gestion des codification');
	END manage_codification_with_menu;

	--Permet d'afficher toutes les codifications et les actions possibles de gestion (sans le menu)
	PROCEDURE manage_codification
	IS
		CURSOR listCodification IS
		SELECT 
            COD.CODE   
          , COD.NATURE 
          , COD.LIBELLE 
		FROM 
			CODIFICATION COD
		ORDER BY 
			1
		  , 2
		  , 3;
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
        pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		htp.br;				
		htp.print('Gestion des codifications' || ' (' || htf.anchor('pq_ui_codification.manage_codification_with_menu','Actualiser')|| ')' );
		htp.br;	
		htp.br;	
		htp.print(htf.anchor('pq_ui_codification.form_add_codification','Ajouter une codification'));
		htp.br;	
		htp.br;	
		htp.tableOpen('',cattributes => 'class="tableau"');
			htp.tableheader('Nature');
			htp.tableheader('Libell�');
			htp.tableheader('Informations');
			htp.tableheader('Mise � jour');
			htp.tableheader('Suppression');
			for currentCodification in listCodification loop
				htp.tableRowOpen;
				htp.tabledata(currentCodification.NATURE);
				htp.tabledata(currentCodification.LIBELLE);					
				htp.tabledata(htf.anchor('pq_ui_codification.dis_codification?vcode='||currentCodification.CODE||'&'||'vnature='||currentCodification.NATURE||'&'||'vlibelle='||currentCodification.LIBELLE,'Informations'));
				htp.tabledata(htf.anchor('pq_ui_codification.form_upd_codification?vcode='||currentCodification.CODE||'&'||'vnature='||currentCodification.NATURE||'&'||'vlibelle='||currentCodification.LIBELLE,'Mise � jour'));
				htp.tabledata(htf.anchor('pq_ui_codification.exec_del_codification?vcode='||currentCodification.CODE||'&'||'vnature='||currentCodification.NATURE,'Supprimer', cattributes => 'onClick="return confirmerChoix(this,document)"'));
				htp.tableRowClose;
			end loop;	
		htp.tableClose;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�e.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Gestion des codifications');
	END manage_codification;

	--Permet d�afficher une codification existante
	PROCEDURE dis_codification(
	  vcode IN CHAR
	, vnature IN VARCHAR2
	, vlibelle IN VARCHAR2)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
        pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		pq_ui_commun.aff_header;
				htp.br;	
				htp.print('Affichage des informations d''une codification' || ' (' || htf.anchor('pq_ui_codification.dis_codification?vcode='||vcode||'&'||'vnature='||vnature,'Actualiser')|| ')' );
				htp.br;
				htp.br;					
				htp.tableOpen('',cattributes => 'class="tableau"');
				    htp.tableheader('Code');
			        htp.tableheader('Nature');
			        htp.tableheader('Libell�');		
                    htp.tableRowOpen;
					   htp.tabledata(vcode);
				       htp.tabledata(vnature);
				       htp.tabledata(vlibelle);	
                    htp.tableRowClose;	
		        htp.tableClose;					
				htp.br;
				htp.br;		
				htp.anchor('pq_ui_codification.manage_codification_with_menu', 'Retourner � la gestion des codifications');	
			pq_ui_commun.aff_footer;
	EXCEPTION
	WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�e.');
	END dis_codification;
		
	-- Ex�cute la proc�dure d'ajout d'une codification et g�re les erreurs �ventuelles
	PROCEDURE exec_add_codification(
	  vcode IN CHAR
	, vnature IN VARCHAR2
	, vlibelle IN VARCHAR2)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
        pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		pq_ui_commun.aff_header;
				htp.br;
				pq_db_codification.add_codification(vcode,vnature,vlibelle);
				htp.print('La codification qui s''intitule '|| vlibelle || ' et qui est du type '|| vnature || ' a �t� ajout�e avec succ�s.');
				htp.br;
				htp.br;			
				pq_ui_codification.manage_codification;
			pq_ui_commun.aff_footer;
	EXCEPTION
		--Traitement personnalis�e de l'erreur :
			-- Nom Exception: DUP_VAL_ON_INDEX, Erreur oracle : ORA-00001, Code erreur : -1
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�e.');
		WHEN DUP_VAL_ON_INDEX THEN
			pq_ui_commun.dis_error_custom('La codification n''a pas �t� ajout�e','Une codification existe d�j� avec un code qui vaut '|| vcode ||' et une nature '|| vnature ||'.','Merci de choisir d''autres valeurs pour le code et/ou la nature.','pq_ui_codification.form_add_codification','Retour vers la cr�ation d''une codification');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Ajout d''une codification en cours...');
	END exec_add_codification;
	
	-- Ex�cute la proc�dure de mise � jour d'une codification et g�re les erreurs �ventuelles
	PROCEDURE exec_upd_codification(
	  vcode IN CHAR
	, vnature IN VARCHAR2
	, vlibelle IN VARCHAR2)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
        pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		    pq_ui_commun.aff_header;
				htp.br;				
				pq_db_codification.upd_codification(vcode,vnature,vlibelle);
				htp.print('La codification qui s''intitule '|| vlibelle || ' et qui est du type '|| vnature || ' a �t� mise � jour avec succ�s.');
				htp.br;
				htp.br;			
				pq_ui_codification.manage_codification;
			pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�e.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Mise � jour d''une codification en cours...');
	END exec_upd_codification;
	
	-- Ex�cute la proc�dure de suppression d'une codification et g�re les erreurs �ventuelles
	PROCEDURE exec_del_codification(
	  vcode IN CHAR
	, vnature IN VARCHAR2)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		 pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		pq_ui_commun.aff_header;
				htp.br;	
				pq_db_codification.del_codification(vcode,vnature);
				htp.print('La codification qui avait le code '|| vcode || ' et qui �tait du type '|| vnature || ' a �t� supprim�e avec succ�s.');
				htp.br;
				htp.br;			
				pq_ui_codification.manage_codification;
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�e.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Suppression d''une codification en cours...');
	END exec_del_codification;
	
	-- Ex�cute la proc�dure d�affichage des codifications et g�re les erreurs
	PROCEDURE exec_dis_codification(
	  vcode IN CHAR
	, vnature IN VARCHAR2
	, vlibelle IN VARCHAR2)
	IS
	perm BOOLEAN;
	PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		pq_ui_commun.aff_header;
				htp.br;				
				pq_ui_codification.dis_codification(vcode,vnature,vlibelle);
				htp.br;		
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�e.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Affichage d''une codification en cours...');
	END exec_dis_codification;
	
	
	-- Affiche le formulaire permettant la saisie d�une nouvelle codification
	PROCEDURE form_add_codification
	IS
	perm BOOLEAN;
	PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		pq_ui_commun.aff_header;
				htp.br;
				htp.print('Cr�ation d''une nouvelle codification');
				htp.br;
				htp.br;
				htp.print('Les champs marqu�s d''une �toile sont obligatoires.');
				htp.br;
				htp.br;
				htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_codification.exec_add_codification', 'GET', cattributes => 'onSubmit="return validerCodification(this,document)"');
				htp.tableOpen;
					htp.tableheader('');
					htp.tableheader('');
					htp.tableheader('');					
					htp.tableRowOpen;
						htp.tableData('Code * :', cattributes => 'class="enteteFormulaire"');
						htp.print('<td>');
						    htp.formText('vcode',5,cattributes => 'maxlength="5" id="vcode" name="vcode"');
						htp.print('</td>');	
						htp.tableData('',cattributes => 'id="vCodeError" class="error"');						
					htp.tableRowClose;	
					htp.tableRowOpen;
						htp.tableData('Nature * :', cattributes => 'class="enteteFormulaire"');
						htp.print('<td>');
						    htp.formText('vnature',20,cattributes => 'maxlength="20" id="vnature" name="vnature"');
						htp.print('</td>');	
						htp.tableData('',cattributes => 'id="vNatureError" class="error"');						
					htp.tableRowClose;
					htp.tableRowOpen;
						htp.tableData('Libell� :', cattributes => 'class="enteteFormulaire"');
						htp.print('<td>');
						    htp.formText('vlibelle',50,cattributes => 'maxlength="50" id="vlibelle"');
						htp.print('</td>');	
						htp.tableData('',cattributes => 'id="vLibelleError" class="error"');						
					htp.tableRowClose;
					htp.tableRowOpen;
						htp.tableData('');
						htp.tableData(htf.formSubmit(NULL,'Validation'));
					htp.tableRowClose;
				htp.tableClose;
				htp.formClose;
				htp.br;
				htp.anchor('pq_ui_codification.manage_codification_with_menu', 'Retourner � la gestion des codifications');
			pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�e.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Saisie d''une nouvelle codification');
	END form_add_codification;
	
	
	-- Affiche le formulaire de saisie permettant la modification d�une codification
	PROCEDURE form_upd_codification(
	  vcode IN CHAR
	, vnature IN VARCHAR2
	, vlibelle IN VARCHAR2)
	IS
	perm BOOLEAN;
	PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		pq_ui_commun.aff_header;
				htp.br;
				htp.print('Mise � jour d''une codification');
				htp.br;
				htp.br;
				htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_codification.exec_upd_codification', 'GET', cattributes => 'onSubmit="return validerCodification(this,document)"');
				htp.formhidden ('vcode',vcode);
				htp.formhidden ('vnature',vnature);
				htp.tableOpen;
					htp.tableheader('');
					htp.tableheader('');
					htp.tableheader('');	
				htp.tableRowOpen;
					htp.tableData('Code * :', cattributes => 'class="enteteFormulaire"');
					htp.tableData(vcode);
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Nature * :', cattributes => 'class="enteteFormulaire"');
					htp.tableData(vnature);
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Libell� :');	
					htp.print('<td>');	
					    htp.print('<input type="text" name="vlibelle" id="vlibelle" maxlength="50" value="'||vlibelle||'"> ');													
					htp.print('</td>');						
				htp.tableRowClose;
				htp.tableRowOpen;
						htp.tableData('');
						htp.tableData(htf.formSubmit(NULL,'Validation'));
				htp.tableRowClose;
				htp.tableClose;
				htp.formClose;
				htp.br;
				htp.anchor('pq_ui_codification.manage_codification_with_menu', 'Retourner � la gestion des codification');
			pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�e.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Modification d''une codification');
	END form_upd_codification;

END pq_ui_codification;
/