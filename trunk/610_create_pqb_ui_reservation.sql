-- -----------------------------------------------------------------------------
--           Création du package d'interface d'affichage des données
--           pour les réservations
--                      Oracle Version 10g
--                        (10/5/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 09/06/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pq_ui_reservation
IS

	-- Affiche le formulaire de saisie d'une nouvelle reservation
	PROCEDURE form_add_reservation
	IS
		CURSOR listeJoueurs IS
		SELECT P.NUM_PERSONNE, P.NOM_PERSONNE 
		FROM PERSONNE P 
		ORDER BY P.NOM_PERSONNE;
		CURSOR listeCreneaux IS
		SELECT C.HEURE_DEBUT_CRENEAU, C.HEURE_FIN_CRENEAU
		FROM CRENEAU C
		ORDER BY C.HEURE_DEBUT_CRENEAU;
		CURSOR listeTerrains IS
		SELECT T.NUM_TERRAIN, C.LIBELLE as SURFACE
		FROM TERRAIN T INNER JOIN CODIFICATION C ON T.NATURE_SURFACE = C.NATURE AND T.CODE_SURFACE = C.CODE
		ORDER BY T.NUM_TERRAIN;
		
		currentYearStart NUMBER(4) := to_number(to_char(sysdate,'YYYY'));
		currentYearEnd NUMBER(4) := to_number(to_char(sysdate,'YYYY'))+10;
		currentDebutDay NUMBER(2) := 0;
		currentDebutMonth NUMBER(2) := 0;
		currentDebutYear NUMBER(4) := 0;
		vday NUMBER(2) := to_number(to_char(sysdate,'DD'));
		vmonth NUMBER(2) := to_number(to_char(sysdate,'MM'));
		vyear NUMBER(4) := to_number(to_char(sysdate,'YYYY'));
		
	BEGIN
		htp.print('Les champs marqués d''une étoile sont obligatoires.');
		htp.br;
		htp.br;	
		htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_reservation.exec_add_reservation', 'POST', cattributes => 'onSubmit="return validerReservation(this,document)"');				
			htp.print('<input type="hidden" name="pdate" id="myDate" value="vide"/>');
			htp.tableOpen;
				htp.tableRowOpen;
					htp.print('<td class="enteteFormulaire">Joueur * : </td>');								
					htp.print('<td>');
						htp.print('<select name="pnumJoueur">');				
						FOR joueur in listeJoueurs loop
							htp.print('<option value="'||joueur.NUM_PERSONNE||'">'||joueur.NOM_PERSONNE||'</option>');
						END LOOP;
						htp.print('</select>');									
					htp.print('</td>');					
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.print('<td class="enteteFormulaire">Date * : </td>');			
					htp.print('<td>');	
					htp.print('<select id="dateDay">');					
					FOR currentDay in 1..31 loop	
						IF currentDay = vday THEN
								htp.print('<option selected>'||currentDay||'</option>');
							ELSE
								htp.print('<option>'||currentDay||'</option>');
						END IF;						
					END LOOP; 																				
					htp.print('</select>');	
					htp.print('<select id="dateMonth">');								
					FOR currentMonth in 1..12 loop	
						IF currentMonth = vmonth THEN
								htp.print('<option selected>'||currentMonth||'</option>');
							ELSE
								htp.print('<option>'||currentMonth||'</option>');
						END IF;							
					END LOOP; 																				
					htp.print('</select>');	
					htp.print('<select id="dateYear">');
					FOR currentYear in currentYearStart..currentYearEnd loop	
						IF currentYear = vyear THEN
								htp.print('<option selected>'||currentYear||'</option>');
							ELSE
								htp.print('<option>'||currentYear||'</option>');
						END IF;	
					END LOOP;
					htp.print('</select>');	
					htp.print('</td>');	
					htp.print('<td id="dateError" class="error"></td>');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.print('<td class="enteteFormulaire">Créneau * : </td>');
					htp.print('<td>');
						htp.print('<select name="pheure">');
						FOR creneau in listeCreneaux loop
							htp.print('<option value="' || creneau.HEURE_DEBUT_CRENEAU||'">' || creneau.HEURE_DEBUT_CRENEAU || ' - ' || creneau.HEURE_FIN_CRENEAU||'</option>');
						END LOOP;
						htp.print('</select>');
					htp.print('</td>');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.print('<td class="enteteFormulaire">Terrain * : </td>');
					htp.print('<td>');
						htp.print('<select name="pnumTerrain">');				
						FOR terrain in listeTerrains loop
							htp.print('<option value="' || terrain.NUM_TERRAIN || '">' || terrain.NUM_TERRAIN || ' - ' || terrain.SURFACE ||'</option>');
						END LOOP;
						htp.print('</select>');
					htp.print('</td>');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('');
					htp.tableData(htf.formSubmit(NULL,'Valider'));
				htp.tableRowClose;
				htp.tableClose;
			htp.formClose;
			
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Ajout de réservation');
	END form_add_reservation;
	
	PROCEDURE liste_terrains
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		
		CURSOR terrains IS
		SELECT T.NUM_TERRAIN FROM TERRAIN T ORDER BY T.NUM_TERRAIN;
		
		currentYearStart NUMBER(4) := to_number(to_char(sysdate,'YYYY'));
		currentYearEnd NUMBER(4) := to_number(to_char(sysdate,'YYYY'))+10;
		currentDebutDay NUMBER(2) := 0;
		currentDebutMonth NUMBER(2) := 0;
		currentDebutYear NUMBER(4) := 0;
		vday NUMBER(2) := to_number(to_char(sysdate,'DD'));
		vmonth NUMBER(2) := to_number(to_char(sysdate,'MM'));
		vyear NUMBER(4) := to_number(to_char(sysdate,'YYYY'));
		
	BEGIN
		pq_ui_commun.aff_header;
		
		BEGIN
			pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
			IF perm=false THEN
				RAISE PERMISSION_DENIED;
			END IF;
			htp.br;
			htp.print('<div class="titre_niveau_1">');
				htp.print('Planning des réservations');
			htp.print('</div>');
			htp.br;
			htp.print('<p>Choisissez un terrain pour visualiser son planning</p>');
			htp.br;
			
			htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_reservation.planning_global', 'POST', cattributes => 'onSubmit="return validerDatePlanning(this,document)"');				
			htp.print('<input type="hidden" name="pdateDebut" id="date" />');
			htp.tableOpen;
				htp.tableRowOpen;
					htp.print('<td class="enteteFormulaire">N° terrain : </td>');
					htp.print('<td>');
						htp.print('<select name="pnumTerrain">');
						FOR terrain IN terrains LOOP
							htp.print('<option>' || terrain.NUM_TERRAIN || '</option>' );
						END LOOP;
						htp.print('</select>');
					htp.print('</td>');
				htp.tableRowClose;
				
				htp.tableRowOpen;
					htp.print('<td class="enteteFormulaire">Date * : </td>');			
					htp.print('<td>');	
					htp.print('<select id="dateDay">');					
					FOR currentDay in 1..31 loop	
						IF currentDay = vday THEN
								htp.print('<option selected>'||currentDay||'</option>');
							ELSE
								htp.print('<option>'||currentDay||'</option>');
						END IF;								
					END LOOP; 																				
					htp.print('</select>');	
					htp.print('<select id="dateMonth">');								
					FOR currentMonth in 1..12 loop	
						IF currentMonth = vmonth THEN
								htp.print('<option selected>'||currentMonth||'</option>');
							ELSE
								htp.print('<option>'||currentMonth||'</option>');
						END IF;							
					END LOOP; 																				
					htp.print('</select>');	
					htp.print('<select id="dateYear">');
					FOR currentYear in currentYearStart..currentYearEnd loop	
						IF currentYear = vyear THEN
								htp.print('<option selected>'||currentYear||'</option>');
							ELSE
								htp.print('<option>'||currentYear||'</option>');
							END IF;
					END LOOP;
					htp.print('</select>');	
					htp.print('</td>');	
					htp.print('<td id="dateError" class="error"></td>');
				htp.tableRowClose;
				
				htp.tableRowOpen;
					htp.print('<th></th>');
					htp.print('<td>');
					htp.print(htf.formSubmit(NULL,'Voir planning'));
					htp.print('</td>');
				htp.tableRowClose;
			htp.tableClose;
			htp.formClose;
			
			htp.hr;
			htp.br;
			htp.print('<div class="titre_niveau_1">');
				htp.print('Ajouter une réservation');
			htp.print('</div>');
			htp.br;
			
			form_add_reservation;
			
		EXCEPTION
			WHEN PERMISSION_DENIED THEN
				pq_ui_commun.dis_error_permission_denied;
			WHEN OTHERS THEN
				pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Gestion des réservations');
		END;
		
		pq_ui_commun.aff_footer;
	END liste_terrains;
	
	--	Affiche le planning d'un terrain à partir de la date spécifiée (pour 7 jours)
	PROCEDURE planning_global(
	  pdateDebut IN VARCHAR2
	, pnumTerrain IN VARCHAR2)
		
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		
		rep_img VARCHAR2(255) := pq_ui_param_commun.get_rep_img;
		
		vdateDebut OCCUPER.DATE_OCCUPATION%TYPE;
		vnumTerrain OCCUPER.NUM_TERRAIN%TYPE;
		
		CURSOR creneaux IS
		SELECT C.HEURE_DEBUT_CRENEAU, C.HEURE_FIN_CRENEAU
		FROM CRENEAU C
		ORDER BY C.HEURE_DEBUT_CRENEAU;
		
		--CURSOR occupations(dateDebut OCCUPER.DATE_OCCUPATION%TYPE, dateFin OCCUPER.DATE_OCCUPATION%TYPE, numTerrain OCCUPER.NUM_TERRAIN%TYPE) IS
		CURSOR occupations(dateDebut VARCHAR2, dateFin VARCHAR2, numTerrain OCCUPER.NUM_TERRAIN%TYPE) IS
		SELECT 
			  O.DATE_OCCUPATION
			, O.HEURE_DEBUT_CRENEAU
			, O.NUM_FACTURE
			, O.NUM_JOUEUR
			, P.NOM_PERSONNE
			, O.NUM_ENTRAINEMENT
			, E.LIB_ENTRAINEMENT
			, O.NUM_SEANCE
		FROM
			OCCUPER O LEFT OUTER JOIN PERSONNE P ON O.NUM_JOUEUR = P.NUM_PERSONNE
			LEFT OUTER JOIN ENTRAINEMENT E ON O.NUM_ENTRAINEMENT = E.NUM_ENTRAINEMENT
		WHERE 
			O.DATE_OCCUPATION >= to_date(dateDebut, 'DD/MM/YYYY')
			AND O.DATE_OCCUPATION <= to_date(dateFin, 'DD/MM/YYYY')
			AND O.NUM_TERRAIN = numTerrain
		ORDER BY O.HEURE_DEBUT_CRENEAU, O.DATE_OCCUPATION;
		
		vdateCourante DATE;
		vdateFin DATE;
		
		occDate OCCUPER.DATE_OCCUPATION%TYPE;
		occHeure OCCUPER.HEURE_DEBUT_CRENEAU%TYPE;
		occNumFacture OCCUPER.NUM_FACTURE%TYPE;
		occNumJoueur OCCUPER.NUM_JOUEUR%TYPE;
		occNomJoueur PERSONNE.NOM_PERSONNE%TYPE;
		occNumEntr OCCUPER.NUM_ENTRAINEMENT%TYPE;
		occLibEntr ENTRAINEMENT.LIB_ENTRAINEMENT%TYPE;
		occNumSeance OCCUPER.NUM_SEANCE%TYPE;
		
		vdatePrecedent DATE;
		vdateSuivant DATE;
		
		pdateFin VARCHAR2(50);
		vboolDateFetch NUMBER(1);
		vtypeResa NUMBER(1); --	entier qui identifie le type de réservation (1 pour réservation de joueur, 2 pour séance d'entrainement,... , 0 pour les autres, -1 pour aucun type)
	BEGIN
		pq_ui_commun.aff_header;
		
		BEGIN
			pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
			IF perm=false THEN
				RAISE PERMISSION_DENIED;
			END IF;
			
			vdateDebut := to_date(pdateDebut, 'DD/MM/YYYY');
			vnumTerrain := to_number(pnumTerrain);
			
			-- ...
			vdateCourante := vdateDebut;
			vdateFin := vdateDebut + 6;
			
			
			htp.br;
			htp.print('<div class="titre_niveau_1">');
			htp.print('Planning du terrain n° ' || vnumTerrain);
			htp.print('</div>');
			
			pdateFin := to_char(vdateFin, 'DD/MM/YYYY');
			
			--	Liens vers semaine suivante et precédente
			vdatePrecedent := vdateDebut - 7;
			vdateSuivant := vdateDebut + 7;
			htp.br;
			htp.print(htf.anchor('pq_ui_reservation.planning_global?pdateDebut=' || to_char(vdatePrecedent,'DD/MM/YYYY') || '&' || 'pnumTerrain=' || vnumTerrain,'Semaine précédente'));
			htp.print(htf.anchor('pq_ui_reservation.planning_global?pdateDebut=' || to_char(vdateSuivant,'DD/MM/YYYY') || '&' || 'pnumTerrain=' || vnumTerrain,'Semaine suivante'));
			htp.br;
			
			htp.tableOpen('',cattributes => 'class="tableau planning"');
			
			--	Ecriture des dates en première ligne de tableau
			htp.tableRowOpen;
			htp.tableheader('');
			vdateCourante := vdateDebut;
			vdateFin := vdateDebut + 6;
			WHILE vdateCourante <= vdateFin LOOP
				htp.tableheader(vdateCourante);
				vdateCourante := vdateCourante + 1;
			END LOOP;
			htp.tableRowClose;
			
			--	insert into occuper(date_occupation, heure_debut_creneau, num_terrain) values (to_date('14/09/2011','DD/MM/YYYY'), '07h00', 1);
			--	insert into occuper(date_occupation, heure_debut_creneau, num_terrain, num_joueur) values (to_date('14/09/2011','DD/MM/YYYY'), '08h00', 1, 16);
			
			--	Ecriture des lignes correspondant aux créneaux
			--	Ouverture du curseur
			OPEN occupations(pdateDebut, pdateFin, vnumTerrain);
			vdateCourante := vdateDebut;
			
			--	booléen indiquant si on doit récupérer une nouvelle ligne
			vboolDateFetch := 1;
			vtypeResa := -1;
			
			FOR creneau IN creneaux LOOP
				htp.tableRowOpen;
				htp.tableheader(creneau.HEURE_DEBUT_CRENEAU || '-' || creneau.HEURE_FIN_CRENEAU);
				
				--	On remplit une ligne de créneau
				LOOP
					--	Si on a déjà une ligne qu'on n'a pas encore affichée, on essaye de l'afficher, sinon on passe à la suivante
					IF vboolDateFetch = 1 THEN
						FETCH occupations INTO occDate, occHeure, occNumFacture, occNumJoueur, occNomJoueur, occNumEntr, occLibEntr, occNumSeance;
						vboolDateFetch := 0;
						vtypeResa := 0;
						IF NOT occNumJoueur IS NULL THEN
							vtypeResa := 1;
						END IF;
						IF NOT occNumEntr IS NULL THEN
							vtypeResa := 2;
						END IF;
					END IF;
					
					EXIT WHEN occHeure <> creneau.HEURE_DEBUT_CRENEAU OR occupations%NOTFOUND OR vdateCourante > vdateFin;
					WHILE vdateCourante < occDate LOOP
						htp.print('<td>');
						IF vdateCourante >= SYSDATE - 1 THEN
						htp.print('<a href="pq_ui_reservation.form_add_reservation?pnumTerrain=' || pnumTerrain || '&' || 'pdate=' || to_char(vdateCourante, 'DD/MM/YYYY') || '&' || 'pheure=' || creneau.HEURE_DEBUT_CRENEAU || '">');
						htp.print('<img title="Ajouter une réservation" alt="Ajouter réservation" src="' || rep_img || 'add.png" class="icone" />');
						htp.print('</a>');
						--htp.tableData(htf.anchor('pq_ui_reservation.form_add_reservation?pnumTerrain=' || pnumTerrain || '&' || 'pdate=' || to_char(vdateCourante, 'DD/MM/YYYY') || '&' || 'pheure=' || creneau.HEURE_DEBUT_CRENEAU ,'Ajouter réservation')) ;
						END IF;
						htp.print('</td>');
						vdateCourante := vdateCourante + 1;
					END LOOP;
					htp.print('<td class="');
					IF vtypeResa = 0 THEN
						htp.print(' resaAutre ');
					END IF;
					IF vtypeResa = 1 THEN
						htp.print(' resaJoueur ');
					END IF;
					IF vtypeResa = 2 THEN
						htp.print(' resaEntr ');
					END IF;
					htp.print('">');
					IF vtypeResa = 0 THEN
						htp.print('Autre réservation' || occNomJoueur);
					END IF;
					IF vtypeResa = 1 THEN
						htp.print('Joueur : ' || occNomJoueur);
						htp.br;
						htp.print('<a href="pq_ui_reservation.dis_reservation?pdate=' || to_char(vdateCourante, 'DD/MM/YYYY') || '&' || 'pnumTerrain=' || vnumTerrain || '&' || 'pheureDebut=' || occHeure || '">');
						htp.print('<img title="Voir la réservation" alt="Infos" src="' || rep_img || 'preview.png" class="icone" />');
						htp.print('</a>');
						htp.print('<a href="pq_ui_reservation.form_upd_reservation?pdate=' || to_char(vdateCourante, 'DD/MM/YYYY') || '&' || 'pnumTerrain=' || vnumTerrain || '&' || 'pheure=' || occHeure || '">');
						htp.print('<img title="Modifier la réservation" alt="Modif" src="' || rep_img || 'edit.png" class="icone" />');
						htp.print('</a>');
						htp.print('<a href="pq_ui_reservation.exec_del_reservation?pdate=' || to_char(vdateCourante, 'DD/MM/YYYY') || '&' || 'pnumTerrain=' || vnumTerrain || '&' || 'pheure=' || occHeure || '" onClick="return confirmerChoix(this,document)">');
						htp.print('<img title="Supprimer la réservation" alt="Suppr" src="' || rep_img || 'delete.png" class="icone" />');
						htp.print('</a>');
						--htp.print(htf.anchor('pq_ui_reservation.dis_reservation?pdate=' || to_char(vdateCourante, 'DD/MM/YYYY') || '&' || 'pnumTerrain=' || vnumTerrain || '&' || 'pheureDebut=' || occHeure ,'Infos'));
						--htp.print(htf.anchor('pq_ui_reservation.form_upd_reservation?pdate=' || to_char(vdateCourante, 'DD/MM/YYYY') || '&' || 'pnumTerrain=' || vnumTerrain || '&' || 'pheure=' || occHeure ,'Modif'));	
						--htp.print(htf.anchor('pq_ui_reservation.exec_del_reservation?pdate=' || to_char(vdateCourante, 'DD/MM/YYYY') || '&' || 'pnumTerrain=' || vnumTerrain || '&' || 'pheure=' || occHeure ,'Suppr', cattributes => 'onClick="return confirmerChoix(this,document)"'));	
					END IF;
					IF vtypeResa = 2 THEN
						htp.print('Entrainement : ' || htf.anchor('pq_ui_entrainement.exec_dis_entrainement?vnumEntrainement=' || occNumEntr,occLibEntr) );
					END IF;
					htp.print('</td>');
					vdateCourante := vdateCourante + 1;
					vboolDateFetch := 1;
					vtypeResa := -1;
				END LOOP;
				
				--	On complète la ligne avec des cases libres
				WHILE vdateCourante <= vdateFin LOOP
					--htp.tableData(htf.anchor('pq_ui_reservation.form_add_reservation?pnumTerrain=' || pnumTerrain || '&' || 'pdate=' || to_char(vdateCourante, 'DD/MM/YYYY') || '&' || 'pheure=' || creneau.HEURE_DEBUT_CRENEAU ,'Ajouter réservation')) ;					
					htp.print('<td>');
					IF vdateCourante >= SYSDATE - 1 THEN
					htp.print('<a href="pq_ui_reservation.form_add_reservation?pnumTerrain=' || pnumTerrain || '&' || 'pdate=' || to_char(vdateCourante, 'DD/MM/YYYY') || '&' || 'pheure=' || creneau.HEURE_DEBUT_CRENEAU || '">');
					htp.print('<img title="Ajouter une réservation" alt="Ajouter réservation" src="' || rep_img || 'add.png" class="icone" />');
					htp.print('</a>');
					--htp.tableData(htf.anchor('pq_ui_reservation.form_add_reservation?pnumTerrain=' || pnumTerrain || '&' || 'pdate=' || to_char(vdateCourante, 'DD/MM/YYYY') || '&' || 'pheure=' || creneau.HEURE_DEBUT_CRENEAU ,'Ajouter réservation')) ;
					END IF;
					htp.print('</td>');
					vdateCourante := vdateCourante + 1;
					
				END LOOP;
				vdateCourante := vdateDebut;
				
				htp.tableRowClose;
			END LOOP;
			
			CLOSE occupations;
			htp.tableClose;
			
		EXCEPTION
			WHEN PERMISSION_DENIED THEN
				pq_ui_commun.dis_error_permission_denied;
			WHEN OTHERS THEN
				pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Planning global');
		END;
		
		pq_ui_commun.aff_footer;
	END planning_global;
	
	PROCEDURE liste_reservations(
		  pdateDebut IN DATE
		, pdateFin IN DATE)
	IS
		CURSOR listeReservations IS
		SELECT 
			  to_char(O.DATE_OCCUPATION, 'DD/MM/YYYY') as DATE_OCCUPATION
			, O.NUM_TERRAIN
			, P.NOM_PERSONNE
			, C.HEURE_DEBUT_CRENEAU
			, C.HEURE_FIN_CRENEAU
			, O.NUM_FACTURE
		FROM 
			OCCUPER O INNER JOIN CRENEAU C ON O.HEURE_DEBUT_CRENEAU = C.HEURE_DEBUT_CRENEAU
				INNER JOIN PERSONNE P ON O.NUM_JOUEUR = P.NUM_PERSONNE
		WHERE
			O.DATE_OCCUPATION > pdateDebut
			AND O.DATE_OCCUPATION < pdateFin
		ORDER BY 
			O.DATE_OCCUPATION;
			
	BEGIN	
		htp.print('<div class="titre_niveau_1">');
			htp.print('Liste des réservations entre le ' || to_char(pdateDebut, 'DD/MM/YYYY') || ' et le ' || to_char(pdateFin, 'DD/MM/YYYY') );
		htp.print('</div>');	
		htp.br;	
		htp.br;	
		htp.print(htf.anchor('pq_ui_reservation.form_add_reservation','Ajouter une réservation'));
		htp.br;	
		htp.br;
		htp.tableOpen('',cattributes => 'class="tableau"');
			htp.tableheader('Date');
			htp.tableheader('Terrain');
			htp.tableheader('Joueur');
			htp.tableheader('Début créneau');
			htp.tableheader('Fin créneau');
			htp.tableheader('Facture');
			htp.tableheader('Informations');
			htp.tableheader('Mise à jour');
			htp.tableheader('Suppression');
			for reservation in listeReservations loop
				htp.tableRowOpen;
				htp.tabledata(reservation.DATE_OCCUPATION);
				htp.tabledata(reservation.NUM_TERRAIN);		
				htp.tabledata(reservation.NOM_PERSONNE);		
				htp.tabledata(reservation.HEURE_DEBUT_CRENEAU);		
				htp.tabledata(reservation.HEURE_FIN_CRENEAU);		
				htp.tabledata(reservation.NUM_FACTURE);	
				htp.tabledata(htf.anchor('pq_ui_reservation.dis_reservation?pdate=' || reservation.DATE_OCCUPATION || '&' || 'pnumTerrain=' || reservation.NUM_TERRAIN || '&' || 'pheureDebut=' || reservation.HEURE_DEBUT_CRENEAU ,'Informations'));
				htp.tabledata(htf.anchor('pq_ui_reservation.form_upd_reservation?pdate=' || reservation.DATE_OCCUPATION || '&' || 'pnumTerrain=' || reservation.NUM_TERRAIN || '&' || 'pheureDebut=' || reservation.HEURE_DEBUT_CRENEAU ,'Modifier'));
				htp.tabledata(htf.anchor('pq_ui_reservation.exec_del_reservation?pdate=' || reservation.DATE_OCCUPATION || '&' || 'pnumTerrain=' || reservation.NUM_TERRAIN || '&' || 'pheureDebut=' || reservation.HEURE_DEBUT_CRENEAU ,'Supprimer',cattributes => 'onClick="return confirmerChoix(this,document)"'));
				htp.tableRowClose;
			end loop;	
		htp.tableClose;
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Gestion des factures');
	END liste_reservations;
	
	--Affiche le panneau de gestion des réservations
	PROCEDURE manage_reservations
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.aff_header;
		
		BEGIN
			pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
			IF perm=false THEN
				RAISE PERMISSION_DENIED;
			END IF;
			
			liste_reservations(sysdate, sysdate + 7);
			
		EXCEPTION
			WHEN PERMISSION_DENIED THEN
				pq_ui_commun.dis_error_permission_denied;
			WHEN OTHERS THEN
				pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Liste des réservations');
		END;
		
		pq_ui_commun.aff_footer;
	END manage_reservations;

	--Affiche une reservation existante
	PROCEDURE dis_reservation(
	  pnumTerrain IN VARCHAR2
	, pdate IN VARCHAR2
	, pheureDebut IN VARCHAR2)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		
		vdate OCCUPER.DATE_OCCUPATION%TYPE;
		vnumTerrain OCCUPER.NUM_TERRAIN%TYPE;
		vnomJoueur PERSONNE.NOM_PERSONNE%TYPE;
		vheureDebut OCCUPER.HEURE_DEBUT_CRENEAU%TYPE;
		vheureFin CRENEAU.HEURE_FIN_CRENEAU%TYPE;
		vnumFacture OCCUPER.NUM_FACTURE%TYPE;
	BEGIN
		pq_ui_commun.aff_header;
		
		BEGIN
			pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
			IF perm=false THEN
				RAISE PERMISSION_DENIED;
			END IF;
			
			vdate := to_date(pdate, 'DD/MM/YYYY');
			vnumTerrain := to_number(pnumTerrain);
			vheureDebut := pheureDebut;
			
			SELECT 
				  P.NOM_PERSONNE
				, C.HEURE_FIN_CRENEAU
				, O.NUM_FACTURE
			INTO
				  vnomJoueur
				, vheureFin
				, vnumFacture
			FROM 
				OCCUPER O INNER JOIN CRENEAU C ON O.HEURE_DEBUT_CRENEAU = C.HEURE_DEBUT_CRENEAU
					INNER JOIN PERSONNE P ON O.NUM_JOUEUR = P.NUM_PERSONNE
			WHERE
				O.DATE_OCCUPATION = vdate
				AND O.NUM_TERRAIN = vnumTerrain
				AND O.HEURE_DEBUT_CRENEAU = vheureDebut;
			
			htp.br;
			htp.print('<div class="titre_niveau_1">');
				htp.print('Informations de réservation');
			htp.print('</div>');				
			htp.br;
			
			htp.tableOpen('',cattributes => 'class="tableau"');
				htp.tableRowOpen;
					htp.tableHeader('Terrain : ');
					htp.tableData(vnumTerrain);
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableHeader('Date : ');
					htp.tableData(vdate);
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableHeader('Créneau : ');
					htp.tableData(vheureDebut || ' - ' || vheureFin);
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableHeader('Joueur : ');
					htp.tableData(vnomJoueur);		
				htp.tableRowClose;
				IF vnumFacture >= 0 THEN
				htp.tableRowOpen;
					htp.tableHeader('Facture : ');
					htp.tableData(htf.anchor('pq_ui_facture.dis_facture?pnumFacture=' || vnumFacture ,'Voir la facture associée'));		
				htp.tableRowClose;
				END IF;
			htp.tableClose;
			htp.br;
			htp.print(htf.anchor('pq_ui_reservation.planning_global?pdateDebut=' || to_char(vdate - 3, 'DD/MM/YYYY') || '&' || 'pnumTerrain=' || vnumTerrain ,'Retour au planning'));
			htp.br;
			
		EXCEPTION
			WHEN PERMISSION_DENIED THEN
				pq_ui_commun.dis_error_permission_denied;
			WHEN OTHERS THEN
				pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Affichage réservation');
		END;
		
		pq_ui_commun.aff_footer;
	END dis_reservation;
	
	PROCEDURE form_add_reservation(
	  pnumTerrain IN VARCHAR2
	, pdate IN VARCHAR2
	, pheure IN VARCHAR2)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		
		CURSOR listeJoueurs IS
		SELECT P.NUM_PERSONNE, P.NOM_PERSONNE 
		FROM PERSONNE P 
		ORDER BY P.NOM_PERSONNE;
		
		vnumTerrain OCCUPER.NUM_TERRAIN%TYPE;
		vdate OCCUPER.DATE_OCCUPATION%TYPE;
		
	BEGIN
		pq_ui_commun.aff_header;
		
		BEGIN
			pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
			IF perm=false THEN
				RAISE PERMISSION_DENIED;
			END IF;
			
			vnumTerrain := to_number(pnumTerrain);
			vdate := to_date(pdate, 'DD/MM/YYYY');
			
			htp.br;
			htp.print('<div class="titre_niveau_1">');
				htp.print('Création de réservation');
			htp.print('</div>');				
			htp.br;
			htp.br;
			htp.print('Les champs marqués d''une étoile sont obligatoires.');
			htp.br;
			htp.br;	
			htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_reservation.exec_add_reservation', 'POST');				
				htp.print('<input type="hidden" name="pnumTerrain" value="' || pnumTerrain || '" />');
				htp.print('<input type="hidden" name="pdate" value="' || pdate || '" />');
				htp.print('<input type="hidden" name="pheure" value="' || pheure || '" />');
				htp.tableOpen('',cattributes => 'class="tableau"');
					htp.tableRowOpen;
						htp.print('<th>Terrain : </th>');
						htp.print('<td>');
							htp.print(pnumTerrain);
						htp.print('</td>');
					htp.tableRowClose;
					htp.tableRowOpen;
						htp.print('<th>Date : </th>');
						htp.tableData(pdate);
					htp.tableRowClose;
					htp.tableRowOpen;
						htp.print('<th>Créneau : </th>');
						htp.print('<td>');
							htp.print(pheure);
						htp.print('</td>');
					htp.tableRowClose;
					htp.tableRowOpen;
						htp.print('<th>Joueur * : </th>');								
						htp.print('<td>');
							htp.print('<select name="pnumJoueur">');				
							FOR joueur in listeJoueurs loop
								htp.print('<option value="'||joueur.NUM_PERSONNE||'">'||joueur.NOM_PERSONNE||'</option>');
							END LOOP;
							htp.print('</select>');									
						htp.print('</td>');					
					htp.tableRowClose;
					htp.tableRowOpen;
						htp.tableData('');
						htp.tableData(htf.formSubmit(NULL,'Valider'));
					htp.tableRowClose;
				htp.tableClose;
			htp.formClose;
			htp.br;
			htp.print(htf.anchor('pq_ui_reservation.planning_global?pdateDebut=' || to_char(vdate - 3, 'DD/MM/YYYY') || '&' || 'pnumTerrain=' || vnumTerrain ,'Retour au planning'));
			htp.br;
			
		EXCEPTION
			WHEN PERMISSION_DENIED THEN
				pq_ui_commun.dis_error_permission_denied;
			WHEN OTHERS THEN
				pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Ajout de réservation');
		END;
		
		pq_ui_commun.aff_footer;
	END form_add_reservation;
	
	-- Exécute la procédure d'ajout d'une reservation et gère les erreurs éventuelles.
	PROCEDURE exec_add_reservation(
		  pnumTerrain IN VARCHAR2
		, pdate IN VARCHAR2
		, pheure IN VARCHAR2
		, pnumJoueur IN VARCHAR2)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		
		dateAnterieure EXCEPTION;
		
		vnumTerrain OCCUPER.NUM_TERRAIN%TYPE;
		vdate OCCUPER.DATE_OCCUPATION%TYPE;
		vheure OCCUPER.HEURE_DEBUT_CRENEAU%TYPE;
		vnumJoueur  OCCUPER.NUM_JOUEUR%TYPE;
	BEGIN
		pq_ui_commun.aff_header;
		
		BEGIN
			pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
			IF perm=false THEN
				RAISE PERMISSION_DENIED;
			END IF;
			
			vnumTerrain := to_number(pnumTerrain);
			vdate := to_date(pdate, 'DD/MM/YYYY');
			vheure := pheure;
			vnumJoueur := to_number(pnumJoueur);
			
			IF vdate < SYSDATE - 1 THEN
				RAISE dateAnterieure;
			END IF;
			
			pq_db_reservation.add_reservation(vnumTerrain, vdate, vheure, vnumJoueur);			
			htp.br;
			htp.print('<div class="success"> ');
				htp.print('La réservation a été créée avec succès');
			htp.print('</div>');	
			htp.br;
			htp.print(htf.anchor('pq_ui_reservation.planning_global?pdateDebut=' || to_char(vdate - 3, 'DD/MM/YYYY') || '&' || 'pnumTerrain=' || vnumTerrain ,'Retour au planning'));
			htp.br;
			
		EXCEPTION
			WHEN PERMISSION_DENIED THEN
				pq_ui_commun.dis_error_permission_denied;
			WHEN dateAnterieure THEN
				pq_ui_commun.dis_error_custom('Ajout impossible','Il est impossible d''affecter une date passée à une réservation.','Choisissez une autre date','pq_ui_reservation.planning_global?pdateDebut=' || to_char(vdate - 3, 'DD/MM/YYYY') || '&' || 'pnumTerrain=' || vnumTerrain ,'Retour au planning');
			WHEN OTHERS THEN
				pq_ui_commun.dis_error_custom('Ajout impossible','Il est impossible d''ajouter cette réservation.','Vérifiez les abonnements du joueur ou la disponibilité du créneau sélectionné','pq_ui_reservation.planning_global?pdateDebut=' || to_char(vdate - 3, 'DD/MM/YYYY') || '&' || 'pnumTerrain=' || vnumTerrain ,'Retour au planning');
		END;
		
		pq_ui_commun.aff_footer;
	END exec_add_reservation;
	
	-- Affiche le formulaire de modification d’une reservation existante
	PROCEDURE form_upd_reservation(
	  pnumTerrain IN VARCHAR2
	, pdate IN VARCHAR2
	, pheure IN VARCHAR2)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		
		CURSOR listeJoueurs IS
		SELECT P.NUM_PERSONNE, P.NOM_PERSONNE 
		FROM PERSONNE P 
		ORDER BY P.NOM_PERSONNE;
		CURSOR listeCreneaux IS
		SELECT C.HEURE_DEBUT_CRENEAU, C.HEURE_FIN_CRENEAU
		FROM CRENEAU C
		ORDER BY C.HEURE_DEBUT_CRENEAU;
		CURSOR listeTerrains IS
		SELECT T.NUM_TERRAIN, C.LIBELLE as SURFACE
		FROM TERRAIN T INNER JOIN CODIFICATION C ON T.NATURE_SURFACE = C.NATURE AND T.CODE_SURFACE = C.CODE
		ORDER BY T.NUM_TERRAIN;
		
		currentYearStart NUMBER(4) := to_number(to_char(sysdate,'YYYY'));
		currentYearEnd NUMBER(4) := to_number(to_char(sysdate,'YYYY'))+10;
		currentDebutDay NUMBER(2) := 0;
		currentDebutMonth NUMBER(2) := 0;
		currentDebutYear NUMBER(4) := 0;
		vday NUMBER(2);
		vmonth NUMBER(2);
		vyear NUMBER(4);
		
		vnumTerrain OCCUPER.NUM_TERRAIN%TYPE;
		vdate OCCUPER.DATE_OCCUPATION%TYPE;
		vheure OCCUPER.HEURE_DEBUT_CRENEAU%TYPE;
		vnumJoueur OCCUPER.NUM_JOUEUR%TYPE;
		
	BEGIN
		pq_ui_commun.aff_header;
		
		BEGIN
			pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
			IF perm=false THEN
				RAISE PERMISSION_DENIED;
			END IF;
			
			vnumTerrain := to_number(pnumTerrain);
			vdate := to_date(pdate, 'DD/MM/YYYY');
			vheure := pheure;
			vday := to_number(to_char(vdate, 'DD'));
			vmonth := to_number(to_char(vdate, 'MM'));
			vyear := to_number(to_char(vdate, 'YYYY'));
			
			SELECT O.NUM_JOUEUR INTO vnumJoueur FROM OCCUPER O
			WHERE 
				O.NUM_TERRAIN = vnumTerrain
				AND O.DATE_OCCUPATION = vdate
				AND O.HEURE_DEBUT_CRENEAU = vheure;
			
			htp.print('<div class="titre_niveau_1">');
				htp.print('Modification de réservation');
			htp.print('</div>');
			htp.br;
			htp.br;
			htp.print('Les champs marqués d''une étoile sont obligatoires.');
			htp.br;
			htp.br;	
			htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_reservation.exec_upd_reservation', 'POST', cattributes => 'onSubmit="return validerReservation(this,document)"');
				htp.print('<input type="hidden" name="pnumTerrainOld" value="' || pnumTerrain || '" />');
				htp.print('<input type="hidden" name="pdateOld" value="' || pdate || '" />');
				htp.print('<input type="hidden" name="pheureOld" value="' || pheure || '" />');
				htp.print('<input type="hidden" name="pdate" id="myDate" value="vide"/>');
				htp.tableOpen('',cattributes => 'class="tableau"');
					htp.tableRowOpen;
						htp.print('<th>Joueur * : </th>');				
						htp.print('<td>');
							htp.print('<select name="pnumJoueur">');				
							FOR joueur in listeJoueurs loop
								htp.print('<option value="' || joueur.NUM_PERSONNE || '"');
								IF joueur.NUM_PERSONNE = vnumJoueur THEN
									htp.print('selected');
								END IF;
								htp.print('>' || joueur.NOM_PERSONNE || '</option>');
							END LOOP;
							htp.print('</select>');									
						htp.print('</td>');					
					htp.tableRowClose;
					htp.tableRowOpen;
						htp.print('<th>Date * : </th>');			
						htp.print('<td>');	
						htp.print('<select id="dateDay">');					
						FOR currentDay in 1..31 loop
							IF currentDay = vday THEN
								htp.print('<option selected>'||currentDay||'</option>');
							ELSE
								htp.print('<option>'||currentDay||'</option>');								
							END IF;
						END LOOP; 																				
						htp.print('</select>');	
						htp.print('<select id="dateMonth">');								
						FOR currentMonth in 1..12 loop	
							IF currentMonth = vmonth THEN
								htp.print('<option selected>'||currentMonth||'</option>');
							ELSE
								htp.print('<option>'||currentMonth||'</option>');
							END IF;
						END LOOP; 																				
						htp.print('</select>');	
						htp.print('<select id="dateYear">');
						FOR currentYear in currentYearStart..currentYearEnd loop	
							IF currentYear = vyear THEN
								htp.print('<option selected>'||currentYear||'</option>');
							ELSE
								htp.print('<option>'||currentYear||'</option>');
							END IF;
						END LOOP;
						htp.print('</select>');	
						htp.print('</td>');	
						htp.print('<td id="dateError" class="error"></td>');
					htp.tableRowClose;
					htp.tableRowOpen;
						htp.print('<th>Créneau * : </th>');
						htp.print('<td>');
							htp.print('<select name="pheure">');
							FOR creneau in listeCreneaux loop
								htp.print('<option value="' || creneau.HEURE_DEBUT_CRENEAU || '"');
								IF creneau.HEURE_DEBUT_CRENEAU = vheure THEN
									htp.print('selected');
								END IF;
								htp.print('>' || creneau.HEURE_DEBUT_CRENEAU || ' - ' || creneau.HEURE_FIN_CRENEAU||'</option>');
							END LOOP;
							htp.print('</select>');
						htp.print('</td>');
					htp.tableRowClose;
					htp.tableRowOpen;
						htp.print('<th>Terrain * : </th>');
						htp.print('<td>');
							htp.print('<select name="pnumTerrain">');				
							FOR terrain in listeTerrains loop
								htp.print('<option value="' || terrain.NUM_TERRAIN || '"');
								IF terrain.NUM_TERRAIN = vnumTerrain THEN
									htp.print('selected');
								END IF;
								htp.print('>' || terrain.NUM_TERRAIN || ' - ' || terrain.SURFACE ||'</option>');
							END LOOP;
							htp.print('</select>');
						htp.print('</td>');
					htp.tableRowClose;
					htp.tableRowOpen;
						htp.tableData('');
						htp.tableData(htf.formSubmit(NULL,'Valider'));
					htp.tableRowClose;
					htp.tableClose;
				htp.formClose;
			htp.br;
			htp.print(htf.anchor('pq_ui_reservation.planning_global?pdateDebut=' || to_char(vdate - 3, 'DD/MM/YYYY') || '&' || 'pnumTerrain=' || vnumTerrain ,'Retour au planning'));
			htp.br;
			
		EXCEPTION
			WHEN PERMISSION_DENIED THEN
				pq_ui_commun.dis_error_permission_denied;
			WHEN OTHERS THEN
				pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Formulaire modification de réservation');
		END;
		
		pq_ui_commun.aff_footer;
	END form_upd_reservation;
	
	-- Exécute la procédure de mise à jour d'une reservation et gère les erreurs éventuelles
	PROCEDURE exec_upd_reservation(
	  pnumTerrainOld IN VARCHAR2
	, pdateOld IN VARCHAR2
	, pheureOld IN VARCHAR2
	, pnumTerrain IN VARCHAR2
	, pdate IN VARCHAR2
	, pheure IN VARCHAR2
	, pnumJoueur IN VARCHAR2)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		
		dateOldAnterieure EXCEPTION;
		dateAnterieure EXCEPTION;
		
		vnumTerrainOld OCCUPER.NUM_TERRAIN%TYPE;
		vdateOld OCCUPER.DATE_OCCUPATION%TYPE;
		vheureOld OCCUPER.HEURE_DEBUT_CRENEAU%TYPE;
		vnumTerrain OCCUPER.NUM_TERRAIN%TYPE;
		vdate OCCUPER.DATE_OCCUPATION%TYPE;
		vheure OCCUPER.HEURE_DEBUT_CRENEAU%TYPE;
		vnumJoueur OCCUPER.NUM_JOUEUR%TYPE;
	BEGIN
		pq_ui_commun.aff_header;
		
		BEGIN
			pq_ui_commun.ISAUTHORIZED(niveauP=>2,permission=>perm);
			IF perm=false THEN
				RAISE PERMISSION_DENIED;
			END IF;
			
			vnumTerrain := to_number(pnumTerrain);
			vdate := to_date(pdate, 'DD/MM/YYYY');
			vheure := pheure;
			vnumJoueur := to_number(pnumJoueur);
			
			vnumTerrainOld := to_number(pnumTerrainOld);
			vdateOld := to_date(pdateOld, 'DD/MM/YYYY');
			vheureOld := pheureOld;
			
			IF vdateOld < SYSDATE - 1 THEN
				RAISE dateOldAnterieure;
			END IF;
			
			IF vdate < SYSDATE - 1 THEN
				RAISE dateAnterieure;
			END IF;
			
			pq_db_reservation.upd_reservation(vnumTerrainOld, vdateOld, vheureOld, vnumTerrain, vdate, vheure, vnumJoueur);
			htp.br;
			htp.print('<div class="success"> ');
				htp.print('La réservation a été mise à jour avec succès.');
			htp.print('</div>');	
			htp.br;
			htp.print(htf.anchor('pq_ui_reservation.planning_global?pdateDebut=' || to_char(vdate - 3, 'DD/MM/YYYY') || '&' || 'pnumTerrain=' || vnumTerrain ,'Retour au planning'));
			
		EXCEPTION
			WHEN PERMISSION_DENIED THEN
				pq_ui_commun.dis_error_permission_denied;
			WHEN dateOldAnterieure THEN
				pq_ui_commun.dis_error_custom('Modification impossible','Il est impossible de modifier une réservation qui est déjà passée.','Choisissez une autre réservation','pq_ui_reservation.planning_global?pdateDebut=' || to_char(vdateOld - 3, 'DD/MM/YYYY') || '&' || 'pnumTerrain=' || vnumTerrainOld ,'Retour au planning');
			WHEN dateAnterieure THEN
				pq_ui_commun.dis_error_custom('Modification impossible','Il est impossible d''affecter une date passée à une réservation.','Choisissez une autre date','pq_ui_reservation.planning_global?pdateDebut=' || to_char(vdateOld - 3, 'DD/MM/YYYY') || '&' || 'pnumTerrain=' || vnumTerrainOld ,'Retour au planning');
			WHEN OTHERS THEN				
				pq_ui_commun.dis_error_custom('Modification impossible','La réservation ne peut pas être modifiée.','Vérifiez les réservations pour la date sélectionnée et le terrain sélectionné','pq_ui_reservation.planning_global?pdateDebut=' || to_char(vdateOld - 3, 'DD/MM/YYYY') || '&' || 'pnumTerrain=' || vnumTerrainOld ,'Retour au planning');
		END;
		
		pq_ui_commun.aff_footer;
	END exec_upd_reservation;
	
	-- Exécute la procédure de suppression d'une reservation et gère les erreurs éventuelles
	PROCEDURE exec_del_reservation(
		  pnumTerrain IN VARCHAR2
		, pdate IN VARCHAR2
		, pheure IN VARCHAR2)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		
		dateAnterieure EXCEPTION;
		
		vdate OCCUPER.DATE_OCCUPATION%TYPE;
		vnumTerrain OCCUPER.NUM_TERRAIN%TYPE;
		vheure OCCUPER.HEURE_DEBUT_CRENEAU%TYPE;
	BEGIN
		pq_ui_commun.aff_header;
		
		BEGIN
			pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
			IF perm=false THEN
				RAISE PERMISSION_DENIED;
			END IF;
			
			vdate := to_date(pdate, 'DD/MM/YYYY');
			vnumTerrain := to_number(pnumTerrain);
			vheure := pheure;
			
			IF vdate < SYSDATE - 1 THEN
				RAISE dateAnterieure;
			END IF;
			
			pq_db_reservation.del_reservation(vnumTerrain, vdate, vheure);
			htp.br;
			htp.print('<div class="success"> ');
				htp.print('La réservation a été supprimée avec succès.');
			htp.print('</div>');	
			htp.br;
			htp.print(htf.anchor('pq_ui_reservation.planning_global?pdateDebut=' || to_char(vdate - 3, 'DD/MM/YYYY') || '&' || 'pnumTerrain=' || vnumTerrain ,'Retour au planning'));
			
		EXCEPTION
			WHEN PERMISSION_DENIED THEN
				pq_ui_commun.dis_error_permission_denied;				
			WHEN dateAnterieure THEN
				pq_ui_commun.dis_error_custom('Suppression impossible','Il est impossible de supprimer une réservation qui est déjà passée.','Choisissez une autre réservation','pq_ui_reservation.planning_global?pdateDebut=' || to_char(vdate - 3, 'DD/MM/YYYY') || '&' || 'pnumTerrain=' || vnumTerrain ,'Retour au planning');
			WHEN OTHERS THEN
				pq_ui_commun.dis_error_custom('Suppression impossible','Il est impossible de supprimer cette réservation.','Choisissez une autre réservation','pq_ui_reservation.planning_global?pdateDebut=' || to_char(vdate - 3, 'DD/MM/YYYY') || '&' || 'pnumTerrain=' || vnumTerrain ,'Retour au planning');
		END;
		
		pq_ui_commun.aff_footer;
	END exec_del_reservation;
	  
END pq_ui_reservation;
/