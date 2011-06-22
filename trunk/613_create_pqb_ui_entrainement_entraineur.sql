-- -----------------------------------------------------------------------------
--           Création du package d'interface d'affichage des données
--           pour la table ENTRAINEMENT
--                      Oracle Version 10g
--                        (10/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 14/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pq_ui_entrainement_entraineur
IS
	
	--affichage de la liste seule des entrainements d'un entraineur
	PROCEDURE aff_entrainement_entraineur(
		vnumEntraineur IN NUMBER)
	IS
		CURSOR listEntrainement IS
		SELECT 
			E.NUM_ENTRAINEMENT
		   ,E.LIB_ENTRAINEMENT
		   ,E.CODE_NIVEAU
		   ,E.NATURE_NIVEAU
		   ,E.NB_PLACE_ENTRAINEMENT
		   ,E.DATE_DEBUT_ENTRAINEMENT
		   ,E.DATE_FIN_ENTRAINEMENT
		FROM 
			ENTRAINEMENT E INNER JOIN PERSONNE P
			ON E.NUM_ENTRAINEUR=P.NUM_PERSONNE
		WHERE
			TRUNC(DATE_FIN_ENTRAINEMENT)>=TRUNC(SYSDATE)
			AND P.NUM_PERSONNE = vnumEntraineur
		ORDER BY 
			NUM_ENTRAINEMENT;
		
		vnomEntraineur VARCHAR2(20);
	BEGIN
		htp.br;		
		htp.print('<div class="titre_niveau_1">');
			htp.print('Gestion des entrainements');
		htp.print('</div>');			
		htp.br;
		htp.br;	
		htp.print(htf.anchor('pq_ui_entrainement_entraineur.form_add_entrainement_entr','Ajouter un entrainement'));
		htp.br;	
		htp.br;
		htp.tableOpen('',cattributes => 'class="tableau"');
			htp.tableheader('Numéro');
			htp.tableheader('Intitulé');
			htp.tableheader('Informations');
			htp.tableheader('Mise à jour');
			htp.tableheader('Suppression');
			for currentEntrainement in listEntrainement loop
				htp.tableRowOpen;
				htp.tabledata(currentEntrainement.NUM_ENTRAINEMENT);	
				htp.tabledata(currentEntrainement.LIB_ENTRAINEMENT);
				htp.tabledata(htf.anchor('pq_ui_entrainement_entraineur.exec_dis_entrainement_entr?vnumEntrainement='||currentEntrainement.NUM_ENTRAINEMENT,'Informations'));
				htp.tabledata(htf.anchor('pq_ui_entrainement_entraineur.form_upd_entrainement_entr?vnumEntrainement='||currentEntrainement.NUM_ENTRAINEMENT,'Mise à jour'));
				htp.tabledata(htf.anchor('pq_ui_entrainement_entraineur.exec_del_entrainement_entr?vnumEntrainement='||currentEntrainement.NUM_ENTRAINEMENT,'Supprimer', cattributes => 'onClick="return confirmerChoix(this,document)"'));
				htp.tableRowClose;	
			end loop;
		htp.tableClose;
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Gestion des entrainements');
	END aff_entrainement_entraineur;
	
	--Permet d'afficher tous les entrainements de l'entraineur
	PROCEDURE manage_entrainement_entraineur
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		target_cookie OWA_COOKIE.cookie;
		vnumEntraineur NUMBER(5);
	BEGIN	
        pq_ui_commun.ISAUTHORIZED(niveauP=>0,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
        pq_ui_commun.aff_header;
		target_cookie := OWA_COOKIE.get('numpersonne');
		vnumEntraineur:=TO_NUMBER(target_cookie.vals(1));
		aff_entrainement_entraineur(vnumEntraineur);
		htp.br; 
		htp.br;
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error_permission_denied;
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Gestion des entrainements');
	END manage_entrainement_entraineur;	
	
	-- Exécute la procédure d’affichage des entrainements et gère les erreurs éventuelles
	PROCEDURE exec_dis_entrainement_entr(
	  vnumEntrainement IN NUMBER)
	IS		
		PERMISSION_DENIED EXCEPTION;
		perm BOOLEAN;
	BEGIN
        pq_ui_commun.ISAUTHORIZED(niveauP=>0,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
        pq_ui_commun.aff_header;
		htp.br;				
		pq_ui_entrainement_entraineur.dis_entrainement_entr(vnumEntrainement);	
		htp.br;		
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error_permission_denied;
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Affichage de l''entrainement en cours...');
	END exec_dis_entrainement_entr;
	
	-- Exécute la procédure d'ajout d'un entrainement et gère les erreurs éventuelles.
	PROCEDURE exec_add_entrainement_entr(
	  vnumEntraineur IN NUMBER
	, vcodeNiveau IN CHAR
	, vnatureNiveau IN CHAR
	, vlibEntrainement IN VARCHAR2
	, vnbPlaces IN NUMBER
	, vdateDebut IN VARCHAR2
	, vdateFin IN VARCHAR2)
	IS
		sequenceNumEntrainement NUMBER(6);
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
        pq_ui_commun.ISAUTHORIZED(niveauP=>0,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
        pq_ui_commun.aff_header;
		pq_db_entrainement.add_entrainement(vnumEntraineur,vcodeNiveau,vnatureNiveau,vlibEntrainement,vnbPlaces,to_date(vdateDebut, 'dd/mm/yy'),to_date(vdateFin, 'dd/mm/yy'));
		htp.br;
		htp.print('<div class="success"> ');
			htp.print('L''entrainement a été créé avec succès');
		htp.print('</div>');			
		htp.br;
		htp.br;
		SELECT SEQ_ENTRAINEMENT.currval INTO sequenceNumEntrainement FROM dual;
		pq_ui_entrainement_entraineur.dis_entrainement_entr(sequenceNumEntrainement);
		htp.br();
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error_permission_denied;
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Ajout d''un entrainement en cours...');
	END exec_add_entrainement_entr;
	
	-- Exécute la procédure de mise à jour d'un entrainement et gère les erreurs éventuelles
	PROCEDURE exec_upd_entrainement_entr(
	  vnumEntrainement IN NUMBER
	, vcodeNiveau IN CHAR
	, vnatureNiveau IN CHAR
	, vlibEntrainement IN VARCHAR2
	, vnbPlaces IN NUMBER)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		target_cookie OWA_COOKIE.cookie;
		vnumEntraineur NUMBER(5);
	BEGIN
		pq_ui_commun.aff_header;
        pq_ui_commun.ISAUTHORIZED(niveauP=>0,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		target_cookie := OWA_COOKIE.get('numpersonne');
		vnumEntraineur:=TO_NUMBER(target_cookie.vals(1));
		pq_db_entrainement.upd_entrainement(vnumEntrainement,vnumEntraineur,vcodeNiveau,vnatureNiveau,vlibEntrainement,vnbPlaces);
		htp.br;
		htp.print('<div class="success"> ');
			htp.print('L''entrainement n° '|| vnumEntrainement || ' a été modifié avec succès.');
		htp.print('</div>');		
		htp.br();
		htp.br();
		pq_ui_entrainement_entraineur.aff_entrainement_entraineur(vnumEntraineur);
		htp.br();
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error_permission_denied;
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Modification de l''entrainement en cours...');
	END exec_upd_entrainement_entr;

	-- Exécute la procédure de suppression d'un entrainement et gère les erreurs éventuelles
	PROCEDURE exec_del_entrainement_entr(
	  vnumEntrainement IN NUMBER)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		target_cookie OWA_COOKIE.cookie;
		vnumEntraineur NUMBER(5);
	BEGIN
        pq_ui_commun.ISAUTHORIZED(niveauP=>0,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		target_cookie := OWA_COOKIE.get('numpersonne');
		vnumEntraineur:=TO_NUMBER(target_cookie.vals(1));
        pq_ui_commun.aff_header;
		--supprimer l'entrainement
		pq_db_entrainement.del_entrainement(vnumEntrainement);
		htp.br;
		htp.print('<div class="success"> ');
			htp.print('L''entrainement n° '|| vnumEntrainement || ' a été supprimé avec succès.');
		htp.print('</div>');		
		htp.br;
		htp.br;			
		pq_ui_entrainement_entraineur.aff_entrainement_entraineur(vnumEntraineur);
		htp.br;
		htp.br;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error_permission_denied;
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Suppression d''un entrainement en cours...');
	END exec_del_entrainement_entr;
	
	--Permet d’afficher les informations d'un entrainement de l'entraineur
	
	PROCEDURE dis_entrainement_entr(
	  vnumEntrainement IN NUMBER)
	IS
		vlibelleNiveau CODIFICATION.LIBELLE%TYPE;
		vnbplaces ENTRAINEMENT.NB_PLACE_ENTRAINEMENT%TYPE;
		vdateDebut ENTRAINEMENT.DATE_DEBUT_ENTRAINEMENT%TYPE;
		vdateFin ENTRAINEMENT.DATE_FIN_ENTRAINEMENT%TYPE;
		vlibEntrainement ENTRAINEMENT.LIB_ENTRAINEMENT%TYPE;
		
		vnbSeance NUMBER (3);
		CURSOR listSeance IS 
		SELECT 
			NUM_JOUR
		  , HEURE_DEBUT_CRENEAU
		  , NUM_TERRAIN 
		FROM 
			AVOIR_LIEU 
		WHERE 
			NUM_ENTRAINEMENT=vnumEntrainement 
		ORDER BY 
			NUM_JOUR;
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
        pq_ui_commun.ISAUTHORIZED(niveauP=>0,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;

		SELECT 
			E.LIB_ENTRAINEMENT
		  , C.LIBELLE
		  , E.NB_PLACE_ENTRAINEMENT
		  , E.DATE_DEBUT_ENTRAINEMENT
		  , E.DATE_FIN_ENTRAINEMENT 
		INTO 
			vlibEntrainement
		  , vlibelleNiveau
		  , vnbplaces
		  , vdateDebut
		  , vdateFin
		FROM 
			ENTRAINEMENT E
				INNER JOIN CODIFICATION C
				ON  E.NATURE_NIVEAU = C.NATURE
				AND E.CODE_NIVEAU   = C.CODE
		WHERE 
			E.NUM_ENTRAINEMENT = vnumEntrainement;
		
		SELECT 
			COUNT(*) 
		INTO 
			vnbSeance 
		FROM 
			AVOIR_LIEU 
		WHERE 
			NUM_ENTRAINEMENT=vnumEntrainement;
			
		htp.br;	
		htp.print('<div class="titre_niveau_1">');
			htp.print('Affichage des informations d''un entrainement');
		htp.print('</div>');			
		htp.br;
		htp.br;						
		htp.print('Description de l''entrainement numéro '|| vnumEntrainement || ' : '||vlibEntrainement);
		htp.br;
		htp.print('L''entrainement s''adresse aux joueurs possèdant au moins le niveau : '|| vlibelleNiveau || '.');
		htp.br;
		htp.print('Le nombre de places disponibles est de : '|| vnbPlaces || '.');
		htp.br;
		htp.print('Il a lieu entre le  : '|| TO_CHAR(vdateDebut,'DD/MM/YYYY') || ' et le ' || TO_CHAR(vdateFin,'DD/MM/YYYY') ||'.');
		htp.br;
		htp.br;
		htp.print('Séances   : ');
		htp.tableOpen;
		if(vnbSeance=0)
		then
			htp.tableRowOpen;
			htp.print('<td>');
			htp.print('L''entrainement n''a pas encore de séance.');
			htp.print('</td>');
			htp.tableRowClose;
		else
			for currentSeance in listSeance loop
				htp.tableRowOpen;
				htp.print('<td>');
				htp.print('   *   ' || 'Le ');
				if(currentSeance.NUM_JOUR=1)
				then
					htp.print('lundi ');
				end if;
				if(currentSeance.NUM_JOUR=2)
				then
					htp.print('mardi ');
				end if;
				if(currentSeance.NUM_JOUR=3)
				then
					htp.print('mercredi ');
				end if;
				if(currentSeance.NUM_JOUR=4)
				then
					htp.print('jeudi ');
				end if;
				if(currentSeance.NUM_JOUR=5)
				then
					htp.print('vendredi ');
				end if;
				if(currentSeance.NUM_JOUR=6)
				then
					htp.print('samedi ');
				end if;
				if(currentSeance.NUM_JOUR=7)
				then
					htp.print('dimanche ');
				end if;
				htp.print(' à ' || currentSeance.HEURE_DEBUT_CRENEAU || ' sur le terrain numéro ' || currentSeance.NUM_TERRAIN || '.' );	
				htp.tabledata(htf.anchor('pq_ui_avoir_lieu.exec_del_avoir_lieu?vnumJour='||currentSeance.NUM_JOUR||'&'||'vheureDebutCreneau='||
				currentSeance.HEURE_DEBUT_CRENEAU||'&'||'vnumTerrain='||currentSeance.NUM_TERRAIN||'&'||'vnumEntrainement='||vnumEntrainement 
				||'&'||'vretourEntraineur=1','Supprimer',cattributes => 'onClick="return confirmerChoix(this,document)"'));
				htp.print('</td>');
				htp.tableRowClose;
				htp.br;
			end loop;
		end if;
		htp.br;	
		htp.tableClose;
		htp.br;
		htp.br;
		htp.anchor('pq_ui_avoir_lieu.form_add_avoir_lieu?vnumEntrainement='||vnumEntrainement||'&'||'vretourEntraineur=1', 'Ajouter une séance');	
		htp.br;
		htp.br;
		htp.anchor('pq_ui_entrainement_entraineur.manage_entrainement_entraineur', 'Retourner à la gestion des entrainements');
		htp.br; 
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error_permission_denied;
	END dis_entrainement_entr;
	
	-- Affiche le formulaire permettant la saisie d’un nouvel entrainement
	PROCEDURE form_add_entrainement_entr
	IS
		--On stocke les informations de nature et de code des niveaux dans le curseur niveauList		
		CURSOR niveaulist 
		IS 
		SELECT 
			C.NATURE
		  , C.CODE
		  , C.LIBELLE
		FROM 
			CODIFICATION C
		WHERE 
			C.NATURE = 'Classement';
			
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		target_cookie OWA_COOKIE.cookie;
		num_entraineur NUMBER(5);
		currentPlace NUMBER(2) := 0;
		currentYearStart NUMBER(4) := to_number(to_char(sysdate,'YYYY'));
		currentYearEnd NUMBER(4) := to_number(to_char(sysdate,'YYYY'))+10;
		currentDebutDay NUMBER(2) := 0;
		currentDebutMonth NUMBER(2) := 0;
		currentDebutYear NUMBER(4) := 0;
		currentFinDay NUMBER(2) := 0;
		currentFinMonth NUMBER(2) := 0;
		currentFinYear NUMBER(4) := 0;
		
		vday NUMBER(2) := to_number(to_char(sysdate,'DD'));
		vmonth NUMBER(2) := to_number(to_char(sysdate,'MM'));
		vyear NUMBER(4) := to_number(to_char(sysdate,'YYYY'));
		
	BEGIN
        pq_ui_commun.ISAUTHORIZED(niveauP=>0,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
        pq_ui_commun.aff_header;	
		target_cookie := OWA_COOKIE.get('numpersonne');
		num_entraineur:=TO_NUMBER(target_cookie.vals(1));
			htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_entrainement_entraineur.exec_add_entrainement_entr', 'POST', cattributes => 'onSubmit="return validerEntrainement(this,document)"');				
				htp.formhidden ('vdateDebut','01/01/1970', cattributes => 'id="idVdateDebut"');
				htp.formhidden ('vdateFin','01/01/1970', cattributes => 'id="idVdateFin"');		
				htp.formhidden ('vnatureNiveau','Classement', cattributes => 'id="idVnatureNiveau"');	
				htp.formhidden ('vcodeNiveau','1', cattributes => 'id="idVcodeNiveau"');				
				htp.br;
				htp.print('<div class="titre_niveau_1">');
					htp.print('Création d''un nouvel entrainement');
				htp.print('</div>');				
				htp.br;
				htp.br;
				htp.print('Les champs marqués d''une étoile sont obligatoires.');
				htp.br;
				htp.tableOpen;
				htp.br;				
				htp.formhidden('vnumEntraineur',num_entraineur);
				htp.tableRowOpen;
				htp.tableData('Niveau * :');
					--Forme une liste déroulante avec tous les niveaux de la table codification								
					htp.print('<td>');
					htp.print('<select id="idVcodeEtNatureNiveau">');		
					for currentNiveau in niveaulist loop			
							--La valeur, qui sera envoyée à la fonction javascript, contiendra le code et la nature du niveau
							--Cependant, l'utilisateur ne verra que la nature du niveau dans la liste déroulante
							htp.print('<option value="'||currentNiveau.CODE||'*'||currentNiveau.NATURE||'">'||currentNiveau.LIBELLE||'</option>');
					end loop;
					htp.print('</select>');										
					htp.print('</td>');							
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Libellé * :');	
					htp.print('<td>');					
					htp.formText('vlibEntrainement',20,cattributes => 'maxlength="50"');										
					htp.print('</td>');	
					htp.tableData('',cattributes => 'id="vlibEntrainementError" class="error"');						
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Nombre de places * :');	
					htp.print('<td>');
					htp.print('<select name="vnbPlaces" id="vnbPlaces">');								
					FOR currentPlace in 1..99 loop	
						htp.print('<option value="'||currentPlace||'">'||currentPlace||'</option>');								
					END LOOP; 																				
					htp.print('</select>');	
					htp.print('</td>');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Date de début * :');	
					htp.print('<td>');	
					htp.print('<select id="vdateDebutDay">');
					FOR currentDebutDay in 1..31 loop		
						IF currentDebutDay = vday THEN
								htp.print('<option selected>'||currentDebutDay||'</option>');
							ELSE
								htp.print('<option>'||currentDebutDay||'</option>');
						END IF;						
					END LOOP; 					 																				
					htp.print('</select>');	
					htp.print('<select id="vdateDebutMonth">');								
					FOR currentDebutMonth in 1..12 loop	
						IF currentDebutMonth = vmonth THEN
								htp.print('<option selected>'||currentDebutMonth||'</option>');
							ELSE
								htp.print('<option>'||currentDebutMonth||'</option>');
						END IF;							
					END LOOP; 																				
					htp.print('</select>');	
					htp.print('<select id="vdateDebutYear">');								
					FOR currentDebutYear in currentYearStart..currentYearEnd loop	
						IF currentDebutYear = vyear THEN
								htp.print('<option selected>'||currentDebutYear||'</option>');
							ELSE
								htp.print('<option>'||currentDebutYear||'</option>');
						END IF;	
					END LOOP;																				
					htp.print('</select>');	
					htp.print('</td>');		
					htp.tableData('',cattributes => 'id="vDateDebutEntrainementError" class="error"');							
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Date de fin * :');	
					htp.print('<td>');	
					htp.print('<select id="vdateFinDay">');								
					FOR currentFinDay in 1..31 loop		
						IF currentFinDay = vday THEN
								htp.print('<option selected>'||currentFinDay||'</option>');
							ELSE
								htp.print('<option>'||currentFinDay||'</option>');
						END IF;						
					END LOOP; 																			
					htp.print('</select>');	
					htp.print('<select id="vdateFinMonth">');								
					FOR currentFinMonth in 1..12 loop	
						IF currentFinMonth = vmonth THEN
								htp.print('<option selected>'||currentFinMonth||'</option>');
							ELSE
								htp.print('<option>'||currentFinMonth||'</option>');
						END IF;							
					END LOOP;																				
					htp.print('</select>');	
					htp.print('<select id="vdateFinYear">');								
					FOR currentFinYear in currentYearStart..currentYearEnd loop	
						IF currentFinYear = vyear+1 THEN
								htp.print('<option selected>'||currentFinYear||'</option>');
							ELSE
								htp.print('<option>'||currentFinYear||'</option>');
						END IF;	
					END LOOP;																					
					htp.print('</select>');	
					htp.print('</td>');		
					htp.tableData('',cattributes => 'id="vDateFinEntrainementError" class="error"');						
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('');
					htp.tableData(htf.formSubmit(NULL,'Validation'));
				htp.tableRowClose;
				htp.tableClose;
			htp.formClose;
			htp.br;
			htp.anchor('pq_ui_entrainement_entraineur.manage_entrainement_entraineur', 'Retourner à la gestion des entrainements');
			htp.br; 
			htp.br;
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error_permission_denied;
	END form_add_entrainement_entr;
	
	-- Affiche le formulaire de saisie permettant la modification d’un entrainement existant	
	PROCEDURE form_upd_entrainement_entr(
	  vnumEntrainement IN NUMBER)
	IS
		vcodeNiveau ENTRAINEMENT.CODE_NIVEAU%TYPE;
		vnatureNiveau ENTRAINEMENT.NATURE_NIVEAU%TYPE;
		vnbplaces ENTRAINEMENT.NB_PLACE_ENTRAINEMENT%TYPE;
		vlibEntrainement ENTRAINEMENT.LIB_ENTRAINEMENT%TYPE;		
		CURSOR niveaulist 
		IS 
		SELECT 
			C.LIBELLE
		  , C.CODE
		  , C.NATURE
		FROM 
			CODIFICATION C
		WHERE 
			C.NATURE = 'Classement';
			
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		currentPlace NUMBER(2) := 0;
	BEGIN
        pq_ui_commun.ISAUTHORIZED(niveauP=>0,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
        pq_ui_commun.aff_header;
		
		SELECT CODE_NIVEAU,NATURE_NIVEAU,LIB_ENTRAINEMENT,NB_PLACE_ENTRAINEMENT
		INTO vcodeNiveau,vnatureNiveau,vlibEntrainement,vnbplaces
		FROM ENTRAINEMENT WHERE NUM_ENTRAINEMENT = vnumEntrainement;
		
			htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_entrainement_entraineur.exec_upd_entrainement_entr', 'POST', cattributes => 'onSubmit="return validerUpdEntrainement(this,document)"');				
				htp.formhidden ('vnumEntrainement',vnumEntrainement);
				htp.formhidden ('vnatureNiveau','Classement', cattributes => 'id="idVnatureNiveau"');	
				htp.formhidden ('vcodeNiveau','1', cattributes => 'id="idVcodeNiveau"');	
				htp.br;
				htp.print('<div class="titre_niveau_1">');
					htp.print('Mise à jour de l''entrainement numéro ' || vnumEntrainement);
				htp.print('</div>');				
				htp.br;
				htp.br;
				htp.print('Les champs marqués d''une étoile sont obligatoires.');
				htp.br;
				htp.tableOpen;
				htp.br;				
				htp.tableData('Niveau * :');
					--Forme une liste déroulante avec tous les niveaux de la table codification								
					htp.print('<td>');
					htp.print('<select id="idVcodeEtNatureNiveau">');		
					for currentNiveau in niveaulist loop			
						--La valeur, qui sera envoyée à la fonction javascript, contiendra le code et la nature du niveau
						--Cependant, l'utilisateur ne verra que la nature du niveau dans la liste déroulante
						if(currentNiveau.CODE=vcodeNiveau)
						then
							htp.print('<option selected value="'||currentNiveau.CODE||'*'||currentNiveau.NATURE||'">'||currentNiveau.LIBELLE||'</option>');
						else
							htp.print('<option value="'||currentNiveau.CODE||'*'||currentNiveau.NATURE||'">'||currentNiveau.LIBELLE||'</option>');
						end if;							
					end loop;
					htp.print('</select>');										
					htp.print('</td>');						
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Libellé * :');	
					htp.print('<td>');	
					htp.print('<INPUT TYPE="text" name="vlibEntrainement" maxlength="50" value="'||vlibEntrainement||'"> ');													
					htp.print('</td>');	
					htp.tableData('',cattributes => 'id="vlibEntrainementError" class="error"');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Nombre de places * :');	
					htp.print('<td>');
					htp.print('<select name="vnbPlaces" id="vnbPlaces">');								
					FOR currentPlace in 1..99 loop	
						if(currentPlace=vnbPlaces)
						then
							htp.print('<option selected value="'||currentPlace||'">'||currentPlace||'</option>');	
						else
							htp.print('<option value="'||currentPlace||'">'||currentPlace||'</option>');
						end if;
					END LOOP;																			
					htp.print('</select>');	
					htp.print('</td>');
				htp.tableRowClose;
				htp.tableRowOpen;
				htp.tableData('');
				htp.tableData(htf.formSubmit(NULL,'Validation'));
				htp.tableRowClose;
				htp.tableClose;
			htp.formClose;
			htp.br;
			htp.anchor('pq_ui_entrainement_entraineur.manage_entrainement_entraineur', 'Retourner à la gestion des entrainements');
			htp.br; 
			htp.br;
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error_permission_denied;
	END form_upd_entrainement_entr;
		
END pq_ui_entrainement_entraineur;
/