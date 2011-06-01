-- -----------------------------------------------------------------------------
--           Cr�ation du package d'interface d'affichage des donn�es
--           pour la table ENTRAINEMENT
--                      Oracle Version 10g
--                        (10/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de derni�re modification : 14/05/2011
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
		htp.print('Gestion des entrainements' || ' (' || htf.anchor('pq_ui_entrainement_entraineur.manage_entrainement_entraineur','Actualiser')|| ')' );
		htp.br;
		htp.br;	
		htp.print(htf.anchor('pq_ui_entrainement_entraineur.form_add_entrainement_entr','Ajouter un entrainement'));
		htp.br;	
		htp.br;
		htp.tableOpen('',cattributes => 'class="tableau"');
			htp.tableheader('Num�ro');
			htp.tableheader('Intitul�');
			htp.tableheader('Informations');
			htp.tableheader('Mise � jour');
			htp.tableheader('Suppression');
			for currentEntrainement in listEntrainement loop
				htp.tableRowOpen;
				htp.tabledata(currentEntrainement.NUM_ENTRAINEMENT);	
				htp.tabledata(currentEntrainement.LIB_ENTRAINEMENT);
				htp.tabledata(htf.anchor('pq_ui_entrainement_entraineur.exec_dis_entrainement_entr?vnumEntrainement='||currentEntrainement.NUM_ENTRAINEMENT,'Informations'));
				htp.tabledata(htf.anchor('pq_ui_entrainement_entraineur.form_upd_entrainement_entr?vnumEntrainement='||currentEntrainement.NUM_ENTRAINEMENT,'Mise � jour'));
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
        pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
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
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Gestion des entrainements');
	END manage_entrainement_entraineur;	
	
	-- Ex�cute la proc�dure d�affichage des entrainements et g�re les erreurs �ventuelles
	PROCEDURE exec_dis_entrainement_entr(
	  vnumEntrainement IN NUMBER)
	IS		
		PERMISSION_DENIED EXCEPTION;
		perm BOOLEAN;
	BEGIN
        pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
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
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Affichage de l''entrainement en cours...');
	END exec_dis_entrainement_entr;
	
	-- Ex�cute la proc�dure d'ajout d'un entrainement et g�re les erreurs �ventuelles.
	PROCEDURE exec_add_entrainement_entr(
	  vnumEntraineur IN NUMBER
	, vcodeNiveau IN CHAR
	, vlibEntrainement IN VARCHAR2
	, vnbPlaces IN NUMBER
	, vdateDebut IN VARCHAR2
	, vdateFin IN VARCHAR2)
	IS
		sequenceNumEntrainement NUMBER(6);
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
        pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
        pq_ui_commun.aff_header;
		pq_db_entrainement.add_entrainement(vnumEntraineur,vcodeNiveau,vlibEntrainement,vnbPlaces,to_date(vdateDebut, 'dd/mm/yy'),to_date(vdateFin, 'dd/mm/yy'));
		htp.br;
		htp.print('L''entrainement a �t� cr�� avec succ�s');
		htp.br;
		htp.br;
		SELECT SEQ_ENTRAINEMENT.currval INTO sequenceNumEntrainement FROM dual;
		pq_ui_entrainement_entraineur.dis_entrainement_entr(sequenceNumEntrainement);
		htp.br();
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Ajout d''un entrainement en cours...');
	END exec_add_entrainement_entr;
	
	-- Ex�cute la proc�dure de mise � jour d'un entrainement et g�re les erreurs �ventuelles
	PROCEDURE exec_upd_entrainement_entr(
	  vnumEntrainement IN NUMBER
	, vcodeNiveau IN CHAR
	, vlibEntrainement IN VARCHAR2
	, vnbPlaces IN NUMBER)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		target_cookie OWA_COOKIE.cookie;
		vnumEntraineur NUMBER(5);
	BEGIN
		pq_ui_commun.aff_header;
        pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		target_cookie := OWA_COOKIE.get('numpersonne');
		vnumEntraineur:=TO_NUMBER(target_cookie.vals(1));
		pq_db_entrainement.upd_entrainement(vnumEntrainement,vnumEntraineur,vcodeNiveau,vlibEntrainement,vnbPlaces);
		htp.br;
		htp.print('L''entrainement n� '|| vnumEntrainement || ' a �t� modifi� avec succ�s.');
		htp.br();
		htp.br();
		pq_ui_entrainement_entraineur.aff_entrainement_entraineur(vnumEntraineur);
		htp.br();
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Modification de l''entrainement en cours...');
	END exec_upd_entrainement_entr;

	-- Ex�cute la proc�dure de suppression d'un entrainement et g�re les erreurs �ventuelles
	PROCEDURE exec_del_entrainement_entr(
	  vnumEntrainement IN NUMBER)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		target_cookie OWA_COOKIE.cookie;
		vnumEntraineur NUMBER(5);
	BEGIN
        pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		target_cookie := OWA_COOKIE.get('numpersonne');
		vnumEntraineur:=TO_NUMBER(target_cookie.vals(1));
        pq_ui_commun.aff_header;
		--supprimer l'entrainement
		pq_db_entrainement.del_entrainement(vnumEntrainement);
		htp.br;
		htp.print('L''entrainement n� '|| vnumEntrainement || ' a �t� supprim� avec succ�s.');
		htp.br;
		htp.br;			
		pq_ui_entrainement_entraineur.aff_entrainement_entraineur(vnumEntraineur);
		htp.br;
		htp.br;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Suppression d''un entrainement en cours...');
	END exec_del_entrainement_entr;
	
	--Permet d�afficher les informations d'un entrainement de l'entraineur
	
	PROCEDURE dis_entrainement_entr(
	  vnumEntrainement IN NUMBER)
	IS
		vcodeNiveau ENTRAINEMENT.CODE_NIVEAU%TYPE;
		vnbplaces ENTRAINEMENT.NB_PLACE_ENTRAINEMENT%TYPE;
		vdateDebut ENTRAINEMENT.DATE_DEBUT_ENTRAINEMENT%TYPE;
		vdateFin ENTRAINEMENT.DATE_FIN_ENTRAINEMENT%TYPE;
		vlibEntrainement ENTRAINEMENT.LIB_ENTRAINEMENT%TYPE;
		
		vnbSeance NUMBER (3);
		CURSOR listSeance IS SELECT NUM_JOUR,HEURE_DEBUT_CRENEAU,NUM_TERRAIN FROM AVOIR_LIEU WHERE NUM_ENTRAINEMENT=vnumEntrainement ORDER BY NUM_JOUR;
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
        pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;

		SELECT LIB_ENTRAINEMENT,CODE_NIVEAU,NB_PLACE_ENTRAINEMENT,DATE_DEBUT_ENTRAINEMENT,DATE_FIN_ENTRAINEMENT 
		INTO vlibEntrainement,vcodeNiveau,vnbplaces,vdateDebut,vdateFin
		FROM ENTRAINEMENT WHERE NUM_ENTRAINEMENT = vnumEntrainement;
		
		SELECT COUNT(*) INTO vnbSeance FROM AVOIR_LIEU WHERE NUM_ENTRAINEMENT=vnumEntrainement;
		htp.br;	
		htp.print('Affichage des informations d''un entrainement');
		htp.br;
		htp.br;						
		htp.print('Description de l''entrainement num�ro '|| vnumEntrainement || ' : '||vlibEntrainement);
		htp.br;
		htp.print('L''entrainement s''adresse aux joueurs poss�dant au moins le niveau : '|| vcodeNiveau || '.');
		htp.br;
		htp.print('Le nombre de places disponibles est de : '|| vnbPlaces || '.');
		htp.br;
		htp.print('Il a lieu entre le  : '|| TO_CHAR(vdateDebut,'DD/MM/YYYY') || ' et le ' || TO_CHAR(vdateFin,'DD/MM/YYYY') ||'.');
		htp.br;
		htp.br;
		htp.print('S�ances   : ');
		htp.tableOpen;
		if(vnbSeance=0)
		then
			htp.tableRowOpen;
			htp.print('<td>');
			htp.print('L''entrainement n''a pas encore de s�ance.');
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
				htp.print(' � ' || currentSeance.HEURE_DEBUT_CRENEAU || ' sur le terrain num�ro ' || currentSeance.NUM_TERRAIN || '.' );	
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
		htp.anchor('pq_ui_avoir_lieu.form_add_avoir_lieu?vnumEntrainement='||vnumEntrainement||'&'||'vretourEntraineur=1', 'Ajouter une s�ance');	
		htp.br;
		htp.br;
		htp.anchor('pq_ui_entrainement_entraineur.manage_entrainement_entraineur', 'Retourner � la gestion des entrainements');
		htp.br; 
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�.');
	END dis_entrainement_entr;
	
	-- Affiche le formulaire permettant la saisie d�un nouvel entrainement
	PROCEDURE form_add_entrainement_entr
	IS
		CURSOR niveaulist IS SELECT CODE FROM CODIFICATION WHERE NATURE = 'Classement';
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
	BEGIN
        pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
        pq_ui_commun.aff_header;	
		target_cookie := OWA_COOKIE.get('numpersonne');
		num_entraineur:=TO_NUMBER(target_cookie.vals(1));
			htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_entrainement_entraineur.exec_add_entrainement_entr', 'POST', cattributes => 'onSubmit="return validerEntrainement(this,document)"');				
				htp.formhidden ('vdateDebut','01/01/1970', cattributes => 'id="idVdateDebut"');
				htp.formhidden ('vdateFin','01/01/1970', cattributes => 'id="idVdateFin"');
				htp.br;
				htp.print('Cr�ation d''un nouvel entrainement');
				htp.br;
				htp.br;
				htp.print('Les champs marqu�s d''une �toile sont obligatoires.');
				htp.br;
				htp.tableOpen;
				htp.br;				
				htp.formhidden('vnumEntraineur',num_entraineur);
				htp.tableRowOpen;
				htp.tableData('Niveau * :');
					--Forme une liste d�roulante avec tous les niveaux de la table codification								
					htp.print('<td>');
					htp.print('<select name="vcodeNiveau" id="vcodeNiveau">');		
					for currentNiveau in niveaulist loop
							htp.print('<option value="'||currentNiveau.CODE||'">'||currentNiveau.CODE||'</option>');
					end loop;
					htp.print('</select>');										
					htp.print('</td>');							
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Libell� * :');	
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
					htp.tableData('Date de d�but * :');	
					htp.print('<td>');	
					htp.print('<select id="vdateDebutDay">');								
					FOR currentDebutDay in 1..31 loop	
						htp.print('<option value="'||currentDebutDay||'">'||currentDebutDay||'</option>');								
					END LOOP; 																				
					htp.print('</select>');	
					htp.print('<select id="vdateDebutMonth">');								
					FOR currentDebutMonth in 1..12 loop	
						htp.print('<option value="'||currentDebutMonth||'">'||currentDebutMonth||'</option>');								
					END LOOP; 																				
					htp.print('</select>');	
					htp.print('<select id="vdateDebutYear">');								
					FOR currentDebutYear in currentYearStart..currentYearEnd loop	
						htp.print('<option value="'||currentDebutYear||'">'||currentDebutYear||'</option>');								
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
						htp.print('<option value="'||currentFinDay||'">'||currentFinDay||'</option>');								
					END LOOP; 																				
					htp.print('</select>');	
					htp.print('<select id="vdateFinMonth">');								
					FOR currentFinMonth in 1..12 loop	
						htp.print('<option value="'||currentFinMonth||'">'||currentFinMonth||'</option>');								
					END LOOP; 																				
					htp.print('</select>');	
					htp.print('<select id="vdateFinYear">');								
					FOR currentFinYear in currentYearStart..currentYearEnd loop	
						htp.print('<option value="'||currentFinYear||'">'||currentFinYear||'</option>');								
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
			htp.anchor('pq_ui_entrainement_entraineur.manage_entrainement_entraineur', 'Retourner � la gestion des entrainements');
			htp.br; 
			htp.br;
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�.');
	END form_add_entrainement_entr;
	
	-- Affiche le formulaire de saisie permettant la modification d�un entrainement existant	
	PROCEDURE form_upd_entrainement_entr(
	  vnumEntrainement IN NUMBER)
	IS
		vcodeNiveau ENTRAINEMENT.CODE_NIVEAU%TYPE;
		vnbplaces ENTRAINEMENT.NB_PLACE_ENTRAINEMENT%TYPE;
		vlibEntrainement ENTRAINEMENT.LIB_ENTRAINEMENT%TYPE;
		
		CURSOR niveaulist IS SELECT CODE FROM CODIFICATION WHERE NATURE = 'Classement';
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		currentPlace NUMBER(2) := 0;
	BEGIN
        pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
        pq_ui_commun.aff_header;
		
		SELECT CODE_NIVEAU,LIB_ENTRAINEMENT,NB_PLACE_ENTRAINEMENT
		INTO vcodeNiveau,vlibEntrainement,vnbplaces
		FROM ENTRAINEMENT WHERE NUM_ENTRAINEMENT = vnumEntrainement;
		
			htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_entrainement_entraineur.exec_upd_entrainement_entr', 'POST', cattributes => 'onSubmit="return validerUpdEntrainement(this,document)"');				
				htp.formhidden ('vnumEntrainement',vnumEntrainement);
				htp.br;
				htp.print('Mise � jour de l''entrainement num�ro ' || vnumEntrainement);
				htp.br;
				htp.br;
				htp.print('Les champs marqu�s d''une �toile sont obligatoires.');
				htp.br;
				htp.tableOpen;
				htp.br;				
				htp.tableData('Niveau * :');	
					--Forme une liste d�roulante avec tous les niveaux de la table codification								
					htp.print('<td>');
					htp.print('<select name="vcodeNiveau" id="vcodeNiveau">');		
					for currentNiveau in niveaulist loop
						if(currentNiveau.CODE=vcodeNiveau)
						then
							htp.print('<option selected value="'||currentNiveau.CODE||'">'||currentNiveau.CODE||'</option>');
						else
							htp.print('<option value="'||currentNiveau.CODE||'">'||currentNiveau.CODE||'</option>');
						end if;
					end loop;
					htp.print('</select>');										
					htp.print('</td>');							
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Libell� * :');	
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
			htp.anchor('pq_ui_entrainement_entraineur.manage_entrainement_entraineur', 'Retourner � la gestion des entrainements');
			htp.br; 
			htp.br;
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�.');
	END form_upd_entrainement_entr;
		
END pq_ui_entrainement_entraineur;
/