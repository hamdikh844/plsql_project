Set SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE ajouter_adherent(
    p_nom IN VARCHAR2,
    p_prenom IN VARCHAR2,
    p_date_inscription IN DATE DEFAULT SYSDATE
) AS
BEGIN
    INSERT INTO ADHERENTS (id_adherent, nom, prenom, date_inscription)
    VALUES (seq_adherents.NEXTVAL, UPPER(p_nom), p_prenom, p_date_inscription);
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Adhérent ajouté avec succès.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erreur lors de l''ajout de l''adhérent: ' || SQLERRM);
END;
/