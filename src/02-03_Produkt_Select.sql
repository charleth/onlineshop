use onlineshop;

select '02-03_Produkt_Select.sql' as o;

# Alle Datensätze der Tabelle Produkt

select * from Produkt;


# Alle Produkte, die teurer sind als 10,00 €
# Bezeichnung, Preis -- sortiert nach Preis, aufsteigend

select Bezeichnung, Preis
    from Produkt
    where Preis > 10
    order by Preis ASC;

# Das Produkt mit der Bezeichnung 'Klavierhocker'

select Bezeichnung, Preis
    from Produkt
    where Bezeichnung = 'Klavierhocker';

# Alle Produkte, die ein 'Tee' in der Bezeichnung haben

select Bezeichnung, Preis
    from Produkt
    where Bezeichnung LIKE '%Tee%'
    order by Bezeichnung ASC;

# Das teuerste Produkt - simpel (und nicht akkurat)

select Bezeichnung, Preis
    from Produkt
    order by Preis DESC
    limit 1;

# Das teuerste Produkt - mit Aggregat

select max (Preis) into @maxPreis from Produkt;
select round(@maxPreis, 2) AS 'Höchster Preis', Bezeichnung from Produkt
    where Preis = @maxPreis;

# Das günstigste Produkt - simpel (und nicht akkurat)

select Bezeichnung, Preis
    from Produkt
    order by Preis ASC
    limit 1;

# Das günstigste Produkt - mit Aggregat

select min (Preis) into @minPreis from Produkt;
select round (@minPreis, 2) AS 'Kleinster Preis', Bezeichnung from Produkt
    where Preis =@minPreis;

# Durchschnitts-Preis aller angebotenen Produkte

select round(avg(Preis),2) as 'Durchschnitts-Preis' from Produkt;

# Anzahl Zeilen in einer Tabellen-Ausgabe limitieren um zu 'blättern'

# Teuerste Produkte 1-5

select Bezeichnung, Preis
    from Produkt
    order by Preis DESC
    limit 5
;

# Teuerste Produkte 6-10

select Bezeichnung, Preis
    from Produkt
    order by Preis DESC
    limit 5 OFFSET 5
;

# Teuerste Produkte 11-15

select Bezeichnung, Preis
    from Produkt
    order by Preis DESC
    limit 5 OFFSET 10
;

# Teuerste Produkte 16-21

select Bezeichnung, Preis
    from Produkt
    order by Preis DESC
    limit 5 OFFSET 15
;