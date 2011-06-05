-- -----------------------------------------------------------------------------
--           Création du package d'interface d'affichage des données
--           pour la table CODIFICATION
--                      Oracle Version 10g
--                        (14/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 31/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pq_ui_codification
IS 
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
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusée.');
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
			CODIFICATION COD;
		
		codificationUsedByTerrain NUMBER(5):= 0; 
		codificationUsedByPersonne NUMBER(5):= 0; 
		codificationUsedByEntrainement NUMBER(5):= 0; 
		
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
        pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		htp.br;	
		htp.print('<div class="titre_niveau_1">');
			htp.print('Gestion des codifications');
		htp.print('</div>');		
		htp.br;	
		htp.br;	
		htp.print(htf.anchor('pq_ui_codification.form_add_codification','Ajouter une codification'));
		htp.br;	
		htp.br;	
		htp.tableOpen('',cattributes => 'class="tableau"');
			htp.tableheader('Nature');
			htp.tableheader('Libellé');
			htp.tableheader('Informations');
			htp.tableheader('Mise à jour');
			htp.tableheader('Suppression');
			for currentCodification in listCodification loop
				htp.tableRowOpen;
				htp.tabledata(currentCodification.NATURE);
				htp.tabledata(currentCodification.LIBELLE);					
				htp.tabledata(htf.anchor('pq_ui_codification.dis_codification?vcode='||currentCodification.CODE||'&'||'vnature='||currentCodification.NATURE||'&'||'vlibelle='||currentCodification.LIBELLE,'Informations'));
				
				--Permet de déterminer si une codification est utilisé pour un terrain	
				SELECT 
					COUNT(*) INTO codificationUsedByTerrain
				FROM 
					TERRAIN 
				WHERE 
					CODE_SURFACE = currentCodification.CODE 
				AND NATURE_SURFACE = currentCodification.NATURE;
				
				--Permet de déterminer si une codification est utilisé pour une personne	
				SELECT 
					COUNT(*) INTO codificationUsedByPersonne
				FROM 
					PERSONNE 
				WHERE 
					(CODE_STATUT_EMPLOYE = currentCodification.CODE 
					AND NATURE_STATUT_EMPLOYE = currentCodification.NATURE)
				OR
					(CODE_NIVEAU = currentCodification.CODE 
					AND NATURE_NIVEAU = currentCodification.NATURE);
					
				--Permet de déterminer si une codification est utilisé pour un terrain	
				SELECT 
					COUNT(*) INTO codificationUsedByEntrainement
				FROM 
					ENTRAINEMENT 
				WHERE 
					CODE_NIVEAU = currentCodification.CODE 
				AND NATURE_NIVEAU = currentCodification.NATURE;
					
				--On autorise la mise à jour et la suppression d'une codification seulement dans le cas où elle n'est pas utilisée
				if (codificationUsedByTerrain = 0 and codificationUsedByPersonne = 0 and codificationUsedByEntrainement = 0) then
					htp.tabledata(htf.anchor('pq_ui_codification.form_upd_codification?vcode='||currentCodification.CODE||'&'||'vnature='||currentCodification.NATURE||'&'||'vlibelle='||currentCodification.LIBELLE,'Mise à jour'));
					htp.tabledata(htf.anchor('pq_ui_codification.exec_del_codification?vcode='||currentCodification.CODE||'&'||'vnature='||currentCodification.NATURE,'Supprimer', cattributes => 'onClick="return confirmerChoix(this,document)"'));
				else
					htp.tabledata('Non autorisée');
					htp.tabledata('Non autorisée');
				end if;		
				
				htp.tableRowClose;
			end loop;	
		htp.tableClose;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusée.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Gestion des codifications');
	END manage_codification;

	--Permet d’afficher une codification existante
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
				htp.print('<div class="titre_niveau_1">');
					htp.print('Affichage des informations d''une codification');
				htp.print('</div>');
				htp.br;
				htp.br;					
				htp.tableOpen('',cattributes => 'class="tableau"');
				    htp.tableheader('Code');
			        htp.tableheader('Nature');
			        htp.tableheader('Libellé');		
                    htp.tableRowOpen;
					   htp.tabledata(vcode);
				       htp.tabledata(vnature);
				       htp.tabledata(vlibelle);	
                    htp.tableRowClose;	
		        htp.tableClose;					
				htp.br;
				htp.br;		
				htp.anchor('pq_ui_codification.manage_codification_with_menu', 'Retourner à la gestion des codifications');	
			pq_ui_commun.aff_footer;
	EXCEPTION
	WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusée.');
	END dis_codification;
		
	-- Exécute la procédure d'ajout d'une codification et gère les erreurs éventuelles
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
				htp.print('<div class="success"> ');
					htp.print('La codification qui s''intitule '|| vlibelle || ' et qui est du type '|| vnature || ' a été ajoutée avec succès.');
				htp.print('</div>');				
				htp.br;
				htp.br;			
				pq_ui_codification.manage_codification;
			pq_ui_commun.aff_footer;
	EXCEPTION
		--Traitement personnalisée de l'erreur :
			-- Nom Exception: DUP_VAL_ON_INDEX, Erreur oracle : ORA-00001, Code erreur : -1
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusée.');
		WHEN DUP_VAL_ON_INDEX THEN
			pq_ui_commun.dis_error_custom('La codification n''a pas été ajoutée','Une codification existe déjà avec un code qui vaut '|| vcode ||' et une nature '|| vnature ||'.','Merci de choisir d''autres valeurs pour le code et/ou la nature.','pq_ui_codification.form_add_codification','Retour vers la création d''une codification');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Ajout d''une codification en cours...');
	END exec_add_codification;
	
	-- Exécute la procédure de mise à jour d'une codification et gère les erreurs éventuelles
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
				htp.print('<div class="success"> ');
					htp.print('La codification qui s''intitule '|| vlibelle || ' et qui est du type '|| vnature || ' a été mise à jour avec succès.');
				htp.print('</div>');					
				htp.br;
				htp.br;			
				pq_ui_codification.manage_codification;
			pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusée.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Mise à jour d''une codification en cours...');
	END exec_upd_codification;
	
	-- Exécute la procédure de suppression d'une codification et gère les erreurs éventuelles
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
				htp.print('<div class="success"> ');
					htp.print('La codification qui avait le code '|| vcode || ' et qui était du type '|| vnature || ' a été supprimée avec succès.');
				htp.print('</div>');				
				htp.br;
				htp.br;			
				pq_ui_codification.manage_codification;
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusée.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Suppression d''une codification en cours...');
	END exec_del_codification;
	
	-- Exécute la procédure d’affichage des codifications et gère les erreurs
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
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusée.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Affichage d''une codification en cours...');
	END exec_dis_codification;
	
	
	-- Affiche le formulaire permettant la saisie d’une nouvelle codification
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
				htp.print('<div class="titre_niveau_1">');
					htp.print('Création d''une nouvelle codification');
				htp.print('</div>');				
				htp.br;
				htp.br;
				htp.print('Les champs marqués d''une étoile sont obligatoires.');
				htp.br;
				htp.br;
				htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_codification.exec_add_codification', 'POST', cattributes => 'onSubmit="return validerCodification(this,document)"');
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
						htp.tableData('Libellé :', cattributes => 'class="enteteFormulaire"');
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
				htp.anchor('pq_ui_codification.manage_codification_with_menu', 'Retourner à la gestion des codifications');
			pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusée.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Saisie d''une nouvelle codification');
	END form_add_codification;
	
	
	-- Affiche le formulaire de saisie permettant la modification d’une codification
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
				htp.print('<div class="titre_niveau_1">');
					htp.print('Mise à jour d''une codification');
				htp.print('</div>');					
				htp.br;
				htp.br;
				htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_codification.exec_upd_codification', 'POST', cattributes => 'onSubmit="return validerCodification(this,document)"');
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
					htp.tableData('Libellé :');	
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
				htp.anchor('pq_ui_codification.manage_codification_with_menu', 'Retourner à la gestion des codification');
			pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusée.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Modification d''une codification');
	END form_upd_codification;

END pq_ui_codification;
/