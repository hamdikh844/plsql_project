SET SERVEROUTPUT ON;



CREATE TABLE AUTEURS (
    id_auteur NUMBER PRIMARY KEY,
    nom VARCHAR2(100),
    prenom VARCHAR2(100)
);

CREATE TABLE LIVRES (
    id_livre NUMBER PRIMARY KEY,
    titre VARCHAR2(200),
    id_auteur NUMBER REFERENCES AUTEURS(id_auteur),
    nb_exemplaires NUMBER
);

CREATE TABLE ADHERENTS (
    id_adherent NUMBER PRIMARY KEY,
    nom VARCHAR2(100),
    prenom VARCHAR2(100),
    date_inscription DATE
);

CREATE TABLE PRETS (
    id_pret NUMBER PRIMARY KEY,
    id_livre NUMBER REFERENCES LIVRES(id_livre),
    id_adherent NUMBER REFERENCES ADHERENTS(id_adherent),
    date_pret DATE,
    date_retour DATE
);

-- Create sequences
CREATE SEQUENCE seq_auteurs START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_livres START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_adherents START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_prets START WITH 1 INCREMENT BY 1;

COMMIT;