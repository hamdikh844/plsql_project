SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE ajouter_livre(
    p_titre IN VARCHAR2,
    p_id_auteur IN NUMBER,
    p_nb_exemplaires IN NUMBER
) AS
BEGIN
    INSERT INTO LIVRES (id_livre, titre, id_auteur, nb_exemplaires)
    VALUES (seq_livres.NEXTVAL, p_titre, p_id_auteur, p_nb_exemplaires);
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Livre ajouté avec succès.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erreur lors de l''ajout du livre: ' || SQLERRM);
END;
/