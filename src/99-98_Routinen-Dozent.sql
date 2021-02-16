
use OnlineShop_Edu;

/*
Mit Routinen ( Prozeduren, Funktionen, Trigger ) können wir
den Umgang mit der Datenbank weiter automatisieren.

Z.B. können wir eine Prozedur schreiben, die uns eine
Adresse anlegt und dabei die Daten aus der Argumente-Liste
nimmt.
Das hat den Vorteil zum manuellen Vorgehen, dass der Algorithmus
gleich prüfen kann, ob der Datensatz schon existiert.

Wenn ja, dann gibt uns die Prozedur die passende ID der bereits
bestehenden Adresse aus.

Falls nein, dann wird diese Adresse NEU angelegt. Auch in diesem
Fall erhalten wir die Adresse_ID.

Die Adresse_ID können wir dann gebrauchen, um sie dem Kunden
zuordnen zu können, den wir im nächsten Schritt anlegen.

Auf diese Weise können wir den Kundendatensatz und den Adressdatensatz
gleichzeitig anlegen. Der Datenbank-Server nimmt uns die Arbeit ab,
zu prüfen, ob dieselbe Adresse schon existiert und wenn ja, welche Adress_ID
dann der Kundendatensatz referenzieren muss.

Siehe nächstes Beispiel:
*/


drop procedure if exists AdresseAnlegen;

DELIMITER $$

# IN steht für die INPUT-Variable. Ihre Werte werden im
# Inneren der Prozedur verarbeitet.
create procedure AdresseAnlegen(    IN Strasse_ Varchar( 40 ),
                                    IN Hausnummer_ VARCHAR( 6 ),
                                    IN Postleitzahl_ VARCHAR( 8 ),
                                    IN Stadt_ VARCHAR( 40 ),
                                    IN Land_ VARCHAR( 40 ),
    # OUT steht für die OUTPUT-Variable. Sie dient als Ersatz für
    # den Rückgabewert. ERINNERUNG: Prozeduren haben KEINEN Rückgabewert.
                                    OUT Adresse_ID_ INTEGER
)
BEGIN
    SET Adresse_ID_ = null;
    select Adresse_ID into Adresse_ID_ from Adresse
    where Strasse = Strasse_ AND
            Hausnummer = Hausnummer_ AND
            Postleitzahl = Postleitzahl_ AND
            Stadt = Stadt_ AND
            Land = Land_;

    if Adresse_ID_ is null then
        insert into Adresse values
        ( null,
          Strasse_,
          Hausnummer_,
          Postleitzahl_,
          Stadt_,
          Land_ );
        set Adresse_ID_ = last_insert_id ();
    end if;

end $$

call AdresseAnlegen( 'Karl-Marx-Allee', '158', '272', 'Berlin', 'Deutschland', @Neue_Adresse_ID );

select @Neue_Adresse_ID;

select * from Adresse;

call AdresseAnlegen( 'Kleine Straße', '48', '55321', 'Brunsbüttel', 'Deutschland', @Neue_Adresse_ID );

select @Neue_Adresse_ID;

/*
alter table Kunde
    drop column TelefonNummer;
*/

drop procedure if exists KundeAnlegen;

DELIMITER $$

create procedure KundeAnlegen(  IN Vorname_ VARCHAR( 40 ),
                                IN Nachname_ Varchar( 40 ),
                                IN GeburtsDatum_ Date,
                                IN Adresse_ID_ INTEGER,
                                OUT neue_Kunde_ID INTEGER
)
BEGIN

    set neue_Kunde_ID = null;

    insert into Kunde values
    ( null, Vorname_, Nachname_, GeburtsDatum_, Adresse_ID_ )
    ;

    SELECT LAST_INSERT_ID() into neue_Kunde_ID;



    select '' as 'Neuer Kunde angelgelegt:',
           Kunde_ID,
           Vorname,
           Nachname,
           GeburtsDatum,
           Strasse,
           Hausnummer,
           Postleitzahl,
           Stadt,
           Land
    from Kunde, Adresse
    where Kunde.Adresse_ID = Adresse.Adresse_ID AND
            Kunde_ID = neue_Kunde_ID;

end $$

DELIMITER ;


call AdresseAnlegen( 'Kleine Straße', '48', '55321', 'Brunsbüttel', 'Deutschland', @Neue_Adresse_ID );
call KundeAnlegen( 'Michael', 'Statson', '1981-10-04', @Neue_Adresse_ID, @Neue_Kunde_ID );
call KundeAnlegen( 'Mary', 'Rosenfeld', '1971-11-03', @Neue_Adresse_ID, @Neue_Kunde_ID );
call KundeAnlegen( 'Friderike', 'Klein', '1994-03-21', @Neue_Adresse_ID, @Neue_Kunde_ID );
call KundeAnlegen( 'Markus', 'Schmidt', '1987-07-23', @Neue_Adresse_ID, @Neue_Kunde_ID );

select @Neue_Kunde_ID;
delete from Kunde
where Kunde_ID = @Neue_Kunde_ID;

select * from Kunde;


# -----------------------------

drop function if exists testFN01;

DELIMITER $$

create function multiplyFN( Faktor01 Integer, Faktor02 Integer )
    returns  Integer
BEGIN
    # Variablen werden in MariaDB zu Beginn der Funktion
    # angelegt.
    # Es gibt dann also einen Teil, in dem die Variablen
    # der Funktion angelegt werden.
    DECLARE returnValue Integer;

    set returnValue = Faktor01 * Faktor02;

    # Variablen dürfen NICHT in der Mitte einer Routine ( Funktion, Prozedur oder Trigger )
    # angelegt werden.
    # DECLARE anotherVariable Integer;

    return returnValue;
end $$


DELIMITER ;


drop function if exists testFN02;

DELIMITER $$

create function testFN02()
    RETURNS Integer
BEGIN
    # Es sind KEINE select Anweisungen in einer Funktion erlaubt.
    # Lasst diese Funktion auch noch mal durchlaufen, nachdem Ihr
    # die select Anweisung auskommentiert habt!
    select 'Great!';
    Return 13;
End $$

DELIMITER ;

select testFN02();


drop trigger if exists AltersCheck;

DELIMITER $$

create trigger AltersCheck
    BEFORE INSERT on Kunde
    FOR EACH ROW
BEGIN

    # Denkt daran, dass Variablen NUR im ersten Teil der
    # Routine deklariert werden können:

    DECLARE Untergrenze Date;
    DECLARE Kunde_Alter TINYINT;
    DECLARE Fehlermeldung VARCHAR( 220 );

    set Untergrenze = Now();

    set Untergrenze = Concat(   YEAR( Untergrenze ) - 18, '-',
                                MONTH( Untergrenze ), '-',
                                DAY( Untergrenze ) );
    /*
    NEW steht für den neu anzulege Datensatz.
    Der neue Kunde muss älter sein als 18.
    Sein Geburtsdatum muss also entsprechend mit dem
    entsprechenden Datum abgeglichen werden. */
    if ( NEW.GeburtsDatum > Untergrenze  ) then

        set Kunde_Alter = Year( Now() ) - Year( New.GeburtsDatum );


        set Fehlermeldung = Concat( 'Dieser Kunde ist ', Kunde_Alter, ' Jahre oder jünger. Das Minderstalter, um Kunde in diesem Shop werden zu können, beträgt 18 Jahre und wurde von diesem Kunden NICHT erreicht.' );


        /*
        SIGNAL SQLSTATE [...] wirft einen Fehler, der
        zum Abbruch der INSERT Anweisung führt und somit
        verhindert, dass der Datensatz angelegt wird.
        Der SQLSTATE '45000' ist speziell für  User Exceptions
        gedacht, also für Ausnahme-Fehler, die der Datenbank-
        Entwickler selbst anlegt. */
        SIGNAL SQLSTATE '45000'
            set message_Text = Fehlermeldung;
    end if ;

end $$

DELIMITER ;


insert into Kunde VALUES
( null, 'Marc-Uwe', 'Neugebauer', '2005-04-23', 3 );

select * from Kunde
order by Kunde_ID;



# -----------------------------
/*
    Bei MySQL und MariaDB unterscheiden sich die
    Prozeduren und Funktionen durch mehr Merkmale,
    als nur, dadurch, dass Funktionen einen Rückgabe-
    wert haben und Prozeduren nicht.

    Bei MariaDB ( bzw. MySQL )...
    + ...   können Prozeduren Werte zurückgeben, in dem
            sie OUT Variablen übernehmen können.
            Sie übernehmen diese genauso wie die IN
            Variablen über die Parameterliste beim Aufruf
            der Prozedur.
            Sie verarbeiten diese dann in ihrem Prozeduren-
            körper.
            Da sie von außen übergeben worden sind, stehen
            sie außen auch wieder zur Verfügung.
            Funktionen geben natürlich IMMER einen Rückgabe-
            wert zurück ( Schlüsselwort 'RETURN' ).
    + ...   werden Prozeduren mit dem Schlüsselwort
            'call' aufgerufen.
    + ...   werden Funktionen OHNE jedes weitere Schlüsselwort
            aufgerufen.
    + ...   spricht man von Routinen als Zusammenfassung für
            Prozeduren und Funktionen ( anstelle von 'Methoden'
            wie beispielsweise in JAVA ).
            Der Begriff 'Routinen' beinhaltet außerdem auch Trigger.
    + ...   Funktionen können KEINE select Abfragen durchführen.
*/





