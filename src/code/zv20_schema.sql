CREATE TABLE Gyarto (
  gyartoId INTEGER PRIMARY KEY,
  nev VARCHAR(100) NOT NULL,
  telephely VARCHAR(100)
);

CREATE TABLE Termek (
  termekId INTEGER PRIMARY KEY,
  nev VARCHAR(100) NOT NULL,
  ar INTEGER NOT NULL CHECK (ar > 0),
  kategoria VARCHAR(40),
  gyartoId INTEGER NOT NULL,
  CONSTRAINT fk_termek_gyarto
    FOREIGN KEY (gyartoId) REFERENCES Gyarto(gyartoId)
);

ALTER TABLE Termek
ADD keszlet INTEGER DEFAULT 0 CHECK (keszlet >= 0);

DROP TABLE Termek;
