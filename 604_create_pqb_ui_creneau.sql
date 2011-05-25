-- -----------------------------------------------------------------------------
--           Cr�ation du corps du package d'affichage des donn�es
--           pour la table CRENEAU
--                      Oracle Version 10g
--                        (10/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de derni�re modification : 18/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pq_ui_creneau
AS
	--Permet d'afficher tous les cr�neaux et les actions possibles de gestion (avec le menu)
	PROCEDURE manage_creneaux_with_menu
	IS		
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
        pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		pq_ui_commun.aff_header;
			pq_ui_creneau.manage_creneaux;
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�e.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Gestion des cr�neaux');
	END manage_creneaux_with_menu;

	--Permet d'afficher tous les cr�neaux et les actions possibles de gestion (sans le menu)
	PROCEDURE manage_creneaux
	IS
		CURSOR listCreneaux IS
		SELECT 
			CRE.HEURE_DEBUT_CRENEAU
		  , CRE.HEURE_FIN_CRENEAU 
		FROM 
			CRENEAU CRE
		ORDER BY 
			1
		  , 2;
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
        pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		htp.br;				
		htp.print('Gestion des cr�neaux' || ' (' || htf.anchor('pq_ui_creneau.manage_creneaux_with_menu','Actualiser')|| ')' );
		htp.br;	
		htp.br;	
		htp.print(htf.anchor('pq_ui_creneau.form_add_creneau','Ajouter un cr�neau'));
		htp.br;	
		htp.br;	
		htp.formOpen('',cattributes => 'class="tableau"');
			htp.tableOpen;
			htp.tableheader('Heure de d�but');
			htp.tableheader('Heure de fin');
			htp.tableheader('Informations');
			htp.tableheader('Mise � jour');
			htp.tableheader('Suppression');
			for currentCreneau in listCreneaux loop
				htp.tableRowOpen;
				htp.tabledata(currentCreneau.HEURE_DEBUT_CRENEAU);
				htp.tabledata(currentCreneau.HEURE_FIN_CRENEAU);					
				htp.tabledata(htf.anchor('pq_ui_creneau.dis_creneau?vheureDebutCreneau='||currentCreneau.HEURE_DEBUT_CRENEAU||'&'||'vheureFinCreneau='||currentCreneau.HEURE_FIN_CRENEAU,'Informations'));
				htp.tabledata(htf.anchor('pq_ui_creneau.form_upd_creneau?vheureDebutCreneau='||currentCreneau.HEURE_DEBUT_CRENEAU||'&'||'vheureFinCreneau='||currentCreneau.HEURE_FIN_CRENEAU,'Mise � jour'));
				htp.tabledata(htf.anchor('pq_ui_creneau.exec_del_creneau?vheureDebutCreneau='||currentCreneau.HEURE_DEBUT_CRENEAU,'Supprimer', cattributes => 'onClick="return confirmerChoix(this,document)"'));
				htp.tableRowClose;
			end loop;	
			htp.tableClose;
		htp.formClose;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�e.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Gestion des cr�neaux');
	END manage_creneaux;
	
	--Permet d�afficher un cr�neau existant
	PROCEDURE dis_creneau(
	  vheureDebutCreneau IN CHAR
	, vheureFinCreneau IN CHAR)
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
				htp.print('Affichage des informations d''un cr�neau' || ' (' || htf.anchor('pq_ui_creneau.dis_creneau?vheureDebutCreneau='||vheureDebutCreneau||'&'||'vheureFinCreneau='||vheureFinCreneau,'Actualiser')|| ')' );
				htp.br;
				htp.br;					
				htp.print('Le cr�neau commence � '|| vheureDebutCreneau || ' et se termine � '|| vheureFinCreneau || '.');
				htp.br;
				htp.br;		
				htp.anchor('pq_ui_creneau.manage_creneaux_with_menu', 'Retourner � la gestion des cr�neaux');	
			pq_ui_commun.aff_footer;
	EXCEPTION
	WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�e.');
	END dis_creneau;
	
	-- Ex�cute la proc�dure d'ajout d'un cr�neau et g�re les erreurs �ventuelles.
	PROCEDURE exec_add_creneau(
	  vheureDebutCreneau IN CHAR
	, vheureFinCreneau IN CHAR)
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
				pq_db_creneau.add_creneau(vheureDebutCreneau,vheureFinCreneau);
				htp.print('Le cr�neau qui commence � '|| vheureDebutCreneau || ' et qui se termine � '|| vheureFinCreneau || ' a �t� ajout� avec succ�s.');
				htp.br;
				htp.br;			
				pq_ui_creneau.manage_creneaux;
			pq_ui_commun.aff_footer;
	EXCEPTION
		--Traitement personnalis�e de l'erreur :
			-- Nom Exception: DUP_VAL_ON_INDEX, Erreur oracle : ORA-00001, Code erreur : -1
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�e.');
		WHEN DUP_VAL_ON_INDEX THEN
			pq_ui_commun.dis_error_custom('Le cr�neau n''a pas �t� ajout�','Un cr�neau existe d�j� avec une heure de d�but qui vaut '|| vheureDebutCreneau ||'.','Merci de choisir une autre valeur de d�but de cr�neau.','pq_ui_creneau.form_add_creneau','Retour vers la cr�ation d''un cr�neau');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Ajout d''un cr�neau en cours...');
	END exec_add_creneau;
	
	-- Ex�cute la proc�dure de mise � jour d'un cr�neau et g�re les erreurs �ventuelles
	PROCEDURE exec_upd_creneau(
	  vheureDebutCreneau IN CHAR
	, vheureFinCreneau IN CHAR)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
        pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
				htp.br;				
				pq_db_creneau.upd_creneau(vheureDebutCreneau,vheureFinCreneau);
				htp.print('Le cr�neau qui commence � '|| vheureDebutCreneau || ' et qui se termine � '|| vheureFinCreneau || ' a �t� mis � jour avec succ�s.');
				htp.br;
				htp.br;			
				pq_ui_creneau.manage_creneaux;
			pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�e.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Mise � jour d''un cr�neau en cours...');
	END exec_upd_creneau;
	
	-- Ex�cute la proc�dure de suppression d'un cr�neau et g�re les erreurs �ventuelles
	PROCEDURE exec_del_creneau(
	  vheureDebutCreneau IN CHAR)
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
				pq_db_creneau.del_creneau(vheureDebutCreneau);
				htp.print('Le cr�neau qui commen�ait � '|| vheureDebutCreneau || ' a �t� supprim� avec succ�s.');
				htp.br;
				htp.br;			
				pq_ui_creneau.manage_creneaux;
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�e.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Suppression d''un cr�neau en cours...');
	END exec_del_creneau;
	  
	-- Ex�cute la proc�dure d�affichage des cr�neaux et g�re les erreurs �ventuelles
	PROCEDURE exec_dis_creneau(
	  vheureDebutCreneau IN CHAR
	, vheureFinCreneau IN CHAR)
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
				pq_ui_creneau.dis_creneau(vheureDebutCreneau,vheureFinCreneau);
				htp.br;		
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�e.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Affichage d''un cr�neau en cours...');
	END exec_dis_creneau;
	
	-- Affiche le formulaire permettant la saisie d�un nouveau cr�neau	
	PROCEDURE form_add_creneau
	IS		 
		currentStartHour NUMBER(2) := 0;
		currentStartMinute NUMBER(2) := 0;
		currentEndHour NUMBER(2) := 0;
		currentEndMinute NUMBER(2) := 0;
		complement VARCHAR2(1):= '0';
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		pq_ui_commun.aff_header;
				htp.br;
				htp.print('Cr�ation d''un nouveau cr�neau' || ' (' || htf.anchor('pq_ui_creneau.form_add_creneau','Actualiser')|| ')' );
				htp.br;
				htp.br;
				htp.print('Les champs marqu�s d''une �toile sont obligatoires.');
				htp.br;
				htp.br;
				htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_creneau.exec_add_creneau', 'GET', cattributes => 'onSubmit="return validerCreneau(this,document)"');
					--Ces deux champs sont mis � jour apr�s la validation et la v�rification du formulaire
					htp.formhidden ('vheureDebutCreneau','00h00', cattributes => 'id="idVheureDebutCreneau"');
					htp.formhidden ('vheureFinCreneau','00h00', cattributes => 'id="idVheureFinCreneau"');
					htp.tableOpen;
					htp.tableheader('');
					htp.tableheader('');
					htp.tableheader('');					
					htp.tableRowOpen;
						htp.tableData('Heure de d�but * :', cattributes => 'class="enteteFormulaire"');
						htp.print('<td>');
							htp.print('<select id="vheureDebut">');								
							FOR currentStartHour in 6..23 loop	
								IF currentStartHour < 10 THEN
									complement := '0';
								ELSE
									complement := '';
								END IF;
								htp.print('<option value="'||complement||currentStartHour||'">'||currentStartHour||'</option>');								
							END LOOP; 																				
							htp.print('</select>');		
							htp.print(' Heure(s) ');
							htp.print('<select id="vminuteDebut">');								
							LOOP 																
								IF currentStartMinute < 10 THEN
									complement := '0';
								ELSE
									complement := '';
								END IF;
								htp.print('<option value="'||complement||currentStartMinute||'">'||currentStartMinute||'</option>');								
								currentStartMinute := currentStartMinute + 15 ; -- Tranche de 15 minutes seulement
								IF currentStartMinute >= 60 THEN
									EXIT;
								END IF;
							END LOOP; 																				
							htp.print('</select>');		
							htp.print(' Minutes(s) ');							
						htp.print('</td>');	
						htp.tableData('',cattributes => 'id="vheureDebutError" class="error"');						
					htp.tableRowClose;	
					htp.tableRowOpen;
						htp.tableData('Heure de fin :', cattributes => 'class="enteteFormulaire"');
						htp.print('<td>');
							htp.print('<select id="vheureFin">');								
							FOR currentEndHour in 6..23 loop								
								IF currentEndHour < 10 THEN
									complement := '0';
								ELSE
									complement := '';
								END IF;
								htp.print('<option value="'||complement||currentEndHour||'">'||currentEndHour||'</option>');								
							END LOOP; 																				
							htp.print('</select>');		
							htp.print(' Heure(s) ');
							htp.print('<select id="vminuteFin">');								
							LOOP 																
								IF currentEndMinute < 10 THEN
									complement := '0';
								ELSE
									complement := '';
								END IF;
								htp.print('<option value="'||complement||currentEndMinute||'">'||currentEndMinute||'</option>');								
								currentEndMinute := currentEndMinute + 15 ; -- Tranche de 15 minutes seulement
								IF currentEndMinute >= 60 THEN
									EXIT;
								END IF;
							END LOOP; 																				
							htp.print('</select>');		
							htp.print(' Minutes(s) ');						
						htp.print('</td>');	
						htp.tableData('',cattributes => 'id="vheureFinError" class="error"');							
					htp.tableRowClose;
					htp.tableRowOpen;
						htp.tableData('');
						htp.tableData(htf.formSubmit(NULL,'Validation'));
					htp.tableRowClose;
					htp.tableClose;
				htp.formClose;
				htp.br;
				htp.anchor('pq_ui_creneau.manage_creneaux_with_menu', 'Retourner � la gestion des cr�neaux');
			pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�e.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Saisie d''un nouveau cr�neau');
	END form_add_creneau;
	
	
	-- Affiche le formulaire de saisie permettant la modification d�un cr�neau existant
	PROCEDURE form_upd_creneau(
	  vheureDebutCreneau IN CHAR
	, vheureFinCreneau IN CHAR)
	IS
		currentStartHour CHAR(3) := pq_ui_creneau.get_heure(vheureDebutCreneau);
		currentStartMinute CHAR(3) := pq_ui_creneau.get_minute(vheureDebutCreneau);
		currentEndHour NUMBER(2) := 0;
		lastEndHour NUMBER(2) := TO_NUMBER(pq_ui_creneau.get_heure(vheureFinCreneau));
		currentEndMinute NUMBER(2) := 0;
		lastEndMinute NUMBER(2) := TO_NUMBER(pq_ui_creneau.get_minute(vheureFinCreneau));
		complement VARCHAR2(1):= '0';
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		pq_ui_commun.aff_header;
				htp.br;
				htp.print('Mise � jour d''un cr�neau' || ' (' || htf.anchor('pq_ui_creneau.form_upd_creneau?vheureDebutCreneau='||vheureDebutCreneau||'&'||'vheureFinCreneau='||vheureFinCreneau,'Actualiser')|| ')' );
				htp.br;
				htp.br;
				htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_creneau.exec_upd_creneau', 'GET', cattributes => 'onSubmit="return validerMAJCreneau(this,document)"');
					htp.formhidden ('vheureDebutCreneau',vheureDebutCreneau);
					htp.formhidden ('vheureFinCreneau','00h00', cattributes => 'id="idVheureFinCreneau"');
					htp.tableOpen;
					htp.tableheader('');
					htp.tableheader('');
					htp.tableheader('');					
					htp.tableRowOpen;
						htp.tableData('Heure de d�but * :', cattributes => 'class="enteteFormulaire"');
						htp.print('<td>');
							htp.print('<select id="vheureDebut">');								
								htp.print('<option value="'||currentStartHour||'">'||currentStartHour||'</option>');																				
							htp.print('</select>');		
							htp.print(' Heure(s) ');
							htp.print('<select id="vminuteDebut">');					
								htp.print('<option value="'||currentStartMinute||'">'||currentStartMinute||'</option>');																								
							htp.print('</select>');		
							htp.print(' Minutes(s) ');							
						htp.print('</td>');	
						htp.tableData('',cattributes => 'id="vheureDebutError" class="error"');						
					htp.tableRowClose;		
					htp.tableRowOpen;
						htp.tableData('Heure de fin :', cattributes => 'class="enteteFormulaire"');
						htp.print('<td>');
							htp.print('<select id="vheureFin">');								
							FOR currentEndHour in 6..23 loop								
								IF currentEndHour < 10 THEN
									complement := '0';
								ELSE
									complement := '';
								END IF;
								htp.print('<option value="'||complement||currentEndHour||'"');
								IF(lastEndHour=currentEndHour) THEN
									--Valeur s�lectionn�e par d�faut
									htp.print(' selected="selected"'); 
								END IF;
								htp.print('>'||currentEndHour||'</option>');								
							END LOOP; 																				
							htp.print('</select>');		
							htp.print(' Heure(s) ');
							htp.print('<select id="vminuteFin">');								
							LOOP 																
								IF currentEndMinute < 10 THEN
									complement := '0';
								ELSE
									complement := '';
								END IF;
								htp.print('<option value="'||complement||currentEndMinute||'"');
								IF(lastEndMinute=currentEndMinute) THEN
									--Valeur s�lectionn�e par d�faut
									htp.print(' selected="selected"'); 
								END IF;
								htp.print('>'||currentEndMinute||'</option>');																
								currentEndMinute := currentEndMinute + 15 ; -- Tranche de 15 minutes seulement
								IF currentEndMinute >= 60 THEN
									EXIT;
								END IF;
							END LOOP; 																				
							htp.print('</select>');		
							htp.print(' Minutes(s) ');						
						htp.print('</td>');	
						htp.tableData('',cattributes => 'id="vheureFinError" class="error"');							
					htp.tableRowClose;
					htp.tableRowOpen;
						htp.tableData('');
						htp.tableData(htf.formSubmit(NULL,'Validation'));
					htp.tableRowClose;
					htp.tableClose;
				htp.formClose;
				htp.br;
				htp.anchor('pq_ui_creneau.manage_creneaux_with_menu', 'Retourner � la gestion des cr�neaux');
			pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�e.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Modification d''un cr�neau');
	END form_upd_creneau;
	
	-- Fonction permettant d'extraire les heures d'un cr�neau
	FUNCTION get_heure(
		vcreneau IN CHAR
	)
	RETURN CHAR
	IS
		heure CHAR(3):= '00'; 
	BEGIN
		heure := substr(vcreneau, 1, 2); 
		return heure;
	END;
	
	-- Fonction permettant d'extraire les minutes d'un cr�neau
	FUNCTION get_minute(
		vcreneau IN CHAR
	)
	RETURN CHAR
	IS
		minutes CHAR(3):= '00'; 
	BEGIN
		minutes := substr(vcreneau, 4, 2); 
		return minutes;
	END;
	
END pq_ui_creneau;
/