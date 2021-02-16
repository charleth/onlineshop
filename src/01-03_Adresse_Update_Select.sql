use onlineshop;

/*
 update Adresse
    set Postleitzahl = '33127'
    where   Strasse = 'Steinplatz' AND
            Stadt = 'Kaiserslautern'
 ;
 */

select * from Adresse;

select Strasse, Hausnummer from Adresse;

select * from Adresse
    where Postleitzahl = '33127'
;

# Alle Adressen der Friedrichstrasse

select * from Adresse
where Strasse = 'Friedrichstraße'
;