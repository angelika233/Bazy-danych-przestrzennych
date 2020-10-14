CREATE SCHEMA firma;
CREATE ROLE ksiegowosc; 
CREATE TABLE firma.pracownicy(  id_pracownika int PRIMARY KEY, imie VARCHAR( 15 ) ,  nazwisko varchar(40),  adres varchar(100), telefon  varchar(20));
COMMENT ON TABLE firma.pracownicy IS 'wszyscy pracownicy firmy';
CREATE TABLE firma.godziny(  id_godziny int PRIMARY KEY, dat VARCHAR( 15 ) ,  liczba_godzin int ,  id_pracownika int);
COMMENT ON TABLE firma.godziny IS 'wszystkie godziny';
CREATE TABLE firma.pensja(  id_pensji int PRIMARY KEY, stanowisko VARCHAR( 15 ) ,  kwota float  );
COMMENT ON TABLE firma.pensja IS 'wszystkie pensje';
CREATE TABLE firma.premia(  id_premii int PRIMARY KEY, rodzaj VARCHAR( 35 ) ,  kwota float  );
COMMENT ON TABLE firma.prremia IS 'wszystkie premie';
CREATE TABLE firma.wynagrodzenia(  id_wynagrodzenia int PRIMARY KEY, dat VARCHAR( 15 ) , id_pracownika int, id_godziny int, id_pensji int, id_premii int );
COMMENT ON TABLE firma.wynagrodzenia IS 'wszystkie wynagrodzenia';

ALTER TABLE firma.godziny
ADD FOREIGN KEY (id_pracownika) REFERENCES firma.pracownicy(id_pracownika);
ALTER TABLE firma.wynagrodzenia
ADD FOREIGN KEY (id_godziny) REFERENCES firma.godziny(id_godziny);
ALTER TABLE firma.wynagrodzenia
ADD FOREIGN KEY (id_premii) REFERENCES firma.premia(id_premii);
ALTER TABLE firma.wynagrodzenia
ADD FOREIGN KEY (id_pensji) REFERENCES firma.pensja(id_pensji);
ALTER TABLE firma.wynagrodzenia
ADD FOREIGN KEY (id_pracownika) REFERENCES firma.pracownicy(id_pracownika);
ALTER TABLE firma.wynagrodzenia
ADD FOREIGN KEY (id_godziny) REFERENCES firma.godziny(id_godziny);

INSERT INTO firma.pracownicy VALUES(1,'Tomasz', 'Nowak', 'Krakow', 512556512);
INSERT INTO firma.pracownicy VALUES(2,'Jan', 'Kowalski', 'Krakow', 512512412);
INSERT INTO firma.pracownicy VALUES(3,'Marta', 'Mazur', 'Warszawa', 567512512);
INSERT INTO firma.pracownicy VALUES(4,'Krzysztof', 'Nowy', 'Wroclaw', 578512512);
INSERT INTO firma.pracownicy VALUES(5,'Jacek', 'Kot', 'Wroclaw', 515198762);
INSERT INTO firma.pracownicy VALUES(6,'Anna', 'Kowalczyk', 'Gdynia', 512326162);
INSERT INTO firma.pracownicy VALUES(7,'Katarzyna', 'Nowakowska', 'Las', 518782512);
INSERT INTO firma.pracownicy VALUES(8,'Kamil', 'Górski', 'Katowice', 512519992);
INSERT INTO firma.pracownicy VALUES(9,'Teresa', 'Szklarz', 'Krakow', 533312512);
INSERT INTO firma.pracownicy VALUES(10,'Marzena', 'Nyska', 'Krakow', 512779512);

INSERT INTO firma.godziny VALUES(1,'11-06-2020', 7, 1);
INSERT INTO firma.godziny VALUES(2,'11-06-2020', 7, 2);
INSERT INTO firma.godziny VALUES(3,'11-06-2020', 7, 3);
INSERT INTO firma.godziny VALUES(4,'11-06-2020', 7, 4);
INSERT INTO firma.godziny VALUES(5,'11-06-2020', 8, 5);
INSERT INTO firma.godziny VALUES(6,'12-06-2020', 7, 5);
INSERT INTO firma.godziny VALUES(7,'13-06-2020', 8, 5);
INSERT INTO firma.godziny VALUES(8,'12-06-2020', 7, 1);
INSERT INTO firma.godziny VALUES(9,'13-06-2020', 8, 1);
INSERT INTO firma.godziny VALUES(10,'14-06-2020', 7, 1);

INSERT INTO firma.premia VALUES(1,'brak', 0);
INSERT INTO firma.premia VALUES(2,'obecnosc', 100);
INSERT INTO firma.premia VALUES(3,'punktualnosc', 200);
INSERT INTO firma.premia VALUES(4,'sprzedaz', 230);
INSERT INTO firma.premia VALUES(5,'staz', 500);
INSERT INTO firma.premia VALUES(6,'rozwoj', 350);
INSERT INTO firma.premia VALUES(7,'nadgodziny', 200);
INSERT INTO firma.premia VALUES(8,'weekendy', 100);
INSERT INTO firma.premia VALUES(9,'swieta', 250);
INSERT INTO firma.premia VALUES(10,'pomoc', 90);

INSERT INTO firma.pensja VALUES(1,'ksiegowy', 3000);
INSERT INTO firma.pensja VALUES(2,'projektant', 3500);
INSERT INTO firma.pensja VALUES(3,'dyrektor', 7000);
INSERT INTO firma.pensja VALUES(4,'zastepca', 5000);
INSERT INTO firma.pensja VALUES(5,'sprzataczka', 2000);
INSERT INTO firma.pensja VALUES(6,'informatyk', 3800);
INSERT INTO firma.pensja VALUES(7,'pomoc', 3000);
INSERT INTO firma.pensja VALUES(8,'hr', 4000);
INSERT INTO firma.pensja VALUES(9,'szkoleniowiec', 3500);
INSERT INTO firma.pensja VALUES(10,'pomoc', 2500);

INSERT INTO firma.wynagrodzenia VALUES(1,'11-06-2020',4,4,6,1);
INSERT INTO firma.wynagrodzenia VALUES(2,'12-06-2020',6,4,6,1);
INSERT INTO firma.wynagrodzenia VALUES(3,'11-06-2020',8,3,1,1);
INSERT INTO firma.wynagrodzenia VALUES(4,'14-06-2020',9,1,4,2);
INSERT INTO firma.wynagrodzenia VALUES(5,'14-06-2020',5,1,4,6);
INSERT INTO firma.wynagrodzenia VALUES(6,'11-06-2020',4,1,3,2);
INSERT INTO firma.wynagrodzenia VALUES(7,'11-06-2020',4,9,3,6);
INSERT INTO firma.wynagrodzenia VALUES(8,'12-06-2020',1,8,4,10);
INSERT INTO firma.wynagrodzenia VALUES(9,'12-06-2020',1,8,4,3);
INSERT INTO firma.wynagrodzenia VALUES(10,'12-06-2020',7,7,7,9);

ALTER TABLE firma.godziny ADD COLUMN miesiac INT;
UPDATE firma.godziny SET miesiac=DATE_PART('month',data)
SELECT DATE_PART('month',data) FROM firma.godziny
ALTER TABLE firma.godziny ADD COLUMN tydzien INT
UPDATE firma.godziny SET tydzien=DATE_PART('week',data)
SELECT DATE_PART('week',data) FROM firma.godziny


SELECT id_pracownika, nazwisko FROM firma.pracownicy;
SELECT id_pracownika, kwota FROM firma.pracownicy, firma.pensja WHERE kwota>1000;
SELECT * FROM firma.pracownicy WHERE imie LIKE 'J%';
SELECT * FROM firma.pracownicy WHERE imie LIKE '%n%' AND nazwisko LIKE '%a';
SELECT imie, nazwisko kwota FROM firma.pracownicy, firma.godziny WHERE liczba_godzin>160;
SELECT imie,nazwisko,kwota FROM firma.pracownicy, firma.pensja WHERE (kwota> 1500 AND kwota <3000);

SELECT imie,nazwisko,kwota FROM firma.pracownicy, firma.pensja ORDER BY kwota;
SELECT imie,nazwisko,kwota FROM firma.pracownicy, firma.pensja ORDER BY kwota DESC;
SELECT COUNT (stanowisko) FROM firma.pensja;
SELECT  MIN(kwota) FROM firma.pensja WHERE stanowisko='ksiegowy';
SELECT  MAX(kwota) FROM firma.pensja WHERE stanowisko='ksiegowy';
SELECT  MEAN(kwota) FROM firma.pensja WHERE stanowisko='ksiegowy';
SELECT  SUM(kwota) FROM firma.pensja ;
SELECT  SUM(pensja.kwota)+ SUM(premia.kwota) FROM firma.pensja, firma.premia ;

UPDATE firma.pracownicy
SET telefon = '(+48)' || telefon;

UPDATE firma.pracownicy
SET telefon = SUBSTRING(telefon,0,9) || '-' || SUBSTRING (telefon,9,3) || '-' || SUBSTRING (telefon,12,3);
SELECT * FROM firma.pracownicy WHERE CHARACTER_LENGTH(nazwisko) = (select max(CHARACTER_LENGTH(nazwisko)) from firma.pracownicy);

SELECT kpen.kwota AS kwota FROM firma.pracownicy kp
JOIN firma.wynagrodzenia kw ON kw.id_pracownika = kp.id_pracownika
JOIN firma.pensja kpen ON kpen.id_pensji = kw.id_pensji;
SELECT kp.imie,kp.nazwisko, kpen.kwota, kpr.kwota FROM firma.wynagrodzenia kw 
LEFT JOIN firma.pracownicy kp ON kp.id_pracownika = kw.id_pracownika
LEFT JOIN firma.premia kpr ON kpr.id_premii = kw.id_premii
LEFT JOIN firma.pensja kpen ON kpen.id_pensji = kw.id_pensji;

SELECT 'Pracownik ' || kp.imie || ' ' || kp.nazwisko 
|| ' w dniu ' || kg.dat
|| ' otrzymał pensje całkowitą na kwotę ' || kpen.kwota + kpr.kwota 
|| ' gdzie wynagrodzenie zasadnicze wynosiło: '|| kpen.kwota || ',a premia: ' || kpr.kwota || ', nadgodziny: ' || '0 zł' AS raport
FROM firma.pracownicy kp
JOIN firma.wynagrodzenia kw ON kw.id_pracownika = kp.id_pracownika 
JOIN firma.pensja kpen ON kpen.id_pensji = kw.id_pensji 
JOIN firma.premia kpr ON kpr.id_premii = kw.id_premii 
JOIN firma.godziny kg ON kp.id_pracownika = kp.id_pracownika;
