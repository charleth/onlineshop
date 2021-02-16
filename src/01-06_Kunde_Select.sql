use onlineshop;

# Alle Datensätze aller Spalten der Tabelle 'Kunde' anzeigen

select * from Kunde;

# Alle Datensätze in den Spalten Vorname und Nachname der Tabelle 'Kunde' anzeigen

select Vorname, Nachname from Kunde;

# verknüpfte Datensätze der Tabellen Kunde und Adresse

select
       CONCAT(Kunde.Vorname, ' ', Kunde.Nachname) as Kunde,
       CONCAT(Adresse.Strasse, ' ', Adresse.Hausnummer, ', ', Adresse.Postleitzahl, ' ', Adresse.Stadt) as Adresse
    from Kunde, Adresse
    where Kunde.Adresse_ID = Adresse.Adresse_ID;

# Alle Spalten der Tabelle Kunde anzeigen und nach
# Geburtsdatum absteigend sortieren

select * from Kunde
    order by GeburtsDatum DESC;

# Alle Spalten der Tabelle Kunde anzeigen und nach
# Geburtsdatum aufsteigend sortieren

select * from Kunde
    order by GeburtsDatum ASC;