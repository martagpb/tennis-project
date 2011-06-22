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
	PROCEDURE liste_abonnements
	IS
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
			
		--Variables permettant de déterminer si le curseur est vide ou non
		cursorListIsEmpty BOOLEAN:= true;
		nbValuesIntoCursorList NUMBER(1):= 0; 
			
	BEGIN
		htp.br;	
		htp.print('<div class="titre_niveau_1">');
			htp.print('Gestion des abonnements');
		htp.print('</div>');		
		htp.br;	
		htp.br;	
		htp.print(htf.anchor('pq_ui_abonnement.form_add_abonnement','Ajouter un abonnement'));
		htp.br;	
		htp.br;	
		
		--On parcours le curseur pour déterminer s'il est vide
		for emptyAbonnement in listAbonnements loop
			nbValuesIntoCursorList:= nbValuesIntoCursorList + 1;	
			--On sort de la boucle dès qu'il y a une valeur
			if nbValuesIntoCursorList > 0 then
				--On indique le fait que le curseur n'est pas vide
				cursorListIsEmpty := false;
				exit;
			end if;
		end loop;	
		
		--Si le curseur est vide alors on affiche un message indiquant qu'il n'y a pas de valeur
		if cursorListIsEmpty = true Then	
			htp.print('Il n''y a aucun abonnement de disponible.');	
		--Sinon, si le curseur contient au moins une valeur alors on affiche le tableau
		else		
			htp.tableOpen('',cattributes => 'class="tableau"');
				htp.tableheader('N° abonnement');
				htp.tableheader('Nom joueur');
				htp.tableheader('Date début');
				htp.tableheader('Durée (en mois)');
				htp.tableheader('Informations');
				htp.tableheader('Suppression');
				for currentAbonnement in listAbonnements loop
					htp.tableRowOpen;
					htp.tabledata(currentAbonnement.NUM_ABONNEMENT);
					htp.tabledata(currentAbonnement.NOM_PERSONNE);	
					htp.tabledata(currentAbonnement.DATE_DEBUT_ABONNEMENT);	
					htp.tabledata(currentAbonnement.DUREE_ABONNEMENT);
					htp.tabledata(htf.anchor('pq_ui_abonnement.dis_abonnement?pnumAbonnement='||currentAbonnement.NUM_ABONNEMENT,'Informations'));
					htp.tabledata(htf.anchor('pq_ui_abonnement.exec_del_abonnement?pnumAbonnement='||currentAbonnement.NUM_ABONNEMENT,'Supprimer', cattributes => 'onClick="return confirmerChoix(this,document)"'));
					htp.tableRowClose;
				end loop;	
			htp.tableClose;	
		end if;
	END liste_abonnements;
	
	--Permet d'afficher tous les abonnements et les actions possibles de gestion (avec le menu)
	PROCEDURE manage_abonnements
	IS	
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.aff_header;
		
		BEGIN
			pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
			IF perm=false THEN
				RAISE PERMISSION_DENIED;
			END IF;
			
			liste_abonnements;
			
		EXCEPTION
			WHEN PERMISSION_DENIED THEN
				pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusée.');
			WHEN OTHERS THEN
				pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Gestion des abonnements');
		END;
		
		pq_ui_commun.aff_footer;
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
		SELECT P.NUM_PERSONNE, P.NOM_PERSONNE
		FROM PERSONNE P
		WHERE P.STATUT_JOUEUR = 'A'
		ORDER BY P.NOM_PERSONNE;
			
		currentYearStart NUMBER(4) := to_number(to_char(sysdate,'YYYY'));
		currentYearEnd NUMBER(4) := to_number(to_char(sysdate,'YYYY'))+10;
		currentDebutDay NUMBER(2) := 0;
		currentDebutMonth NUMBER(2) := 0;
		currentDebutYear NUMBER(4) := 0;
		
		vmonth NUMBER(2) := to_number(to_char(sysdate,'MM'));

		nombreDuree NUMBER(2);
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
			htp.print('<input type="hidden" name="pdateDebut" id="dateDebut" />');
			htp.tableOpen;	
				htp.tableRowOpen;
					htp.tableData('Adhérent * :', cattributes => 'class="enteteFormulaire"');	
					--Forme une liste déroulante avec tous les adhérents à partir de la table PERSONNE									
					htp.print('<td>');
						htp.print('<select name="pnumJoueur">');						
						FOR currentAdherent in listeAdherents loop
							htp.print('<option value="'||currentAdherent.NUM_PERSONNE||'">'||currentAdherent.NOM_PERSONNE||'</option>');
						END LOOP; 																				
						htp.print('</select>');										
					htp.print('</td>');
					htp.print('<td id="numJoueurError" class="error"></td>');			
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Date début * :', cattributes => 'class="enteteFormulaire"');
					htp.print('<td>');	
					htp.print('<select id="dateDebutDay">');					
					FOR currentDebutDay in 1..31 loop	
						htp.print('<option>'||currentDebutDay||'</option>');								
					END LOOP; 																				
					htp.print('</select>');	
					htp.print('<select id="dateDebutMonth">');		
					FOR currentDebutMonth in 1..12 loop	
						IF currentDebutMonth = vmonth THEN
								htp.print('<option selected>'||currentDebutMonth||'</option>');
							ELSE
								htp.print('<option>'||currentDebutMonth||'</option>');
						END IF;							
					END LOOP;					 																				
					htp.print('</select>');	
					htp.print('<select id="dateDebutYear">');
					FOR currentDebutYear in currentYearStart..currentYearEnd loop	
						htp.print('<option>'||currentDebutYear||'</option>');
					END LOOP;
					htp.print('</select>');	
					htp.print('</td>');	
					htp.print('<td id="dateDebutError" class="error"></td>');
					--htp.tableData(htf.formText('pdateDebut'));
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Durée * :', cattributes => 'class="enteteFormulaire"');
					--htp.tableData(htf.formText('pduree'));
					htp.print('<td>');	
					htp.print('<select name="pduree">');								
					FOR nombreDuree in 1..24 loop	
						htp.print('<option>'||nombreDuree||'</option>');								
					END LOOP; 																				
					htp.print('</select>');	
					htp.print('</td>');	
					htp.print('<td id="dureeError" class="error"></td>');
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
		pq_ui_commun.aff_header;
		
		BEGIN
			pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
			IF perm=false THEN
				RAISE PERMISSION_DENIED;
			END IF;
			
			vnumJoueur := TO_NUMBER(pnumJoueur);
			vdateDebut := TO_DATE(pdateDebut, 'DD/MM/YYYY');
			vduree := TO_NUMBER(pduree);
			
			pq_db_abonnement.add_abonnement(vnumJoueur,vdateDebut,vduree);
			
			htp.print('<div class="success"> ');
				htp.print('L''abonnement a été ajouté avec succès.');
			htp.print('</div>');	
			
		EXCEPTION
			WHEN PERMISSION_DENIED THEN
				pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusée.');
			WHEN OTHERS THEN
				pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Ajout abonnement');
		END;
		
		liste_abonnements;
		
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error_permission_denied;
		WHEN DUP_VAL_ON_INDEX THEN
			pq_ui_commun.dis_error_custom('L''abonnement n''a pas été ajouté','','','pq_ui_abonnement.form_add_abonnement','Retour vers la création d''un abonnement');
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Ajout d''un abonnement en cours...');
	END exec_add_abonnement;
	
	-- Exécute la procédure de suppression d'un abonnement et gère les erreurs éventuelles
	PROCEDURE exec_del_abonnement(
	  pnumAbonnement IN VARCHAR2)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		vnumAbonnement ABONNEMENT.NUM_ABONNEMENT%TYPE;
	BEGIN
		pq_ui_commun.aff_header;
		
		BEGIN
			pq_ui_commun.ISAUTHORIZED(niveauP=>3,permission=>perm);
			IF perm=false THEN
				RAISE PERMISSION_DENIED;
			END IF;
			
			vnumAbonnement := TO_NUMBER(pnumAbonnement);
			pq_db_abonnement.del_abonnement(vnumAbonnement);
			
			htp.print('<div class="success"> ');
				htp.print('L''abonnement a été supprimé avec succès.');
			htp.print('</div>');	
			
		EXCEPTION
			WHEN PERMISSION_DENIED THEN
				pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Accès à la page refusée.');
			WHEN OTHERS THEN
				pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Nom de la page');
		END;
		
		liste_abonnements;
		
		pq_ui_commun.aff_footer;
	END exec_del_abonnement;
	
END pq_ui_abonnement;
/