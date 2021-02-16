USE onlineshop;

DROP TABLE IF EXISTS Kunde;

CREATE TABLE Kunde
(
    Kunde_ID INTEGER PRIMARY KEY AUTO_INCREMENT,
    Vorname VARCHAR(40),
    Nachname VARCHAR(40),
    GeburtsDatum DATE,
    Adresse_ID INTEGER,
        FOREIGN KEY K_Adresse_FK (Adresse_ID) REFERENCES Adresse(Adresse_ID)
);