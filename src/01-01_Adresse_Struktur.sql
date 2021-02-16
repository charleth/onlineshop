use onlineshop;

drop table if exists Kunde;
drop table if exists Adresse;

create table Adresse (
    Adresse_ID INTEGER PRIMARY KEY auto_increment,
    Strasse VARCHAR( 40 ),
    Hausnummer VARCHAR ( 6 ),
    Postleitzahl VARCHAR ( 10 ),
    Stadt VARCHAR ( 40 ),
    Land VARCHAR ( 40 )
);