use onlineshop;

drop table if exists Produkt;

create table Produkt (
    Produkt_ID INTEGER AUTO_INCREMENT PRIMARY KEY,
    Bezeichnung VARCHAR( 40 ),
    Preis DECIMAL( 9,2 )
);