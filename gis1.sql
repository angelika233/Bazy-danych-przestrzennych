 CREATE DATABASE gisdb 
CREATE EXTENSION postgis; 

CREATE TABLE budynki (id INTEGER, nazwa VARCHAR(30), geom GEOMETRY);
INSERT INTO budynki VALUES (1, 'Buildingf', ST_GEOMFROMTEXT('POLYGON((1 1, 1 2, 2 2,2 1, 1 1 ))',0));
INSERT INTO budynki VALUES (2, 'BuildingA', ST_GEOMFROMTEXT('POLYGON((8 4, 10.5 4, 10.5 1.5,8 1.5, 8 4 ))',0));
INSERT INTO budynki VALUES (3, 'BuildingB', ST_GEOMFROMTEXT('POLYGON((4 7, 6 7, 6 5,4 5, 4 7 ))',0));
INSERT INTO budynki VALUES (4, 'BuildingC', ST_GEOMFROMTEXT('POLYGON((3 8, 5 8, 5 6,3 6, 3 8 ))',0));
INSERT INTO budynki VALUES (5, 'BuildingD', ST_GEOMFROMTEXT('POLYGON((9 9, 10 9, 10 8,9 8, 9 9 ))',0));
SELECT * FROM budynki;

CREATE TABLE drogi (id INTEGER, nazwa VARCHAR(30), geom GEOMETRY);
INSERT INTO drogi VALUES (1, 'RoadY', ST_GEOMFROMTEXT('LINESTRING(7.5 10.5, 7.5 0 )',0));
INSERT INTO drogi VALUES (2, 'RoadX', ST_GEOMFROMTEXT('LINESTRING(0 4.5, 12 4.5 )',0));
SELECT * FROM drogi;
CREATE TABLE punkty_informcyjne (id INTEGER, nazwa VARCHAR(30), geom GEOMETRY);
INSERT INTO punkty_informcyjne VALUES (1, 'K', ST_GEOMFROMTEXT('POINT(6 9.5 )',0));
 INSERT INTO punkty_informcyjne VALUES (2, 'I', ST_GEOMFROMTEXT('POINT(9.5 6 )',0));
 INSERT INTO punkty_informcyjne VALUES (3, 'J', ST_GEOMFROMTEXT('POINT(6.5 6 )',0));
 INSERT INTO punkty_informcyjne VALUES (4, 'G', ST_GEOMFROMTEXT('POINT(1 3.5 )',0));
 INSERT INTO punkty_informcyjne VALUES (5, 'H', ST_GEOMFROMTEXT('POINT(5.5 1.5 )',0));
 SELECT * FROM punkty_informcyjne;

 SELECT SUM(ST_LENGTH(geom)) FROM drogi;
 SELECT geom, ST_PERIMETER(geom), ST_AREA(geom) FROM budynki WHERE nazwa='BuildingA';
 SELECT nazwa, ST_AREA(geom) FROM budynki ORDER BY nazwa;
 SELECT nazwa, ST_AREA(geom) FROM budynki ORDER BY ST_AREA(geom) DESC LIMIT 2;
 SELECT  ST_DISTANCE(punkty_informcyjne.geom, budynki.geom) FROM budynki, punkty_informcyjne WHERE budynki.nazwa='BuildingC'AND punkty_informcyjne.nazwa='G';
 CREATE TABLE buffer AS SELECT ST_BUFFER(budynki.geom, 0.5) FROM budynki WHERE budynki.nazwa='BuildingB';
 SELECT * FROM buffer;
 SELECT -1*(ST_AREA(geom)-ST_AREA(st_buffer)) FROM budynki,buffer WHERE budynki.nazwa='BuildingC';
 SELECT budynki.nazwa,budynki.geom, ST_CENTROID(budynki.geom) FROM budynki, drogi WHERE ST_CENTROID(budynki.geom)>drogi.geom AND drogi.nazwa='RoadX' ;
