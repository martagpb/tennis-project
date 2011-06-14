-- -----------------------------------------------------------------------------
--           Création du package d'affichage des données
--           pour la table PERSONNE
--                      Oracle Version 10g
--                        (14/05/2011)
-- -----------------------------------------------------------------------------
--      Nom de la base : Tennis
--      Projet : Tennis_V1.24
--      Auteur : Gonzalves / Invernizzi / Joly / Leviste
--      Date de dernière modification : 22/05/2011
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pq_ui_personne
IS
	--Permet d'afficher toutes les personnes et les actions possibles de gestion avec le menu
	PROCEDURE manage_personnes
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		pq_ui_commun.aff_header;
		pq_ui_personne.dis_personnes;
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN PERMISSION_DENIED then
			pq_ui_commun.dis_error_permission_denied;
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Gestion des personnes');
	END manage_personnes;	
				
	--Permet d'afficher toutes les personnes et les actions possibles de gestion (sans le menu)
	PROCEDURE dis_personnes
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		-- On stocke dans un curseur la liste de toutes les personnes existantes
		CURSOR listpersonne IS
		SELECT 
			 PER.NUM_PERSONNE           
			,PER.NOM_PERSONNE
			,PER.PRENOM_PERSONNE
			,PER.LOGIN_PERSONNE
			,PER.VILLE_PERSONNE
			,PER.CODE_STATUT_EMPLOYE
			,PER.NATURE_STATUT_EMPLOYE
			,PER.CODE_NIVEAU
			,PER.NATURE_NIVEAU
			,PER.STATUT_JOUEUR
		FROM 
			PERSONNE PER
		ORDER BY 
			1;
	BEGIN	
		pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		htp.print('<div class="titre_niveau_1">');
			htp.print('Gestion des personnes');
		htp.print('</div>');	
		htp.br;	
		htp.br;	
		htp.print(htf.anchor('pq_ui_personne.form_add_personne','Ajouter une personne'));
		htp.print('  -  ');
		htp.print(htf.anchor('pq_ui_personne.form_search_personnes','Rechercher une personne'));
		htp.br;	
		htp.br;					
		htp.tableOpen('',cattributes => 'class="tableau"');
		htp.tableheader('N° du personne');
		htp.tableheader('Nom');
		htp.tableheader('Prénom');
		htp.tableheader('Login');
		htp.tableheader('Ville');
		htp.tableheader('Niveau');
		htp.tableheader('Statut joueur');
		htp.tableheader('Statut employé');
		htp.tableheader('Informations');
		htp.tableheader('Mise à jour');
		htp.tableheader('Supprimer');
		for currentpersonne in listpersonne loop
			htp.tableRowOpen;
			htp.tabledata(currentpersonne.NUM_PERSONNE);
			htp.tabledata(currentpersonne.NOM_PERSONNE);
			htp.tabledata(currentpersonne.PRENOM_PERSONNE);
			htp.tabledata(currentpersonne.LOGIN_PERSONNE);
			IF currentpersonne.VILLE_PERSONNE IS NOT NULL THEN
				htp.tabledata(currentpersonne.VILLE_PERSONNE);
			ELSE
				htp.tabledata('');
			END IF;
			IF currentpersonne.CODE_NIVEAU IS NOT NULL THEN
				htp.tabledata(pq_db_codification.get_libelle(currentpersonne.CODE_NIVEAU,currentpersonne.NATURE_NIVEAU));
			ELSE
				htp.tabledata('');
			END IF;
			IF currentpersonne.STATUT_JOUEUR IS NOT NULL THEN
			htp.tabledata(currentpersonne.STATUT_JOUEUR);
			ELSE
				htp.tabledata('');
			END IF;
			IF currentpersonne.CODE_STATUT_EMPLOYE IS NOT NULL THEN
			htp.tabledata(pq_db_codification.get_libelle(currentpersonne.CODE_STATUT_EMPLOYE,currentpersonne.NATURE_STATUT_EMPLOYE));
			ELSE
				htp.tabledata('');
			END IF;			
			htp.tabledata(htf.anchor('pq_ui_personne.dis_personne?vnumpersonne='||currentpersonne.NUM_PERSONNE,'Informations complémentaires'));
			htp.tabledata(htf.anchor('pq_ui_personne.form_upd_personne?vnumpersonne='||currentpersonne.NUM_PERSONNE,'Mise à jour'));
			htp.tabledata(htf.anchor('pq_ui_personne.exec_del_personne?vnumpersonne='||currentpersonne.NUM_PERSONNE,'Supprimer', cattributes => 'onClick="return confirmerChoix(this,document)"'));
			htp.tableRowClose;
		end loop;	
		htp.tableClose;			
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Gestion des personnes');
	END dis_personnes;
	
	
	--Permet d'afficher toutes les personnes et les actions possibles de gestion (sans le menu), en fonction de critères de recherche
	PROCEDURE dis_search_personnes(login IN VARCHAR2, nom IN VARCHAR2, prenom IN VARCHAR2)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		-- On stocke dans un curseur la liste de toutes les personnes existantes
		CURSOR listpersonne IS
		SELECT 
			 PER.NUM_PERSONNE           
			,PER.NOM_PERSONNE
			,PER.PRENOM_PERSONNE
			,PER.LOGIN_PERSONNE
			,PER.VILLE_PERSONNE
			,PER.CODE_STATUT_EMPLOYE
			,PER.NATURE_STATUT_EMPLOYE
			,PER.CODE_NIVEAU
			,PER.NATURE_NIVEAU
			,PER.STATUT_JOUEUR
		FROM 
			PERSONNE PER
		WHERE
			PER.LOGIN_PERSONNE=login
		OR
			PER.NOM_PERSONNE=nom
		OR
			PER.PRENOM_PERSONNE=prenom
		ORDER BY 
			1;
	BEGIN	
		pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		pq_ui_commun.aff_header;
		htp.print('<div class="titre_niveau_1">');
			htp.print('Gestion des personnes');
		htp.print('</div>');	
		htp.br;	
		htp.br;	
		htp.print(htf.anchor('pq_ui_personne.form_add_personne','Ajouter une personne'));
		htp.print('  -  ');
		htp.print(htf.anchor('pq_ui_personne.form_search_personne','Rechercher une personne'));
		htp.br;	
		htp.br;					
		htp.tableOpen('',cattributes => 'class="tableau"');
		htp.tableheader('N° du personne');
		htp.tableheader('Nom');
		htp.tableheader('Prénom');
		htp.tableheader('Login');
		htp.tableheader('Ville');
		htp.tableheader('Niveau');
		htp.tableheader('Statut joueur');
		htp.tableheader('Statut employé');
		htp.tableheader('Informations');
		htp.tableheader('Mise à jour');
		htp.tableheader('Supprimer');
		for currentpersonne in listpersonne loop
			htp.tableRowOpen;
			htp.tabledata(currentpersonne.NUM_PERSONNE);
			htp.tabledata(currentpersonne.NOM_PERSONNE);
			htp.tabledata(currentpersonne.PRENOM_PERSONNE);
			htp.tabledata(currentpersonne.LOGIN_PERSONNE);
			IF currentpersonne.VILLE_PERSONNE IS NOT NULL THEN
				htp.tabledata(currentpersonne.VILLE_PERSONNE);
			ELSE
				htp.tabledata('');
			END IF;
			IF currentpersonne.CODE_NIVEAU IS NOT NULL THEN
				htp.tabledata(pq_db_codification.get_libelle(currentpersonne.CODE_NIVEAU,currentpersonne.NATURE_NIVEAU));
			ELSE
				htp.tabledata('');
			END IF;
			IF currentpersonne.STATUT_JOUEUR IS NOT NULL THEN
			htp.tabledata(currentpersonne.STATUT_JOUEUR);
			ELSE
				htp.tabledata('');
			END IF;
			IF currentpersonne.CODE_STATUT_EMPLOYE IS NOT NULL THEN
			htp.tabledata(pq_db_codification.get_libelle(currentpersonne.CODE_STATUT_EMPLOYE,currentpersonne.NATURE_STATUT_EMPLOYE));
			ELSE
				htp.tabledata('');
			END IF;			
			htp.tabledata(htf.anchor('pq_ui_personne.dis_personne?vnumpersonne='||currentpersonne.NUM_PERSONNE,'Informations complémentaires'));
			htp.tabledata(htf.anchor('pq_ui_personne.form_upd_personne?vnumpersonne='||currentpersonne.NUM_PERSONNE,'Mise à jour'));
			htp.tabledata(htf.anchor('pq_ui_personne.exec_del_personne?vnumpersonne='||currentpersonne.NUM_PERSONNE,'Supprimer', cattributes => 'onClick="return confirmerChoix(this,document)"'));
			htp.tableRowClose;
		end loop;	
		htp.tableClose;	
		pq_ui_commun.aff_footer;		
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Gestion des personnes');
	END dis_search_personnes;

	--Permet d’afficher une personne existante
	PROCEDURE dis_personne(vnumpersonne IN NUMBER)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		currentPersonne PERSONNE%ROWTYPE;
		CURSOR listReservation IS
		SELECT 
			 OCC.DATE_OCCUPATION
			,OCC.NUM_TERRAIN
			,OCC.HEURE_DEBUT_CRENEAU
		FROM 
			OCCUPER OCC INNER JOIN ETRE_ASSOCIE ASS
				ON OCC.DATE_OCCUPATION=ASS.DATE_OCCUPATION
				AND OCC.NUM_TERRAIN=ASS.NUM_TERRAIN
				AND OCC.HEURE_DEBUT_CRENEAU=ASS.HEURE_DEBUT_CRENEAU
		WHERE
			ASS.NUM_PERSONNE=vnumpersonne 
		ORDER BY 
			1;
		CURSOR listEntrainement IS
		SELECT 
			  INS.NUM_ENTRAINEMENT
			 ,ENT.DATE_DEBUT_ENTRAINEMENT
			 ,ENT.DATE_FIN_ENTRAINEMENT
		FROM 
			S_INSCRIRE INS INNER JOIN ENTRAINEMENT ENT
				ON INS.NUM_ENTRAINEMENT=ENT.NUM_ENTRAINEMENT
		WHERE
			INS.NUM_PERSONNE=vnumpersonne
		ORDER BY 
			1;	
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		SELECT * into currentPersonne
		FROM PERSONNE
		WHERE NUM_PERSONNE=vnumpersonne;
		pq_ui_commun.aff_header;
		htp.br;
		htp.br;
		htp.br;
			htp.print('<div class="titre_niveau_1">');
				htp.print('Affichage des informations de la personne n°' || vnumpersonne);
			htp.print('</div>');			
			htp.br;
			htp.br;					
			htp.tableopen('',cattributes => 'class="tableau"');	
				htp.tablerowopen;
					htp.tabledata('N° de la personne :', cattributes => 'class="enteteFormulaire"');
					htp.tabledata(vnumpersonne);
				htp.tablerowclose;					
				htp.tablerowopen;
					htp.tabledata('Nom :', cattributes => 'class="enteteFormulaire"');
					htp.tabledata(currentPersonne.NOM_PERSONNE);				
				htp.tablerowclose;	
				htp.tablerowopen;
					htp.tabledata('Prénom :', cattributes => 'class="enteteFormulaire"');
					htp.tabledata(currentPersonne.PRENOM_PERSONNE);				
				htp.tablerowclose;	
				htp.tablerowopen;
					htp.tabledata('Login :', cattributes => 'class="enteteFormulaire"');
					htp.tabledata(currentPersonne.LOGIN_PERSONNE);				
				htp.tablerowclose;
				htp.tablerowopen;
					htp.tabledata('Téléphone :', cattributes => 'class="enteteFormulaire"');
					htp.tabledata(currentPersonne.TEL_PERSONNE);				
				htp.tablerowclose;
				htp.tablerowopen;
					htp.tabledata('Mail :', cattributes => 'class="enteteFormulaire"');
					htp.tabledata(currentPersonne.EMAIL_PERSONNE);				
				htp.tablerowclose;
				htp.tablerowopen;
					htp.tabledata('Adresse :', cattributes => 'class="enteteFormulaire"');
					htp.tabledata(currentPersonne.NUM_RUE_PERSONNE || ' ' || currentPersonne.CP_PERSONNE || ' ' || currentPersonne.VILLE_PERSONNE);				
				htp.tablerowclose;
				htp.tablerowopen;
					htp.tabledata('Actif :', cattributes => 'class="enteteFormulaire"');
					IF currentPersonne.ACTIF=1 THEN
						htp.tabledata('Oui');		
					ELSE
						htp.tabledata('Non');	
					END IF;
				htp.tablerowclose;
				IF currentPersonne.CODE_STATUT_EMPLOYE IS NOT NULL THEN
				htp.tablerowopen;
					htp.tabledata('Statut d''employé :', cattributes => 'class="enteteFormulaire"');
					htp.tabledata(pq_db_codification.get_libelle(currentPersonne.CODE_STATUT_EMPLOYE,currentPersonne.NATURE_STATUT_EMPLOYE));				
				htp.tablerowclose;
				END IF; 
				IF currentPersonne.CODE_NIVEAU IS NOT NULL THEN
				htp.tablerowopen;
					htp.tabledata('Niveau :', cattributes => 'class="enteteFormulaire"');
					htp.tabledata(pq_db_codification.get_libelle(currentPersonne.CODE_NIVEAU,currentPersonne.NATURE_NIVEAU));				
				htp.tablerowclose;
				END IF;
			htp.tableclose;
			htp.br;
			htp.anchor('pq_ui_personne.form_upd_personne?vnumpersonne='||vnumpersonne,'Modifier');
			htp.br;		
			htp.br;
			htp.br;
			htp.br;
			htp.print('<div class="titre_niveau_1">');
				htp.print('Liste des réservations liées à cette personne :');
			htp.print('</div>');			
			htp.br;
			htp.br;	
			htp.tableOpen('',cattributes => 'class="tableau"');
				htp.tableheader('Date de la réservation');
				htp.tableheader('Heure de réservation');
				htp.tableheader('Terrain');
				for currentreservation in listReservation loop
					htp.tableRowOpen;
					htp.tabledata(currentreservation.DATE_OCCUPATION);
					htp.tabledata(currentreservation.HEURE_DEBUT_CRENEAU);
					htp.tabledata(currentreservation.NUM_TERRAIN);
				end loop;	
			htp.tableClose;		
			htp.br;
			htp.br;		
			htp.br;
			htp.br;
			htp.br;
			IF currentPersonne.STATUT_JOUEUR='A' THEN
				htp.print('<div class="titre_niveau_1">');
					htp.print('Liste des entrainements suivis par cette personne :');
				htp.print('</div>');				
			htp.br;
			htp.br;	
			htp.tableOpen('',cattributes => 'class="tableau"');
				htp.tableheader('Numéro de l''entrainement');
				htp.tableheader('Date de début de l''entrainement');
				htp.tableheader('Date de fin de l''entrainement');
				for currententrainement in listEntrainement loop
					htp.tableRowOpen;
					htp.tabledata(currententrainement.NUM_ENTRAINEMENT);
					htp.tabledata(currententrainement.DATE_DEBUT_ENTRAINEMENT);
					htp.tabledata(currententrainement.DATE_FIN_ENTRAINEMENT);
				end loop;	
			htp.tableClose;		
			END IF;
			htp.anchor('pq_ui_personne.manage_personnes', 'Retourner à la gestion des personnes');	
		pq_ui_commun.aff_footer;
	END dis_personne;
	
	
	PROCEDURE form_add_personne
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		CURSOR listStatutsEmployes IS
		SELECT 
			 COD.CODE
			,COD.NATURE
			,COD.LIBELLE
		FROM 
			CODIFICATION COD
		WHERE
			COD.NATURE='ROLE'
		ORDER BY 
			1;
		CURSOR listNiveaux IS
		SELECT 
			 COD.CODE
			,COD.NATURE 
			,COD.LIBELLE
		FROM 
			CODIFICATION COD
		WHERE
			COD.NATURE='Classement'
		ORDER BY 
			1;	
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		pq_ui_commun.aff_header;
		htp.br;
		htp.br;
		htp.br;
		htp.br;
		htp.print('<div class="titre_niveau_1">');
		htp.print('Création d''un nouveau compte');
		htp.print('</div>');			
		htp.br;
		htp.print('Les champs marqués d''une étoile sont obligatoires');
		htp.br;
		htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_personne.exec_add_personne', 'POST', cattributes => 'onSubmit="return valider(this,document)"');
			htp.tableOpen(cattributes => 'CELLSPACING=8');
				htp.tableheader('');
				htp.tableheader('');
				htp.tableheader('');
				htp.tableRowOpen;
					htp.tableData('Nom * :', cattributes => 'class="enteteFormulaire"');
					htp.tableData(htf.formText('lastname',20));
					htp.tableData('',cattributes => 'id="lastnameText" class="error"');
				htp.tableRowClose;	
				htp.tableRowOpen;
					htp.tableData('Prénom * :', cattributes => 'class="enteteFormulaire"');
					htp.tableData(htf.formText('firstname',20));
					htp.tableData('',cattributes => 'id="firstnameText" class="error"');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Identifiant * :', cattributes => 'class="enteteFormulaire"');
					htp.tableData(htf.formText('login',20));
					htp.tableData('',cattributes => 'id="identifiantText" class="error"');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Mot de passe * :', cattributes => 'class="enteteFormulaire"');
					htp.tableData(htf.formPassword('password',20));
					htp.tableData('',cattributes => 'id="passwordText" class="error"');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Adresse mail * :', cattributes => 'class="enteteFormulaire"');
					htp.tableData(htf.formText('mail',20));
					htp.tableData('',cattributes => 'id="mailText" class="error"');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Adresse :', cattributes => 'class="enteteFormulaire"');
					htp.tableData(htf.formText('street',20));
					htp.tableData('');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Code postal :', cattributes => 'class="enteteFormulaire"');
					htp.tableData(htf.formText('postal',20));
					htp.tableData('',cattributes => 'id="postalText" class="error"');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Ville :', cattributes => 'class="enteteFormulaire"');
					htp.tableData(htf.formText('city',20));
					htp.tableData('',cattributes => 'id="cityText" class="error"');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Téléphone :', cattributes => 'class="enteteFormulaire"');
					htp.tableData(htf.formText('phone',20));
					htp.tableData('',cattributes => 'id="phoneText" class="error"');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Niveau :', cattributes => 'class="enteteFormulaire"');
                                        htp.print('<td>');
					htp.formSelectOpen('level');
						for currentNiveau in listNiveaux loop
							htp.formSelectOption(currentNiveau.LIBELLE, cattributes      => 'VALUE=' || currentNiveau.CODE);
						end loop;	
					htp.formSelectClose;
                                        htp.print('</td>');
					htp.tableData('',cattributes => 'id="levelText" class="error"');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Statut de joueur :', cattributes => 'class="enteteFormulaire"');
                                        htp.print('<td>');
					htp.formSelectOpen('statutJoueur');
						htp.formSelectOption('Visiteur',cattributes      => 'VALUE="V"');
						htp.formSelectOption('Adhérent',cattributes      => 'VALUE="A"');
					htp.formSelectClose;
                                        htp.print('</td>');
					htp.tableData('',cattributes => 'id="StatutJoueurText" class="error"');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Statut employé :', cattributes => 'class="enteteFormulaire"');
                                        htp.print('<td>');
					htp.formSelectOpen('statutEmploye');
						for currentStatut in listStatutsEmployes loop
							htp.formSelectOption(currentStatut.LIBELLE, cattributes      => ('VALUE=' || currentStatut.CODE));
						end loop;	
					htp.formSelectClose;
                                        htp.print('</td>');
					htp.tableData('',cattributes => 'id="statutEmpText" class="error"');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('');
					htp.tableData(htf.formSubmit(NULL,'Validation'));
				htp.tableRowClose;
			htp.tableClose();
		htp.formClose;
		htp.br;	
	END form_add_personne;


	
	-- Exécute la procédure d'ajout d'un personne et gère les erreurs éventuelles.
	PROCEDURE exec_add_personne ( lastname IN VARCHAR2,  firstname IN VARCHAR2,login IN VARCHAR2,password IN VARCHAR2,mail IN VARCHAR2,street IN VARCHAR2,postal IN VARCHAR2,city IN VARCHAR2,phone IN VARCHAR2,level IN VARCHAR2, statutJoueur IN VARCHAR2, statutEmploye IN VARCHAR2)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		pq_ui_commun.aff_header;
			htp.br;
			htp.br;
			htp.br;
			pq_db_personne.createPersonne(lastname ,  firstname ,login ,password ,mail ,phone ,street ,postal ,city ,statutEmploye, level , statutJoueur );
			htp.print('<div class="success"> ');
				htp.print('La personne a été ajoutée avec succès.');
			htp.print('</div>');			
			htp.br;
			htp.br;			
			pq_ui_personne.dis_personnes;
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Erreur lors de l''ajout d''une personne');
	END exec_add_personne;
	
	
	-- Exécute la procédure de suppression d'un personne et gère les erreurs éventuelles
	PROCEDURE exec_del_personne(
	  vnumpersonne IN NUMBER)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		pq_ui_commun.aff_header;		
			pq_db_personne.delpersonne(vnumpersonne);
			htp.br;
			htp.br;
			htp.br;
			htp.print('<div class="success"> ');
				htp.print('La personne n° '|| vnumpersonne || ' a été supprimée avec succès.');
			htp.print('</div>');				
			htp.br;
			htp.br;			
			pq_ui_personne.dis_personnes;
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Suppression d''un personne en cours...');
	END exec_del_personne;
	
	
	
	-- Affiche le formulaire de saisie permettant la modification d’une personne existante
	PROCEDURE form_upd_personne(
	  vnumpersonne IN NUMBER)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
		currentPersonne PERSONNE%ROWTYPE;
		CURSOR listStatutsEmployes IS
		SELECT 
			 COD.CODE
			,COD.NATURE
			,COD.LIBELLE
		FROM 
			CODIFICATION COD
		WHERE
			COD.NATURE='ROLE'
		ORDER BY 
			1;
		CURSOR listNiveaux IS
		SELECT 
			 COD.CODE
			,COD.NATURE 
			,COD.LIBELLE
		FROM 
			CODIFICATION COD
		WHERE
			COD.NATURE='Classement'
		ORDER BY 
			1;	
		password VARCHAR2(255);
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		SELECT
			* INTO currentPersonne
		FROM
			PERSONNE
		WHERE
			NUM_PERSONNE=vnumpersonne;
			dbms_obfuscation_toolkit.desdecrypt(input_string => currentPersonne.MDP_PERSONNE, 
										key_string => 'tennispro', 
										decrypted_string  => password );
		pq_ui_commun.aff_header;
		htp.br;
		htp.br;
		htp.br;
		htp.br;
		htp.print('<div class="titre_niveau_1">');
		htp.print('Création d''un nouveau compte');
		htp.print('</div>');			
		htp.br;
		htp.print('Les champs marqués d''une étoile sont obligatoires');
		htp.br;
		htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_personne.exec_upd_personne', 'POST', cattributes => 'onSubmit="return valider(this,document)"');
			htp.formHidden('num',vnumpersonne);
			htp.tableOpen(cattributes => 'CELLSPACING=8');
				htp.tableheader('');
				htp.tableheader('');
				htp.tableheader('');
				htp.tableRowOpen;
					htp.tableData('Numéro * :', cattributes => 'class="enteteFormulaire"');
					htp.tableData(htf.formText(NULL,20,NULL,vnumpersonne, cattributes => 'disabled="disabled"'));
					htp.tableData('',cattributes => 'id="numText" class="error"');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Nom * :', cattributes => 'class="enteteFormulaire"');
					htp.tableData(htf.formText('lastname',20,NULL,currentPersonne.NOM_PERSONNE));
					htp.tableData('',cattributes => 'id="lastnameText" class="error"');
				htp.tableRowClose;	
				htp.tableRowOpen;
					htp.tableData('Prénom * :');
					htp.tableData(htf.formText('firstname',20,NULL,currentPersonne.PRENOM_PERSONNE));
					htp.tableData('',cattributes => 'id="firstnameText" class="error"');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Identifiant * :');
					htp.tableData(htf.formText('log',20,NULL, currentPersonne.LOGIN_PERSONNE));
					htp.tableData('',cattributes => 'id="identifiantText" class="error"');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Mot de passe * :');
					htp.tableData(htf.formPassword('pass',20,NULL,password));
					htp.tableData('',cattributes => 'id="passwordText" class="error"');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Adresse mail * :');
					htp.tableData(htf.formText('mail',20,NULL,currentPersonne.EMAIL_PERSONNE));
					htp.tableData('',cattributes => 'id="mailText" class="error"');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Adresse :');
					htp.tableData(htf.formText('street',20,NULL,currentPersonne.NUM_RUE_PERSONNE));
					htp.tableData('');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Code postal :');
					htp.tableData(htf.formText('postal',20,NULL,currentPersonne.CP_PERSONNE));
					htp.tableData('',cattributes => 'id="postalText" class="error"');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Ville :');
					htp.tableData(htf.formText('city',20,NULL,currentPersonne.VILLE_PERSONNE));
					htp.tableData('',cattributes => 'id="cityText" class="error"');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Téléphone :');
					htp.tableData(htf.formText('phone',20,NULL,currentPersonne.TEL_PERSONNE));
					htp.tableData('',cattributes => 'id="phoneText" class="error"');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Niveau :', cattributes => 'class="enteteFormulaire"');
                    htp.print('<td>');
					htp.formSelectOpen('level');
						for currentNiveau in listNiveaux loop
							IF currentNiveau.CODE = currentPersonne.Code_NIVEAU THEN
								htp.formSelectOption(currentNiveau.LIBELLE, cattributes      => 'selected="selected" VALUE=' || currentNiveau.CODE); 
							ELSE
								htp.formSelectOption(currentNiveau.LIBELLE, cattributes      => 'VALUE=' || currentNiveau.CODE);
							END IF;
						end loop;	
					htp.formSelectClose;
                    htp.print('</td>');
					htp.tableData('',cattributes => 'id="levelText" class="error"');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Statut de joueur :', cattributes => 'class="enteteFormulaire"');
                    htp.print('<td>');
					htp.formSelectOpen('statutJoueur');
						IF currentPersonne.STATUT_JOUEUR='V' THEN
							htp.formSelectOption('Visiteur',cattributes      => 'selected="selected" VALUE="V"');
						ELSE
							htp.formSelectOption('Visiteur',cattributes      => 'VALUE="V"');
						END IF;
						IF currentPersonne.STATUT_JOUEUR='A' THEN
								htp.formSelectOption('Adhérent',cattributes      => 'selected="selected" VALUE="A"');
						ELSE
							htp.formSelectOption('Adhérent',cattributes      => 'VALUE="A"');
						END IF;
					htp.formSelectClose;
                    htp.print('</td>');
					htp.tableData('',cattributes => 'id="StatutJoueurText" class="error"');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Statut employé :', cattributes => 'class="enteteFormulaire"');
                    htp.print('<td>');
					htp.formSelectOpen('statutEmploye');
						for currentStatut in listStatutsEmployes loop
							IF currentStatut.CODE = currentPersonne.CODE_STATUT_EMPLOYE THEN
								htp.formSelectOption(currentStatut.LIBELLE, cattributes      => ('selected="selected" VALUE=' || currentStatut.CODE));
							ELSE
								htp.formSelectOption(currentStatut.LIBELLE, cattributes      => ('VALUE=' || currentStatut.CODE));
							END IF;
						end loop;	
					htp.formSelectClose;
                    htp.print('</td>');
					htp.tableData('',cattributes => 'id="statutEmpText" class="error"');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Droit :');
					htp.tableData(htf.formText('droit',20,NULL,currentPersonne.NIVEAU_DROIT));
					htp.tableData('',cattributes => 'id="droitText" class="error"');
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('');
					htp.tableData(htf.formSubmit(NULL,'Validation'));
				htp.tableRowClose;
			htp.tableClose();
		htp.formClose;
		htp.br;	
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Modification d''une personne');
	END form_upd_personne;
	
	
	-- Exécute la procédure de mise à jour d'un personne et gère les erreurs éventuelles
	PROCEDURE exec_upd_personne(num IN NUMBER, lastname IN VARCHAR2,  firstname IN VARCHAR2,log IN VARCHAR2,pass IN VARCHAR2,mail IN VARCHAR2,street IN VARCHAR2,postal IN VARCHAR2,city IN VARCHAR2,phone IN VARCHAR2,level IN VARCHAR2, statutJoueur IN VARCHAR2, statutEmploye IN VARCHAR2, droit IN NUMBER)
	IS
		perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		pq_ui_commun.aff_header;	
			pq_db_personne.updPersonneFull(num, lastname ,  firstname ,log ,pass ,mail ,phone ,street ,postal ,city ,statutEmploye, level , statutJoueur, droit );
			htp.br;
			htp.br;
			htp.br;
			htp.print('<div class="success"> ');
				htp.print('La personne n° '|| num || ' a été mis à jour avec succès.');
			htp.print('</div>');				
			htp.br;
			htp.br;			
			pq_ui_personne.dis_personnes;
		pq_ui_commun.aff_footer;
	EXCEPTION
		WHEN OTHERS THEN
			pq_ui_commun.dis_error(TO_CHAR(SQLCODE),SQLERRM,'Mise à jour d''un personne en cours...');
	END exec_upd_personne;
	
	PROCEDURE form_search_personnes
	IS
	perm BOOLEAN;
		PERMISSION_DENIED EXCEPTION;
	BEGIN
		pq_ui_commun.ISAUTHORIZED(niveauP=>1,permission=>perm);
		IF perm=false THEN
			RAISE PERMISSION_DENIED;
		END IF;
		pq_ui_commun.aff_header;
			htp.br;
		htp.br;
		htp.br;
		htp.br;
		htp.print('<div class="titre_niveau_1">');
		htp.print('Recherche d''une personne');
		htp.print('</div>');			
		htp.br;
		htp.print('Remplissez un ou plusieurs critères de recherche');
		htp.formOpen(owa_util.get_owa_service_path ||  'pq_ui_personne.dis_search_personnes', 'POST', cattributes => 'onSubmit="return valider(this,document)"');
			htp.tableOpen(cattributes => 'CELLSPACING=8');
				htp.tableheader('');
				htp.tableheader('');
				htp.tableRowOpen;
					htp.tableData('Login :', cattributes => 'class="enteteFormulaire"');
					htp.tableData(htf.formText('login',20,NULL));
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Nom :', cattributes => 'class="enteteFormulaire"');
					htp.tableData(htf.formText('nom',20,NULL));
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('Prenom :', cattributes => 'class="enteteFormulaire"');
					htp.tableData(htf.formText('prenom',20,NULL));
				htp.tableRowClose;
				htp.tableRowOpen;
					htp.tableData('');
					htp.tableData(htf.formSubmit(NULL,'Validation'));
				htp.tableRowClose;
			htp.tableClose;
		htp.formClose;
		pq_ui_commun.aff_footer;
	END form_search_personnes;
		
END pq_ui_personne;
/