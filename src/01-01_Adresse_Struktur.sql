USE onlineshop;

DROP TABLE IF EXISTS Kunde;
DROP TABLE IF EXISTS Adresse;

CREATE TABLE Adresse (
    Adresse_ID INTEGER PRIMARY KEY AUTO_INCREMENT,
    Strasse VARCHAR( 40 ),
    Hausnummer VARCHAR ( 6 ),
    Postleitzahl VARCHAR ( 10 ),
    Stadt VARCHAR ( 40 ),
    Land VARCHAR ( 40 )
);