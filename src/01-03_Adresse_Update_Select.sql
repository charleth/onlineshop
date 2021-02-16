USE onlineshop;

/*
 update Adresse
    set Postleitzahl = '33127'
    where   Strasse = 'Steinplatz' AND
            Stadt = 'Kaiserslautern'
 ;
 */

SELECT * FROM Adresse;

SELECT Strasse, Hausnummer FROM Adresse;

SELECT * FROM Adresse
    WHERE Postleitzahl = '33127'
;

# Alle Adressen der Friedrichstrasse

SELECT * FROM Adresse
WHERE Strasse = 'Friedrichstraße'
;