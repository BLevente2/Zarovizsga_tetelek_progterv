# Záróvizsga tételek - Programtervező Informatikus BSc

Ez a projekt a 2026-os Programtervező Informatikus BSc záróvizsga tételek LuaLaTeX-ben készült kidolgozását tartalmazza.

A dokumentumokat Baba Levente készítette ChatGPT segítségével. A projekt célja egy egységesen formázott, könnyen bővíthető és külön-külön fordítható tételgyűjtemény létrehozása.

## Tartalom

Jelenleg a projekt az alábbi tételeket tartalmazza:

- `zv_tetel_01.tex` - 1. tétel: adatok, adattípusok, adatműveletek és adatstruktúrák
- `zv_tetel_02.tex` - 2. tétel: algoritmus, iteráció, rekurzió, memória, verem, procedúra, folyamatábra, pszeudokód, elemi algoritmusok
- `zv_tetel_03.tex` - 3. tétel: strukturált programozás, programgráf, vezérlőgráf, struktogram, ciklikus bonyolultság
- `zv_tetel_04.tex` - 4. tétel: számelméleti algoritmusok, euklideszi algoritmus, kongruenciák, moduláris hatványozás, Fermat-prímteszt, RSA
- `zv_tetel_05.tex` - 5. tétel: rendezések, oszd meg és uralkodj, lineáris idejű rendezések, időelemzés, rendezési pszeudókódok

Minden tétel külön PDF-be fordul, így az egyes tételek önálló dokumentumként is használhatók.

A teljes hivatalos tételsor külön dokumentumként is szerepel a projektben:

- `zv_tetelsor.tex` - a 27 tételes záróvizsga tételsor LuaLaTeX-forrása

A tételek fedlapján szereplő hivatalos tételkiírások is ebből a fájlból származnak, ezért a tételkiírások csak egy helyen vannak letárolva.

## Projektstruktúra

```text
.
├── Makefile
├── README.md
├── .gitignore
├── output/
└── src/
    ├── preamble.tex
    ├── zv_tetelsor.tex
    ├── zv_tetel_01.tex
    ├── zv_tetel_02.tex
    ├── zv_tetel_03.tex
    ├── zv_tetel_04.tex
    ├── zv_tetel_05.tex
    ├── figures/
    │   ├── zv_abrak.tex
    │   └── ... külön TikZ-ábrák ...
    ├── tables/
    │   ├── zv_tablazatok.tex
    │   └── ... külön táblázatok ...
    └── code/
        └── ... külön kód- és pszeudókód-fájlok ...
```

## Fontos fájlok

### `Makefile`

A fordítási parancsokat tartalmazza. A célja, hogy ne kelljen minden `.tex` fájlt kézzel fordítani.

### `src/zv_tetelsor.tex`

Ez a fájl tartalmazza a 27 hivatalos záróvizsga-tétel kiírását LuaLaTeX makrók formájában, valamint önálló dokumentumként is lefordítható.

A fájl két szerepet tölt be:

- önálló dokumentumként előállítja a teljes tételsort: `output/zv_tetelsor.pdf`;
- adatforrásként szolgál a kidolgozott tételek fedlapjához, tehát a fedlapokon szereplő hivatalos tételkiírások innen kerülnek be.

Ennek az az előnye, hogy ha a tételsor szövegét javítani kell, akkor nem kell minden egyes tételben külön módosítani: elegendő a `src/zv_tetelsor.tex` fájlban javítani.

### `src/preamble.tex`

A közös LaTeX-beállításokat tartalmazza:

- betűtípusok;
- margók;
- fejléc és lábléc;
- színek;
- címlap sablon;
- TikZ-stílusok;
- táblázatkezeléshez szükséges csomagok;
- kódrészletek és pszeudókódok formázása;
- közös makrók.

A tételekben lehetőleg csak a tényleges tételszöveg szerepeljen. Ami több dokumentumban is közös, azt érdemes a `preamble.tex` fájlba kiszervezni.

### `src/figures/`

Ebben a mappában vannak a külön `.tex` fájlokba kiszervezett TikZ-ábrák.

Az ábrák gyűjtődokumentuma:

```text
src/figures/zv_abrak.tex
```

Ez egy önálló LaTeX-dokumentum, amely az összes ábrát egy PDF-be rendezi úgy, hogy minden oldalra külön ábra kerüljön.

### `src/code/`

Ebben a mappában vannak a tételekben megjelenített kódok és pszeudókódok külön fájlokba kiszervezve.

A tételekben a kódok nem közvetlenül `lstlisting` blokkokként szerepelnek, hanem `\lstinputlisting` alapú közös makrókon keresztül kerülnek be. Ennek előnye, hogy a kódok külön is áttekinthetők, elnevezhetők, újrahasználhatók, és a LaTeX-források kevésbé zsúfoltak.

Javasolt névkonvenció:

```text
src/code/zv05_beszuro_rendezes.pseudo
src/code/zv05_gyorsrendezes.pseudo
src/code/zv01_student_rekord_c.c
```

### `src/tables/`

Ebben a mappában vannak a külön `.tex` fájlokba kiszervezett táblázatok.

A táblázatok gyűjtődokumentuma:

```text
src/tables/zv_tablazatok.tex
```

Ez egy önálló LaTeX-dokumentum, amely az összes táblázatot egy PDF-be rendezi úgy, hogy minden oldalra külön táblázat kerüljön.

### `output/`

Ide kerülnek a lefordított PDF-ek és az ideiglenes LaTeX-fájlok.

Ez a mappa szándékosan szerepel a `.gitignore` fájlban, mert a PDF-ek és az ideiglenes fordítási fájlok újragenerálhatók a forrásból.

## Szükséges programok

A fordításhoz szükséges:

- LuaLaTeX;
- GNU Make vagy kompatibilis `make` program;
- olyan TeX-disztribúció, amely tartalmazza a használt csomagokat.

Ajánlott TeX-disztribúciók:

- Windows alatt: MiKTeX vagy TeX Live;
- Linux alatt: TeX Live;
- macOS alatt: MacTeX.

A dokumentum LuaLaTeX-re épül, ezért nem ajánlott `pdflatex` paranccsal fordítani.

## Fordítás

### Az összes tétel fordítása

```bash
make
```

Ez a kidolgozott tételeket és a teljes tételsort fordítja le:

- `output/zv_tetel_01.pdf`
- `output/zv_tetel_02.pdf`
- `output/zv_tetel_03.pdf`
- `output/zv_tetel_04.pdf`
- `output/zv_tetel_05.pdf`
- `output/zv_tetelsor.pdf`

A sima `make` nem fordítja le külön az ábragyűjteményt és a táblázatgyűjteményt.

### Csak az ábragyűjtemény fordítása

```bash
make figures
```

vagy magyar alias-szal:

```bash
make abrak
```

Eredmény:

```text
output/zv_abrak.pdf
```

Ez a cél csak az összesített ábrás dokumentumot fordítja, a tételeket nem.

### Csak a táblázatgyűjtemény fordítása

```bash
make tables
```

vagy magyar alias-szal:

```bash
make tablazatok
```

Eredmény:

```text
output/zv_tablazatok.pdf
```

Ez a cél csak az összesített táblázatos dokumentumot fordítja, a tételeket nem.

### Elérhető PDF-célok listázása

```bash
make list
```

Ez kiírja, hogy a Makefile milyen PDF-eket tud előállítani.

### Ideiglenes fájlok törlése

```bash
make clean
```

Ez az `output` mappában lévő ideiglenes LaTeX-fájlokat törli, de a PDF-eket megtartja.

### Teljes takarítás

```bash
make distclean
```

Ez az ideiglenes fájlok mellett az `output` mappában lévő PDF-eket is törli.

## Fordítás Windows alatt

Ha Windows alatt a `make` parancs nem érhető el, akkor használható például:

```powershell
mingw32-make
```

vagy olyan fejlesztői környezet, amely tartalmaz GNU Make-et.

A projekt LuaLaTeX-et használ, ezért fontos, hogy a `lualatex` parancs elérhető legyen a parancssorból.

## Új tétel hozzáadása

Új tétel hozzáadásához hozz létre egy új fájlt a `src` mappában, például:

```text
src/zv_tetel_04.tex
```

A fájl elején érdemes a meglévő tételek mintáját követni:

```tex
\documentclass[12pt,a4paper]{article}

\newcommand{\TETELNUMBER}{4}
\newcommand{\TETELTITLE}{A tétel rövid címe}
\newcommand{\TETELSHORTTITLE}{Rövid fejléc-cím}

\newcommand{\ZVTetelsorDataOnly}{}
\input{src/zv_tetelsor.tex}
\newcommand{\TETELKIIRAS}{\ZVTetelKiiras{\TETELNUMBER}}

\input{src/preamble.tex}

\begin{document}
\zvfrontmatter

% A tétel kidolgozása itt kezdődik.

\end{document}
```

A Makefile automatikusan felismeri a `src/zv_tetel_*.tex` mintára illeszkedő fájlokat, ezért az új tételt a sima `make` parancs is le fogja fordítani.

A fedlap hivatalos tételkiírását ne kézzel másold be az új tételbe. A tételkiírásokat a `src/zv_tetelsor.tex` tartalmazza, ezért az új tétel elején is a fenti `\ZVTetelsorDataOnly`, `\input{src/zv_tetelsor.tex}` és `\TETELKIIRAS` részt érdemes használni.

## Új ábra hozzáadása

Új ábrát a `src/figures` mappába érdemes tenni, például:

```text
src/figures/uj_abra_neve.tex
```

A tételben így lehet használni:

```tex
\input{src/figures/uj_abra_neve.tex}
```

Ha azt szeretnéd, hogy az ábra az összesített ábragyűjteményben is megjelenjen, akkor add hozzá a `src/figures/zv_abrak.tex` fájlhoz is.

## Új táblázat hozzáadása

Új táblázatot a `src/tables` mappába érdemes tenni, például:

```text
src/tables/uj_tablazat_neve.tex
```

A tételben így lehet használni:

```tex
\input{src/tables/uj_tablazat_neve.tex}
```

Ha azt szeretnéd, hogy a táblázat az összesített táblázatgyűjteményben is megjelenjen, akkor add hozzá a `src/tables/zv_tablazatok.tex` fájlhoz is.

## Verziókezelés

A projekt mellé került egy `.gitignore` fájl is, amely kizárja többek között:

- az `output/` mappát;
- LaTeX ideiglenes fordítási fájlokat;
- szerkesztői és operációs rendszer által létrehozott segédfájlokat.

Így Gitbe alapvetően a forrásfájlokat érdemes felvenni, nem pedig a fordítási eredményeket.

## Megjegyzés

A dokumentum tanulási segédanyag. A kidolgozott tételek nem hivatalos egyetemi jegyzetek, hanem a záróvizsgára való felkészülést segítő, rendszerezett összefoglalók.
