CREATE OR REPLACE PACKAGE pkg_bibliotheque AS
    
    PROCEDURE ajouter_adherent(
        p_nom IN VARCHAR2,
        p_prenom IN VARCHAR2,
        p_date_inscription IN DATE DEFAULT SYSDATE
    );
    
    
    PROCEDURE ajouter_livre(
        p_titre IN VARCHAR2,
        p_id_auteur IN NUMBER,
        p_nb_exemplaires IN NUMBER
    );
    

    FUNCTION nb_prets_en_cours(
        p_id_adherent IN NUMBER
    ) RETURN NUMBER;
    
    -
    PROCEDURE afficher_livre(
        p_id_livre IN NUMBER
    );
END pkg_bibliotheque;
/

CREATE OR REPLACE PACKAGE BODY pkg_bibliotheque AS
    PROCEDURE ajouter_adherent(
        p_nom IN VARCHAR2,
        p_prenom IN VARCHAR2,
        p_date_inscription IN DATE DEFAULT SYSDATE
    ) IS
    BEGIN
        INSERT INTO ADHERENTS (id_adherent, nom, prenom, date_inscription)
        VALUES (seq_adherents.NEXTVAL, UPPER(p_nom), p_prenom, p_date_inscription);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Adhérent ajouté avec succès.');
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Erreur lors de l''ajout de l''adhérent: ' || SQLERRM);
    END ajouter_adherent;
    
    PROCEDURE ajouter_livre(
        p_titre IN VARCHAR2,
        p_id_auteur IN NUMBER,
        p_nb_exemplaires IN NUMBER
    ) IS
    BEGIN
        INSERT INTO LIVRES (id_livre, titre, id_auteur, nb_exemplaires)
        VALUES (seq_livres.NEXTVAL, p_titre, p_id_auteur, p_nb_exemplaires);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Livre ajouté avec succès.');
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Erreur lors de l''ajout du livre: ' || SQLERRM);
    END ajouter_livre;
    
    FUNCTION nb_prets_en_cours(
        p_id_adherent IN NUMBER
    ) RETURN NUMBER IS
        v_nb_prets NUMBER := 0;
    BEGIN
        SELECT COUNT(*)
        INTO v_nb_prets
        FROM PRETS
        WHERE id_adherent = p_id_adherent AND date_retour IS NULL;
        
        RETURN v_nb_prets;
    EXCEPTION
        WHEN OTHERS THEN
            RETURN -1; 
    END nb_prets_en_cours;
    
    PROCEDURE afficher_livre(
        p_id_livre IN NUMBER
    ) IS
        v_titre LIVRES.titre%TYPE;
        v_auteur VARCHAR2(200);
        v_nb_exemplaires LIVRES.nb_exemplaires%TYPE;
    BEGIN
        SELECT l.titre, a.nom || ' ' || a.prenom, l.nb_exemplaires
        INTO v_titre, v_auteur, v_nb_exemplaires
        FROM LIVRES l
        JOIN AUTEURS a ON l.id_auteur = a.id_auteur
        WHERE l.id_livre = p_id_livre;
        
        DBMS_OUTPUT.PUT_LINE('Titre: ' || v_titre);
        DBMS_OUTPUT.PUT_LINE('Auteur: ' || v_auteur);
        DBMS_OUTPUT.PUT_LINE('Exemplaires disponibles: ' || v_nb_exemplaires);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Aucun livre trouvé avec l''ID ' || p_id_livre);
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erreur lors de l''affichage du livre: ' || SQLERRM);
    END afficher_livre;
END pkg_bibliotheque;
/