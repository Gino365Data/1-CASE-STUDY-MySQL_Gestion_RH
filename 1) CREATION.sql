/* Ma base de données va comporter plusieurs tables, dans un souci d'intégrité référentielle (clé primaire et étrangère), 
je commence par la table SITE, c-à-d le lieu où travaille chaque salarié de l'entreprise */
CREATE TABLE SITE
(
ID_SITE VARCHAR(4) NOT NULL,
NOM_SITE VARCHAR(70) NOT NULL,
VILLE_SITE VARCHAR(70),
PAYS_SITE VARCHAR(9),
PRIMARY KEY(ID_SITE)
);
# je vais maintenant créer la table FONCTION de l'entreprise
CREATE TABLE FONCTION
(
ID_FONCTION VARCHAR(4) NOT NULL,
NOM_FONCTION VARCHAR(200) UNIQUE NOT NULL,
NBRE_COLLABS INT,
PRIMARY KEY(ID_FONCTION)
);

# Je crée à présent la table COLLABORATEURS
CREATE TABLE COLLABORATEURS
(
ID VARCHAR(5) NOT NULL,
NOM VARCHAR(80),
PRENOM VARCHAR(80),
DATE_NAISSANCE DATE,
DATE_ENTREE DATE DEFAULT'9999-01-01',
DEPARTEMENT VARCHAR(80),
SALAIRE_BRUTE NUMERIC(6.2) CHECK(SALAIRE_BRUTE<10000),
ID_FONCTION	VARCHAR(4),
ID_SITE VARCHAR(4),
PRIMARY KEY (ID),
FOREIGN KEY(ID_FONCTION) REFERENCES FONCTION(ID_FONCTION),
FOREIGN KEY(ID_SITE) REFERENCES SITE(ID_SITE)
);

/* Je vais maintenant terminé la création des tables avec 
la table ABSCENCES qui va donc indiquer les absences de certains salariés */
CREATE TABLE ABSENCES
(
ID VARCHAR(5),
DATE_DEBUT DATE,
DATE_FIN DATE,
DUREE_ABS_HEURES NUMERIC(5.2),
TYPE_ABS VARCHAR(200),
FOREIGN KEY(ID) REFERENCES COLLABORATEURS(ID)
);

# -------------------------------------- PARTIE 2 : INSERT INTO-ALTER TABLE-UPDATE -------------------------------------- 

/* je vais remplir les tables, pour éviter des bugs liés aux clés primaires et étrangères,
 je procède dans l'ordre suivant: 1) SITE, 2)FONCTION, 3)COLLABORATEURS, 4)ABSENCES */

# 1) Table SITE
INSERT INTO SITE 
VALUES 
("FP01","Site Porte d'Italie","Paris","France"),
("FB01","Site Vieux Port","Marseille","France"),
("FM01","Site Wazemmes","Lille","FRANCE"),
("SG01","Site Euratlantique","Bordeaux","France"),
("AF01","Site Archipel","Strasbourg","France"),
("AB01","Site EuroRennes","Rennes","FRANCE");

# 2) Table FONCTION
INSERT INTO FONCTION
VALUES
("C123","Conntrôleur de gestion",1),
("CB65","Ingénieur en cybersécurité",1),
("D212","DG",1),
("DA85","Data analyst",2),
("DI18","Data Engineer",1),
("DM76","Directeur marketing",1),
("MS62","Scrum master",1),
("R193","Responsable commercial",1),
("S990","Data Scientist",1);

# 3) Table COLLABORATEURS
INSERT INTO COLLABORATEURS
VALUES
("DF569","Melaine","Nicolas","1982-02-26","2016-04-04","IT",5800,"CB65","AF01"),
("DM942","Minon", "Marie","1980-08-11","2020-02-08","IT",3701, "DI18", "SG01"),
("F5489","Beauchamp", "Vincent","1994-09-01","2014-10-13","IT",4532,"S990", "FB01"),
("G0018","Pedro","Prisca","1998-01-14","2022-06-18","IT",3425,"MS62","AF01"),
("JK701","Mandez","Pierrette","1975-05-12","2019-05-25","IT",3201,"DA85","FP01"),
("L5632","Klein","Agnès","1976-03-12","2020-09-01","VENTES",6943,"R193","FB01"),
("M0056","Lopez","Raymond","1994-12-08","2018-01-08","GENERAL",9526,"D212","FB01"),
("P5600","Marchal","Roseline","1990-11-25","2021-12-16","MARKETING",6493,"DM76","AB01"),
("S5638","Edouard","Gérald","1987-01-06","2017-11-01","FINANCE",4231,"C123","AB01"),
("T4758","Gutenberg","Adam","1933-03-19","2018-10-25","IT",3401,"DA85","FP01");

/* Dans la table COLLABORATEURS, j'ai oublié d'ajouter une colonne nommée GENRE. 
Je vais donc l'ajoutée avec la fonction ALTER TABLE puis ADD COLUMN */
ALTER TABLE COLLABORATEURS
ADD COLUMN GENRE VARCHAR(40);

/* Maintenant, je vais remplir cette nouvelle colonne avec la fonction UPDATE...SET. Cette méthode est trop chronophage selon moi,
car on est obligé de sans cesse rappeler la fonction UPDATE ainsi que notre table COLLABORATEURS */
UPDATE COLLABORATEURS
SET GENRE = "Homme"  WHERE ID = ("DF569");

UPDATE COLLABORATEURS
SET GENRE = "Non-binaire"  WHERE ID = ("DM942");

UPDATE COLLABORATEURS
SET GENRE = "Homme"  WHERE ID = ("F5489");

UPDATE COLLABORATEURS
SET GENRE = "Femme"  WHERE ID = ("G0018");

UPDATE COLLABORATEURS
SET GENRE = "Femme"  WHERE ID = ("JK701");

UPDATE COLLABORATEURS
SET GENRE = "Non-binaire"  WHERE ID = ("L5632");

UPDATE COLLABORATEURS
SET GENRE = "Homme"  WHERE ID = ("M0056");

UPDATE COLLABORATEURS
SET GENRE = "Femme"  WHERE ID = ("P5600");

UPDATE COLLABORATEURS
SET GENRE = "Homme"  WHERE ID = ("S5638");

UPDATE COLLABORATEURS
SET GENRE = "Homme"  WHERE ID = ("T4758");

# 4) Table ABSENCES
INSERT INTO ABSENCES
VALUES
("F5489","2021-07-31","2021-08-05",45,"Congés Payés"),
("M0056","2021-08-12","2021-08-13",16,"Maladie Professionnelle"),
("DF569","2022-06-15","2022-06-18",24,"Congés Payés"),
("S5638","2022-08-01","2023-03-01",1064,"Congés sans Solde"),
("JK701","2022-09-01","2022-09-01",8,"ABS non justifée");

# Voilà, c'est terminé, si vous avez des suggestions d'amélioration de mon code, j'en suis preneur.