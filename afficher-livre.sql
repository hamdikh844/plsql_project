set SERVEROUTPUT on 
CREATE OR REPLACE PROCEDURE afficher_livre(
    p_id_livre IN NUMBER
) AS

    v_titre LIVRES.titre%TYPE;
    v_auteur_nom AUTEURS.nom%TYPE;
    v_auteur_prenom AUTEURS.prenom%TYPE;
    v_nb_exemplaires LIVRES.nb_exemplaires%TYPE;
    v_stock_disponible NUMBER;
BEGIN
    
    SELECT l.titre, a.nom, a.prenom, l.nb_exemplaires
    INTO v_titre, v_auteur_nom, v_auteur_prenom, v_nb_exemplaires
    FROM LIVRES l
    JOIN AUTEURS a ON l.id_auteur = a.id_auteur
    WHERE l.id_livre = p_id_livre;
    
    
    SELECT l.nb_exemplaires - NVL(COUNT(p.id_pret), 0)
    INTO v_stock_disponible
    FROM LIVRES l
    LEFT JOIN PRETS p ON l.id_livre = p.id_livre AND p.date_retour IS NULL
    WHERE l.id_livre = p_id_livre
    GROUP BY l.nb_exemplaires;
    
    
    DBMS_OUTPUT.PUT_LINE('--------------------------------------');
    DBMS_OUTPUT.PUT_LINE('INFORMATIONS DU LIVRE');
    DBMS_OUTPUT.PUT_LINE('--------------------------------------');
    DBMS_OUTPUT.PUT_LINE('ID Livre: ' || p_id_livre);
    DBMS_OUTPUT.PUT_LINE('Titre: ' || v_titre);
    DBMS_OUTPUT.PUT_LINE('Auteur: ' || v_auteur_prenom || ' ' || v_auteur_nom);
    DBMS_OUTPUT.PUT_LINE('Exemplaires totaux: ' || v_nb_exemplaires);
    DBMS_OUTPUT.PUT_LINE('Exemplaires disponibles: ' || v_stock_disponible);
    DBMS_OUTPUT.PUT_LINE('--------------------------------------');
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Aucun livre trouvé avec l''ID ' || p_id_livre);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erreur lors de la récupération des informations: ' || SQLERRM);
END afficher_livre;
END ;
/