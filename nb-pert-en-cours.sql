SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION hr.nb_prets_en_cours(
    p_id_adherent IN NUMBER
) RETURN NUMBER
IS
    v_nombre_prets_en_cours NUMBER := 0;
    v_adherent_existe NUMBER := 0;
BEGIN
    -- Check if adherent exists in HR schema
    SELECT COUNT(*)
    INTO v_adherent_existe
    FROM hr.ADHERENTS
    WHERE id_adherent = p_id_adcret;
    
    IF v_adherent_existe = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Adhérent non trouvé');
        RETURN -1;
    END IF;
    
    -- Count current loans
    SELECT COUNT(*)
    INTO v_nombre_prets_en_cours
    FROM hr.PRETS
    WHERE id_adherent = p_id_adherent
    AND date_retour IS NULL;
    
    DBMS_OUTPUT.PUT_LINE('Nombre de prêts en cours: ' || v_nombre_prets_en_cours);
    RETURN v_nombre_prets_en_cours;
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erreur système: ' || SQLERRM);
        RETURN -2;
END nb_prets_en_cours;
/