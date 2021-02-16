use onlineshop;

drop table if exists Kunde;

create table Kunde
(
    Kunde_ID INTEGER PRIMARY KEY AUTO_INCREMENT,
    Vorname VARCHAR(40),
    Nachname VARCHAR(40),
    GeburtsDatum Date,
    Adresse_ID Integer,
        FOREIGN KEY K_Adresse_FK (Adresse_ID) REFERENCES Adresse(Adresse_ID)
);