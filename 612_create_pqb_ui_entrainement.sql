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

CREATE OR REPLACE PACKAGE BODY pq_ui_entrainement
IS
	
	--Permet d'afficher tous les entrainement existant 
	PROCEDURE manage_entrainement
	IS
		-- On stocke dans un curseur la liste de tous les entrainements existants
		CURSOR listEntrainement IS
		SELECT 
			NUM_ENTRAINEMENT
		   ,NUM_ENTRAINEUR
		   ,CODE_NIVEAU
		   ,NATURE_NIVEAU
		   ,NB_PLACE_ENTRAINEMENT
		   ,DATE_DEBUT_ENTRAINEMENT
		   ,DATE_FIN_ENTRAINEMENT
		   ,EST_RECURENT_ENTRAINEMENT
		   ,EST_ACTIF_ENTRAINEMENT
		FROM 
			ENTRAINEMENT ENTR
		ORDER BY 
			NUM_ENTRAINEMENT;
		
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
     /*   pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
        pq_ui_commun.aff_header;*/
		htp.br;				
		htp.print('Gestion des entrainements' || ' (' || htf.anchor('pq_ui_entrainement.manage_entrainement','Actualiser')|| ')' );
		htp.br;	
		htp.br;	
		htp.print(htf.anchor('pq_ui_entrainement.form_add_entrainement','Ajouter un entrainement'));
		htp.br;	
		htp.br;
		htp.print(htf.anchor('pq_ui_entrainement.manage_historique_entrainement','Historique'));
		htp.br;
		htp.br;	
		htp.tableOpen;
			htp.tableheader('Num�ro de l''entrainement   ');
			htp.tableheader('Informations   ');
			htp.tableheader('Mise � jour   ');
			htp.tableheader('Suppression   ');
			for currentEntrainement in listEntrainement loop
				if(currentEntrainement.EST_ACTIF_ENTRAINEMENT=1)
				then
					htp.tableRowOpen;
					htp.tabledata(currentEntrainement.NUM_ENTRAINEMENT);				
					htp.tabledata(htf.anchor('pq_ui_entrainement.exec_dis_entrainement?vnumEntrainement='||currentEntrainement.NUM_ENTRAINEMENT,'Informations'));
					htp.tabledata(htf.anchor('pq_ui_entrainement.form_upd_entrainement?vnumEntrainement='||currentEntrainement.NUM_ENTRAINEMENT||'&'||'vnumEntraineur='||currentEntrainement.NUM_ENTRAINEUR||'&'||
					'vcodeNiveau='||currentEntrainement.CODE_NIVEAU||'&'||'vnatureNiveau='||currentEntrainement.NATURE_NIVEAU||'&'||'vnbPlaces='||currentEntrainement.NB_PLACE_ENTRAINEMENT
					||'&'||'vdateDebut='||currentEntrainement.DATE_DEBUT_ENTRAINEMENT||'&'||'vdateFin='||currentEntrainement.DATE_FIN_ENTRAINEMENT||'&'||'vestRecurent='||currentEntrainement.EST_RECURENT_ENTRAINEMENT,'Mise � jour'));
					htp.tabledata(htf.anchor('pq_ui_entrainement.exec_del_entrainement?vnumEntrainement='||currentEntrainement.NUM_ENTRAINEMENT,'Supprimer', cattributes => 'onClick="return confirmerChoix(this,document)"'));
					htp.tableRowClose;
				end if;
			end loop;	
		htp.tableClose;
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
		pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�e.');
	WHEN OTHERS THEN
		pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Gestion des entrainements');
	END manage_entrainement;
	
	--Permet d'afficher tous les entrainement inactifs
	PROCEDURE manage_historique_entrainement
	IS
		-- On stocke dans un curseur la liste de tous les entrainements existants
		CURSOR listEntrainement IS
		SELECT 
			NUM_ENTRAINEMENT
		   ,NUM_ENTRAINEUR
		   ,CODE_NIVEAU
		   ,NATURE_NIVEAU
		   ,NB_PLACE_ENTRAINEMENT
		   ,DATE_DEBUT_ENTRAINEMENT
		   ,DATE_FIN_ENTRAINEMENT
		   ,EST_RECURENT_ENTRAINEMENT
		   ,EST_ACTIF_ENTRAINEMENT
		FROM 
			ENTRAINEMENT ENTR
		ORDER BY 
			NUM_ENTRAINEMENT;
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
       /* pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
        pq_ui_commun.aff_header;*/
				htp.br;				
				htp.print('Gestion de l''historique des entrainements' || ' (' || htf.anchor('pq_ui_entrainement.manage_historique_entrainement','Actualiser')|| ')' );
				htp.br;
				htp.br;	
				htp.tableOpen;
					htp.tableheader('Num�ro de l''entrainement     ');
					htp.tableheader('Informations   ');
					for currentEntrainement in listEntrainement loop
						if(currentEntrainement.EST_ACTIF_ENTRAINEMENT=0)
						then
							htp.tableRowOpen;
							htp.tabledata(currentEntrainement.NUM_ENTRAINEMENT);				
							htp.tabledata(htf.anchor('pq_ui_entrainement.exec_dis_entrainement?vnumEntrainement='||currentEntrainement.NUM_ENTRAINEMENT,'Informations'));
							htp.tableRowClose;
						end if;
					end loop;	
				htp.tableClose;
				htp.br;
				htp.br;
				htp.anchor('pq_ui_entrainement.manage_entrainement', 'Retourner � la gestion des entrainements actuels');
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�e.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Gestion des historiques des entrainements');
	END manage_historique_entrainement;
	
	
	-- Ex�cute la proc�dure d�affichage des entrainements et g�re les erreurs �ventuelles
	PROCEDURE exec_dis_entrainement(
	  vnumEntrainement IN NUMBER)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		CURSOR listEntrainement IS SELECT NUM_ENTRAINEUR,CODE_NIVEAU,NATURE_NIVEAU,NB_PLACE_ENTRAINEMENT,DATE_DEBUT_ENTRAINEMENT,
										  DATE_FIN_ENTRAINEMENT,EST_RECURENT_ENTRAINEMENT FROM ENTRAINEMENT WHERE NUM_ENTRAINEMENT = vnumEntrainement;
	BEGIN
       /* pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
        pq_ui_commun.aff_header;*/
		htp.br;				
		for currentEntrainement in listEntrainement loop
		pq_ui_entrainement.dis_entrainement(vnumEntrainement,currentEntrainement.NUM_ENTRAINEUR,currentEntrainement.CODE_NIVEAU,
											currentEntrainement.NATURE_NIVEAU,currentEntrainement.NB_PLACE_ENTRAINEMENT,
											currentEntrainement.DATE_DEBUT_ENTRAINEMENT,currentEntrainement.DATE_FIN_ENTRAINEMENT,
											currentEntrainement.EST_RECURENT_ENTRAINEMENT);
		end loop;		
		htp.br;		
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�e.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Affichage de l''entrainement en cours...');
	END exec_dis_entrainement;
	
	-- Ex�cute la proc�dure d'ajout d'un entrainement et g�re les erreurs �ventuelles.
	PROCEDURE exec_add_entrainement(
	  vnumEntrainement IN NUMBER
	, vnumEntraineur IN NUMBER
	, vcodeNiveau IN CHAR
	, vnatureNiveau IN VARCHAR2
	, vnbPlaces IN NUMBER
	, vdateDebut IN VARCHAR2
	, vdateFin IN VARCHAR2
	, vestRecurent IN NUMBER)
	IS
		sequenceNumEntrainement NUMBER(6);
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
        /*pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
        pq_ui_commun.aff_header;*/
		pq_db_entrainement.add_entrainement(vnumEntrainement,vnumEntraineur,vcodeNiveau,vnatureNiveau,vnbPlaces,to_date(vdateDebut, 'dd/mm/yy'),to_date(vdateFin, 'dd/mm/yy'),vestRecurent);
		htp.print('L''entrainement a �t� cr�� avec succ�s');
		htp.br();
		htp.br();
		SELECT SEQ_ENTRAINEMENT.currval INTO sequenceNumEntrainement FROM dual;
		pq_ui_entrainement.exec_dis_entrainement(sequenceNumEntrainement);
		htp.br();
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�e.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Ajout d''un entrainement en cours...');
	END exec_add_entrainement;
	
	-- Ex�cute la proc�dure de mise � jour d'un entrainement et g�re les erreurs �ventuelles
	PROCEDURE exec_upd_entrainement(
	  vnumEntrainement IN NUMBER
	, vnumEntraineur IN NUMBER
	, vcodeNiveau IN CHAR
	, vnatureNiveau IN VARCHAR2
	, vnbPlaces IN NUMBER
	, vdateDebut IN VARCHAR2
	, vdateFin IN VARCHAR2
	, vestRecurent IN NUMBER)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
       /* pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
        pq_ui_commun.aff_header;*/
		pq_db_entrainement.upd_entrainement(vnumEntrainement,vnumEntraineur,vcodeNiveau,vnatureNiveau,vnbPlaces,to_date(vdateDebut, 'dd/mm/yy'),to_date(vdateFin, 'dd/mm/yy'),vestRecurent);
		htp.print('L''entrainement n� '|| vnumEntrainement || ' a �t� modifi� avec succ�s.');
		htp.br();
		htp.br();
		pq_ui_entrainement.manage_entrainement;
		htp.br();
		pq_ui_commun.aff_footer;
		EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�e.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Modification de l''entrainement en cours...');
	END exec_upd_entrainement;

	-- Ex�cute la proc�dure de suppression d'un entrainement et g�re les erreurs �ventuelles
	PROCEDURE exec_del_entrainement(
	  vnumEntrainement IN NUMBER)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
        /*pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
        pq_ui_commun.aff_header;*/
		--passe l'entrainement � l'�tat inactif
		pq_db_entrainement.stop_entrainement(vnumEntrainement);
		pq_db_etre_affecte.del_etre_affecte_entrainement(vnumEntrainement);
		pq_db_avoir_lieu.del_avoir_lieu_entrainement(vnumEntrainement);
		htp.print('L''entrainement n� '|| vnumEntrainement || ' a �t� supprim� avec succ�s.');
		htp.br;
		htp.br;			
		pq_ui_entrainement.manage_entrainement;
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�e.');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Suppression d''un entrainement en cours...');
	END exec_del_entrainement;
	
	--Permet d�afficher un entrainement existant
	PROCEDURE dis_entrainement(
	  vnumEntrainement IN NUMBER
	, vnumEntraineur IN NUMBER
	, vcodeNiveau IN CHAR
	, vnatureNiveau IN VARCHAR2
	, vnbPlaces IN NUMBER
	, vdateDebut IN DATE
	, vdateFin IN DATE
	, vestRecurent IN NUMBER)
	IS
		vprenomEntraineur VARCHAR2(40);
		vnomEntraineur VARCHAR2(40);
		vnbSeance NUMBER (3);
		CURSOR listSeance IS SELECT NUM_JOUR,HEURE_DEBUT_CRENEAU,NUM_TERRAIN FROM AVOIR_LIEU WHERE NUM_ENTRAINEMENT=vnumEntrainement ORDER BY NUM_JOUR;
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
       /* pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
        pq_ui_commun.aff_header;*/
		SELECT P.PRENOM_PERSONNE INTO vprenomEntraineur FROM PERSONNE P WHERE P.NUM_PERSONNE=vnumEntraineur;
		SELECT P.NOM_PERSONNE INTO vnomEntraineur FROM PERSONNE P WHERE P.NUM_PERSONNE=vnumEntraineur;
		SELECT COUNT(*) INTO vnbSeance FROM AVOIR_LIEU WHERE NUM_ENTRAINEMENT=vnumEntrainement;
		htp.br;	
		htp.print('Affichage des informations d''un entrainement' || ' (' || htf.anchor('pq_ui_entrainement.dis_entrainement?vnumEntrainement='||vnumEntrainement||'&'||'vnumEntraineur='||vnumEntraineur||'&'||
				'vcodeNiveau='||vcodeNiveau||'&'||'vnatureNiveau='||vnatureNiveau||'&'||'vnbPlaces='||vnbPlaces
				||'&'||'vdateDebut='||vdateDebut||'&'||'vdateFin='||vdateFin||'&'||'vestRecurent='||vestRecurent,'Actualiser')|| ')' );
		htp.br;
		htp.br;						
		htp.print('Desription de l''entrainement num�ro '|| vnumEntrainement || ' :');
		htp.br;	
		htp.br;
		htp.print('Il est anim� par '|| vprenomEntraineur || ' ' || vnomEntraineur || '.');
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
				htp.tabledata(htf.anchor('pq_ui_avoir_lieu.exec_del_avoir_lieu?vnumJour='||currentSeance.NUM_JOUR||'&'||'vheureDebutCreneau='||currentSeance.HEURE_DEBUT_CRENEAU||'&'||'vnumTerrain='||currentSeance.NUM_TERRAIN||'&'||'vnumEntrainement='||vnumEntrainement, 'Supprimer',cattributes => 'onClick="return confirmerChoix(this,document)"'));
				htp.print('</td>');
				htp.tableRowClose;
				htp.br;
			end loop;
		end if;
		htp.br;	
		htp.tableClose;
		htp.br;
		htp.br;
		htp.anchor('pq_ui_avoir_lieu.form_add_avoir_lieu?vnumEntrainement='||vnumEntrainement, 'Ajouter une s�ance');	
		htp.br;
		htp.br;
		htp.anchor('pq_ui_entrainement.manage_entrainement', 'Retourner � la gestion des entrainements');	
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�e.');
	END dis_entrainement;
	
	-- Affiche le formulaire permettant la saisie d�un nouvel entrainement
	PROCEDURE form_add_entrainement
	IS
		CURSOR entraineurlist IS SELECT NUM_PERSONNE,NOM_PERSONNE,PRENOM_PERSONNE FROM PERSONNE WHERE CODE_STATUT_EMPLOYE='ENT';
		CURSOR niveaulist IS SELECT CODE FROM CODIFICATION WHERE NATURE = 'Classement';
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
       /* pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
        pq_ui_commun.aff_header;*/
			htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_entrainement.exec_add_entrainement', 'GET');				
				htp.formhidden ('vnumEntrainement','1');
				htp.br;
				htp.print('Cr�ation d''un nouvel entrainement' || ' (' || htf.anchor('pq_ui_entrainement.form_add_entrainement','Actualiser')|| ')' );
				htp.br;
				htp.br;
				htp.print('Les champs marqu�s d''une �toile sont obligatoires.');
				htp.br;
				htp.tableOpen;
				htp.br;				
				htp.tableRowOpen;
				htp.tableData('Entraineur * :', cattributes => 'class="enteteFormulaire"');	
					--Forme une liste d�roulante avec tous les entraineur � partir de la table personne									
					htp.print('<td>');
					htp.print('<select name="vnumEntraineur" id="vnumEntraineur">');		
					for currentEntraineur in entraineurlist loop
							htp.print('<option value="'||currentEntraineur.NUM_PERSONNE||'">'||currentEntraineur.PRENOM_PERSONNE||' '||currentEntraineur.NOM_PERSONNE||'</option>');
					end loop;
					htp.print('</select>');										
					htp.print('</td>');						
				htp.tableRowClose;	
				htp.tableRowOpen;
				htp.tableData('Niveau * :', cattributes => 'class="enteteFormulaire"');	
					--Forme une liste d�roulante avec tous les niveaux de la table codification								
					htp.print('<td>');
					htp.print('<select name="vcodeNiveau" id="vcodeNiveau">');		
					for currentNiveau in niveaulist loop
							htp.print('<option value="'||currentNiveau.CODE||'">'||currentNiveau.CODE||'</option>');
					end loop;
					htp.print('</select>');										
					htp.print('</td>');							
				htp.tableRowClose;
				htp.formhidden ('vnatureNiveau','Classement');
				htp.tableRowOpen;
					htp.tableData('Nombre de places * :', cattributes => 'class="enteteFormulaire"');	
					htp.print('<td>');					
					htp.formText('vnbPlaces',2);										
					htp.print('</td>');						
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Date de d�but * :', cattributes => 'class="enteteFormulaire"');	
					htp.print('<td>');					
					htp.formText('vdateDebut',8);
					htp.print('date sous le forme "22/01/10"');
					htp.print('</td>');						
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Date de fin * :', cattributes => 'class="enteteFormulaire"');	
					htp.print('<td>');					
					htp.formText('vdateFin',8);										
					htp.print('</td>');						
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('L''entrainement est il r�curent ? * :', cattributes => 'class="enteteFormulaire"');												
						htp.print('<td>');
						htp.print('<select name="vestRecurent" id="vestRecurent">');
							htp.print('<option value="1" selected="selected">oui</option>');
							htp.print('<option value="0">non</option></select>');
						htp.print('</td>');							
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('');
					htp.tableData(htf.formSubmit(NULL,'Validation'));
				htp.tableRowClose;
				htp.tableClose;
			htp.formClose;
			htp.br;
			htp.anchor('pq_ui_entrainement.manage_entrainement', 'Retourner � la gestion des entrainements');
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�e.');
	END form_add_entrainement;
	
	-- Affiche le formulaire de saisie permettant la modification d�un entrainement existant	
	PROCEDURE form_upd_entrainement(
	  vnumEntrainement IN NUMBER
	, vnumEntraineur IN NUMBER
	, vcodeNiveau IN CHAR
	, vnatureNiveau IN VARCHAR2
	, vnbPlaces IN NUMBER
	, vdateDebut IN DATE
	, vdateFin IN DATE
	, vestRecurent IN NUMBER)
	IS
		CURSOR entraineurlist IS SELECT NUM_PERSONNE,NOM_PERSONNE,PRENOM_PERSONNE FROM PERSONNE WHERE CODE_STATUT_EMPLOYE='ENT';
		CURSOR niveaulist IS SELECT CODE FROM CODIFICATION WHERE NATURE = 'Classement';
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
       /* pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
        pq_ui_commun.aff_header;*/
			htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_entrainement.exec_upd_entrainement', 'GET');				
				htp.formhidden ('vnumEntrainement',vnumEntrainement);
				htp.br;
				htp.print('Mise � jour de l''entrainement num�ro ' || vnumEntrainement || ' (' || htf.anchor('pq_ui_entrainement.form_upd_entrainement','Actualiser')|| ')' );
				htp.br;
				htp.br;
				htp.print('Les champs marqu�s d''une �toile sont obligatoires.');
				htp.br;
				htp.tableOpen;
				htp.br;				
				htp.tableRowOpen;
				htp.tableData('Entraineur * :', cattributes => 'class="enteteFormulaire"');	
					--Forme une liste d�roulante avec tous les entraineur � partir de la table personne									
					htp.print('<td>');
					htp.print('<select name="vnumEntraineur" id="vnumEntraineur">');		
					for currentEntraineur in entraineurlist loop
						if(currentEntraineur.NUM_PERSONNE=vnumEntraineur)
						then
							htp.print('<option selected value="'||currentEntraineur.NUM_PERSONNE||'">'||currentEntraineur.PRENOM_PERSONNE||' '||currentEntraineur.NOM_PERSONNE||'</option>');
						else
							htp.print('<option value="'||currentEntraineur.NUM_PERSONNE||'">'||currentEntraineur.PRENOM_PERSONNE||' '||currentEntraineur.NOM_PERSONNE||'</option>');
						end if;
					end loop;
					htp.print('</select>');										
					htp.print('</td>');						
				htp.tableRowClose;	
				htp.tableRowOpen;
				htp.tableData('Niveau * :', cattributes => 'class="enteteFormulaire"');	
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
				htp.formhidden ('vnatureNiveau',vnatureNiveau);
				htp.tableRowOpen;
					htp.tableData('Nombre de places * :', cattributes => 'class="enteteFormulaire"');	
					htp.print('<td>');	
					htp.print('<INPUT TYPE="text" name="vnbPlaces" value="'||vnbPlaces||'"> ');													
					htp.print('</td>');						
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Date de d�but * :', cattributes => 'class="enteteFormulaire"');	
					htp.print('<td>');			
					htp.print('<INPUT TYPE="text" name="vdateDebut" value="'||TO_CHAR(vdateDebut,'DD/MM/YY')||'"> ');
					htp.print('</td>');						
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Date de fin * :', cattributes => 'class="enteteFormulaire"');	
					htp.print('<td>');		
					htp.print('<INPUT TYPE="text" name="vdateFin" value="'||TO_CHAR(vdateFin,'DD/MM/YY')||'"> ');									
					htp.print('</td>');						
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('L''entrainement est il r�curent ? * :', cattributes => 'class="enteteFormulaire"');												
						htp.print('<td>');
						htp.print('<select name="vestRecurent" id="vestRecurent">');
							if(vestRecurent=1)
							then
								htp.print('<option value="1" selected="selected">oui</option>');
								htp.print('<option value="0" >non</option></select>');
							end if;
							if(vestRecurent=0)
							then
								htp.print('<option value="1" >oui</option>');
								htp.print('<option value="0" selected="selected">non</option></select>');
							end if;
						htp.print('</td>');							
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('');
					htp.tableData(htf.formSubmit(NULL,'Validation'));
				htp.tableRowClose;
				htp.tableClose;
			htp.formClose;
			htp.br;
			htp.anchor('pq_ui_entrainement.manage_entrainement', 'Retourner � la gestion des entrainements');
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Acc�s � la page refus�e.');
	END form_upd_entrainement;
		
END pq_ui_entrainement;
/