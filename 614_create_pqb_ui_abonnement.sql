-- -----------------------------------------------------------------------------
--           Création du corps du package d'affichage des données
--           pour la table ABONNEMENT
--                      Oracle Version 10g
--                        (25/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 25/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pq_ui_abonnement
IS 
	--Permet d'afficher tous les créneaux et les actions possibles de gestion (avec le menu)
	PROCEDURE manage_abonnements
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;	
		CURSOR listAbonnements IS
		SELECT
			  A.NUM_ABONNEMENT
			, P.NOM_PERSONNE
			, A.DATE_DEBUT_ABONNEMENT
			, A.DUREE_ABONNEMENT
		FROM
			ABONNEMENT A INNER JOIN PERSONNE P ON A.NUM_JOUEUR = P.NUM_PERSONNE
		ORDER BY
			A.NUM_ABONNEMENT;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		
		pq_ui_commun.aff_header;
		
		htp.br;	
		htp.print('<div class="titre_niveau_1">');
			htp.print('Gestion des abonnements');
		htp.print('</div>');		
		htp.br;	
		htp.br;	
		htp.print(htf.anchor('pq_ui_abonnement.form_add_abonnement','Ajouter un abonnement'));
		htp.br;	
		htp.br;	
		htp.tableOpen('',cattributes => 'class="tableau"');
			htp.tableheader('N° abonnement');
			htp.tableheader('Nom joueur');
			htp.tableheader('Date début');
			htp.tableheader('Durée (en mois)');
			htp.tableheader('Informations');
			htp.tableheader('Mise à jour');
			htp.tableheader('Suppression');
			for currentAbonnement in listAbonnements loop
				htp.tableRowOpen;
				htp.tabledata(currentAbonnement.NUM_ABONNEMENT);
				htp.tabledata(currentAbonnement.NOM_PERSONNE);	
				htp.tabledata(currentAbonnement.DATE_DEBUT_ABONNEMENT);	
				htp.tabledata(currentAbonnement.DUREE_ABONNEMENT);
				htp.tabledata(htf.anchor('pq_ui_abonnement.dis_abonnement?pnumAbonnement='||currentAbonnement.NUM_ABONNEMENT,'Informations'));
				htp.tabledata(htf.anchor('form_upd_abonnement?pnumAbonnement='||currentAbonnement.NUM_ABONNEMENT,'Mise à jour'));
				htp.tabledata(htf.anchor('exec_del_abonnement?pnumAbonnement='||currentAbonnement.NUM_ABONNEMENT,'Supprimer', cattributes => 'onClick="return confirmerChoix(this,document)"'));
				htp.tableRowClose;
			end loop;	
		htp.tableClose;		
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error_permission_denied;
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Gestion des abonnements');
	END manage_abonnements;

	--Permet d’afficher un abonnement existant
	PROCEDURE dis_abonnement(
	  pnumAbonnement IN VARCHAR2)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		vnumAbonnement 	ABONNEMENT.NUM_ABONNEMENT%TYPE;
		vnomPersonne 	PERSONNE.NOM_PERSONNE%TYPE;
		vdateDebut 		ABONNEMENT.DATE_DEBUT_ABONNEMENT%TYPE;
		vduree 			ABONNEMENT.DUREE_ABONNEMENT%TYPE;
		
		CURSOR listeMens(numAbonnement ABONNEMENT.NUM_ABONNEMENT%TYPE) IS
		SELECT
			  M.ANNEE_MOIS_MENSUALITE
			, M.NB_HEURES_MENSUALITE
		FROM
			MENSUALITE M
		WHERE
			M.NUM_ABONNEMENT = numAbonnement;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;		
		pq_ui_commun.aff_header;
		
		vnumAbonnement := TO_NUMBER(pnumAbonnement);
		
		SELECT
			  P.NOM_PERSONNE
			, A.DATE_DEBUT_ABONNEMENT
			, A.DUREE_ABONNEMENT
		INTO
			  vnomPersonne
			, vdateDebut
			, vduree
		FROM
			ABONNEMENT A INNER JOIN PERSONNE P ON A.NUM_JOUEUR = P.NUM_PERSONNE
		WHERE
			A.NUM_ABONNEMENT = vnumAbonnement;
			
		htp.br;
		htp.print('<div class="titre_niveau_1">');
			htp.print('Affichage des informations d''un abonnement' );
		htp.print('</div>');		
		htp.br;
		htp.br;					
		htp.print('L''abonnement n° '|| vnumAbonnement || ' concerne le joueur '|| vnomPersonne || ' depuis '|| vdateDebut || ' et pendant '|| vduree ||' mois.');
		
		htp.tableOpen('',cattributes => 'class="tableau"');
			htp.tableheader('Mensualité');
			htp.tableheader('Nombre heures');
			for currentMensualite in listeMens(vnumAbonnement) loop
				htp.tableRowOpen;
				htp.tabledata(to_char(currentMensualite.ANNEE_MOIS_MENSUALITE, 'DD/MM/YYYY'));
				htp.tabledata(currentMensualite.NB_HEURES_MENSUALITE);	
				htp.tableRowClose;
			end loop;	
		htp.tableClose;
		
		htp.br;
		htp.br;		
		htp.anchor('pq_ui_abonnement.manage_abonnements', 'Retourner à la gestion des abonnements');	
		
		pq_ui_commun.aff_footer;
		
	EXCEPTION		
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error_permission_denied;
		WHEN INVALID_NUMBER THEN
			pq_ui_commun.dis_error_custom('Le numéro d''abonnement est incorrect.','','','pq_ui_abonnement.manage_abonnements','Retour vers la liste des abonnements');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Erreur affichage abonnement');
	END dis_abonnement;
	
	-- Affiche le formulaire permettant la saisie d’un nouvel abonnement
	PROCEDURE form_add_abonnement
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		-- On stocke dans un curseur la liste de tous les adhérents existants
		CURSOR listeAdherents IS
		SELECT 
			  P.NUM_PERSONNE
			, P.NOM_PERSONNE
		FROM 
			PERSONNE P
		WHERE
			P.STATUT_JOUEUR = 'A'
		ORDER BY 
			P.NOM_PERSONNE;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		
		pq_ui_commun.aff_header;
		
		htp.br;
		htp.print('<div class="titre_niveau_1">');
			htp.print('Création d''un nouvel abonnement' );
		htp.print('</div>');		
		htp.br;
		htp.br;
		htp.print('Les champs marqués d''une étoile sont obligatoires.');
		htp.br;
		htp.br;	
		htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_abonnement.exec_add_abonnement', 'POST', cattributes => 'onSubmit="return validerAbonnement(this,document)"');				
			htp.tableOpen;	
				htp.tableRowOpen;
					htp.tableData('Adhérent * :', cattributes => 'class="enteteFormulaire"');	
					--Forme une liste déroulante avec tous les adhérents à partir de la table PERSONNE									
					htp.print('<td>');
						htp.print('<select name="pnumJoueur">');						
						FOR currentAdherent in listeAdherents loop
							--On transmet le code, la nature et le libellé
							htp.print('<option value="'||currentAdherent.NUM_PERSONNE||'">'||currentAdherent.NOM_PERSONNE||'</option>');
						END LOOP; 																				
						htp.print('</select>');										
					htp.print('</td>');					
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Date début * :', cattributes => 'class="enteteFormulaire"');
					htp.tableData(htf.formText('pdateDebut'));
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Durée * :', cattributes => 'class="enteteFormulaire"');
					htp.tableData(htf.formText('pDuree'));
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('');
					htp.tableData(htf.formSubmit(NULL,'Validation'));
				htp.tableRowClose;
				htp.tableClose;
			htp.formClose;
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error_permission_denied;
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Saisie d''un nouvel abonnement');
	END form_add_abonnement;
	
	-- Exécute la procédure d'ajout d'un abonnement et gère les erreurs éventuelles.
	PROCEDURE exec_add_abonnement(
	  pnumJoueur IN VARCHAR2
	, pdateDebut IN VARCHAR2
	, pduree IN VARCHAR2)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		vnumJoueur ABONNEMENT.NUM_JOUEUR%TYPE;
		vdateDebut ABONNEMENT.DATE_DEBUT_ABONNEMENT%TYPE;
		vduree ABONNEMENT.DUREE_ABONNEMENT%TYPE;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
			
		pq_ui_commun.aff_header;
		
		vnumJoueur := TO_NUMBER(pnumJoueur);
		vdateDebut := TO_DATE(pdateDebut, 'DD/MM/YYYY');
		vduree := TO_NUMBER(pduree);
		
		htp.br;
		pq_db_abonnement.add_abonnement(vnumJoueur,vdateDebut,vduree);
		htp.print('<div class="success"> ');
			htp.print('L''abonnement a été ajouté avec succès.');
		htp.print('</div>');	
		htp.br;
		htp.br;			
		pq_ui_abonnement.manage_abonnements;
		
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error_permission_denied;
		WHEN DUP_VAL_ON_INDEX THEN
			pq_ui_commun.dis_error_custom('L''abonnement n''a pas été ajouté','','','pq_ui_abonnement.form_add_abonnement','Retour vers la création d''un abonnement');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Ajout d''un abonnement en cours...');
	END exec_add_abonnement;
	
	/*-- Exécute la procédure de mise à jour d'un créneau et gère les erreurs éventuelles
	PROCEDURE exec_upd_creneau(
	  vheureDebutCreneau IN CHAR
	, vheureFinCreneau IN CHAR)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.aff_header(3);
				htp.br;				
				pq_db_creneau.upd_creneau(vheureDebutCreneau,vheureFinCreneau);
				htp.print('<div class="success"> ');
					htp.print('Le créneau qui commence à '|| vheureDebutCreneau || ' et qui se termine à '|| vheureFinCreneau || ' a été mis à jour avec succès.');
				htp.print('</div>');
				htp.br;
				htp.br;			
				pq_ui_creneau.manage_creneaux;
			pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Mise à jour d''un créneau en cours...');
	END exec_upd_creneau;
	/*
	-- Exécute la procédure de suppression d'un créneau et gère les erreurs éventuelles
	PROCEDURE exec_del_creneau(
	  vheureDebutCreneau IN CHAR)
	IS
	BEGIN
		pq_ui_commun.aff_header(3);
				htp.br;	
				pq_db_creneau.del_creneau(vheureDebutCreneau);
				htp.print('</div>');
					htp.print('Le créneau qui commençait à '|| vheureDebutCreneau || ' a été supprimé avec succès.');
				htp.print('</div>');
				tp.br;
				htp.br;			
				pq_ui_creneau.manage_creneaux;
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Suppression d''un créneau en cours...');
	END exec_del_creneau;
	  
	-- Exécute la procédure d’affichage des créneaux et gère les erreurs éventuelles
	PROCEDURE exec_dis_creneau(
	  vheureDebutCreneau IN CHAR
	, vheureFinCreneau IN CHAR)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.aff_header(3);
				htp.br;				
				pq_ui_creneau.dis_creneau(vheureDebutCreneau,vheureFinCreneau);
				htp.br;		
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Affichage d''un créneau en cours...');
	END exec_dis_creneau;
	
	-- Affiche le formulaire permettant la saisie d’un nouveau créneau	
	PROCEDURE form_add_creneau
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;		 
		currentStartHour NUMBER(2) := 0;
		currentStartMinute NUMBER(2) := 0;
		currentEndHour NUMBER(2) := 0;
		currentEndMinute NUMBER(2) := 0;
		complement VARCHAR2(1):= '0';
	BEGIN
		pq_ui_commun.aff_header(3);
				htp.br;
				htp.print('<div class="titre_niveau_1">');
					htp.print('Création d''un nouveau créneau' );
				htp.print('</div>');
				htp.br;
				htp.br;
				htp.print('Les champs marqués d''une étoile sont obligatoires.');
				htp.br;
				htp.br;
				htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_creneau.exec_add_creneau', 'POST', cattributes => 'onSubmit="return validerCreneau(this,document)"');
					--Ces deux champs sont mis à jour après la validation et la vérification du formulaire
					htp.formhidden ('vheureDebutCreneau','00h00', cattributes => 'id="idVheureDebutCreneau"');
					htp.formhidden ('vheureFinCreneau','00h00', cattributes => 'id="idVheureFinCreneau"');
					htp.tableOpen;
					htp.tableheader('');
					htp.tableheader('');
					htp.tableheader('');					
					htp.tableRowOpen;
						htp.tableData('Heure de début * :', cattributes => 'class="enteteFormulaire"');
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
				htp.anchor('pq_ui_creneau.manage_creneaux_with_menu', 'Retourner à la gestion des créneaux');
			pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Saisie d''un nouveau créneau');
	END form_add_creneau;
	
	
	-- Affiche le formulaire de saisie permettant la modification d’un créneau existant
	PROCEDURE form_upd_creneau(
	  vheureDebutCreneau IN CHAR
	, vheureFinCreneau IN CHAR)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		currentStartHour CHAR(3) := pq_ui_creneau.get_heure(vheureDebutCreneau);
		currentStartMinute CHAR(3) := pq_ui_creneau.get_minute(vheureDebutCreneau);
		currentEndHour NUMBER(2) := 0;
		lastEndHour NUMBER(2) := TO_NUMBER(pq_ui_creneau.get_heure(vheureFinCreneau));
		currentEndMinute NUMBER(2) := 0;
		lastEndMinute NUMBER(2) := TO_NUMBER(pq_ui_creneau.get_minute(vheureFinCreneau));
		complement VARCHAR2(1):= '0';
	BEGIN
		pq_ui_commun.aff_header(3);
				htp.br;
				htp.print('Mise à jour d''un créneau' || ' (' || htf.anchor('pq_ui_creneau.form_upd_creneau?vheureDebutCreneau='||vheureDebutCreneau||'&'||'vheureFinCreneau='||vheureFinCreneau,'Actualiser')|| ')' );
				htp.br;
				htp.br;
				htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_creneau.exec_upd_creneau', 'POST', cattributes => 'onSubmit="return validerMAJCreneau(this,document)"');
					htp.formhidden ('vheureDebutCreneau',vheureDebutCreneau);
					htp.formhidden ('vheureFinCreneau','00h00', cattributes => 'id="idVheureFinCreneau"');
					htp.tableOpen;
					htp.tableheader('');
					htp.tableheader('');
					htp.tableheader('');					
					htp.tableRowOpen;
						htp.tableData('Heure de début * :', cattributes => 'class="enteteFormulaire"');
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
									--Valeur sélectionnée par défaut
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
									--Valeur sélectionnée par défaut
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
				htp.anchor('pq_ui_creneau.manage_creneaux_with_menu', 'Retourner à la gestion des créneaux');
			pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Modification d''un créneau');
	END form_upd_creneau;
	
	-- Fonction permettant d'extraire les heures d'un créneau
	FUNCTION get_heure(
		vcreneau IN CHAR
	)
	RETURN CHAR
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		heure CHAR(3):= '00'; 
	BEGIN
		heure := substr(vcreneau, 1, 2); 
		return heure;
	END;
	
	-- Fonction permettant d'extraire les minutes d'un créneau
	FUNCTION get_minute(
		vcreneau IN CHAR
	)
	RETURN CHAR
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		minutes CHAR(3):= '00'; 
	BEGIN
		minutes := substr(vcreneau, 4, 2); 
		return minutes;
	END;
	*/
END pq_ui_abonnement;
/