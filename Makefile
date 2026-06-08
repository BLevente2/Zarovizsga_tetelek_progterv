SRC_DIR := src
FIGURES_DIR := $(SRC_DIR)/figures
TABLES_DIR := $(SRC_DIR)/tables
CODE_DIR := $(SRC_DIR)/code
BODIES_DIR := $(SRC_DIR)/bodies
OUT_DIR := output
LUALATEX := lualatex
LATEX_FLAGS := -interaction=nonstopmode -halt-on-error -output-directory=$(OUT_DIR)

TETEL_FILES := $(wildcard $(SRC_DIR)/zv_tetel_*.tex)
TETELSOR_MAIN := $(SRC_DIR)/zv_tetelsor.tex
FULL_MAIN := $(SRC_DIR)/zv_osszes_tetel.tex
TEX_FILES := $(TETEL_FILES) $(TETELSOR_MAIN)
MAIN_FILES := $(TEX_FILES) $(FULL_MAIN)
COMMON_FILES := $(filter-out $(MAIN_FILES),$(wildcard $(SRC_DIR)/*.tex))
FIGURES_MAIN := $(FIGURES_DIR)/zv_abrak.tex
FIGURE_FILES := $(filter-out $(FIGURES_MAIN),$(wildcard $(FIGURES_DIR)/*.tex))
TABLES_MAIN := $(TABLES_DIR)/zv_tablazatok.tex
TABLE_FILES := $(filter-out $(TABLES_MAIN),$(wildcard $(TABLES_DIR)/*.tex))
CODE_FILES := $(wildcard $(CODE_DIR)/*)
BODY_FILES := $(wildcard $(BODIES_DIR)/*.tex)
PDF_FILES := $(patsubst $(SRC_DIR)/%.tex,$(OUT_DIR)/%.pdf,$(TEX_FILES))
TETELSOR_PDF := $(OUT_DIR)/zv_tetelsor.pdf
FIGURES_PDF := $(OUT_DIR)/zv_abrak.pdf
TABLES_PDF := $(OUT_DIR)/zv_tablazatok.pdf
FULL_COMBINED_PDF := $(OUT_DIR)/zv_osszes_tetel.pdf
FULL_PDF_FILES := $(PDF_FILES) $(FIGURES_PDF) $(TABLES_PDF) $(FULL_COMBINED_PDF)

ifeq ($(OS),Windows_NT)
DEFAULT_JOBS := $(NUMBER_OF_PROCESSORS)
MKDIR_OUT = if not exist "$(OUT_DIR)" mkdir "$(OUT_DIR)"
CLEAN_TEMP = -del /Q /F "$(OUT_DIR)\*.aux" "$(OUT_DIR)\*.log" "$(OUT_DIR)\*.out" "$(OUT_DIR)\*.toc" "$(OUT_DIR)\*.fls" "$(OUT_DIR)\*.fdb_latexmk" "$(OUT_DIR)\*.synctex.gz" "$(OUT_DIR)\*.bbl" "$(OUT_DIR)\*.bcf" "$(OUT_DIR)\*.blg" "$(OUT_DIR)\*.run.xml" "$(OUT_DIR)\*.lof" "$(OUT_DIR)\*.lot" "$(OUT_DIR)\*.lol" "$(OUT_DIR)\*.idx" "$(OUT_DIR)\*.ilg" "$(OUT_DIR)\*.ind" 2>NUL
CLEAN_PDF = -del /Q /F "$(OUT_DIR)\*.pdf" 2>NUL
else
DEFAULT_JOBS := $(shell nproc 2>/dev/null || getconf _NPROCESSORS_ONLN 2>/dev/null || echo 4)
MKDIR_OUT = mkdir -p "$(OUT_DIR)"
CLEAN_TEMP = rm -f "$(OUT_DIR)"/*.aux "$(OUT_DIR)"/*.log "$(OUT_DIR)"/*.out "$(OUT_DIR)"/*.toc "$(OUT_DIR)"/*.fls "$(OUT_DIR)"/*.fdb_latexmk "$(OUT_DIR)"/*.synctex.gz "$(OUT_DIR)"/*.bbl "$(OUT_DIR)"/*.bcf "$(OUT_DIR)"/*.blg "$(OUT_DIR)"/*.run.xml "$(OUT_DIR)"/*.lof "$(OUT_DIR)"/*.lot "$(OUT_DIR)"/*.lol "$(OUT_DIR)"/*.idx "$(OUT_DIR)"/*.ilg "$(OUT_DIR)"/*.ind
CLEAN_PDF = rm -f "$(OUT_DIR)"/*.pdf
endif

ifeq ($(strip $(DEFAULT_JOBS)),)
DEFAULT_JOBS := 4
endif

JOBS ?= $(DEFAULT_JOBS)

all: $(PDF_FILES)

full: $(FULL_PDF_FILES)

fast:
	$(MAKE) -j$(JOBS) all

fast-full:
	$(MAKE) -j$(JOBS) full

all-clean: all
	$(MAKE) clean

full-clean: full
	$(MAKE) clean

prepare:
	$(MKDIR_OUT)

$(FULL_COMBINED_PDF): $(FULL_MAIN) $(COMMON_FILES) $(TETELSOR_MAIN) $(BODY_FILES) $(FIGURE_FILES) $(TABLE_FILES) $(CODE_FILES) | prepare
	$(LUALATEX) $(LATEX_FLAGS) $(FULL_MAIN)
	$(LUALATEX) $(LATEX_FLAGS) $(FULL_MAIN)

$(OUT_DIR)/%.pdf: $(SRC_DIR)/%.tex $(COMMON_FILES) $(TETELSOR_MAIN) $(BODY_FILES) $(FIGURE_FILES) $(TABLE_FILES) $(CODE_FILES) | prepare
	$(LUALATEX) $(LATEX_FLAGS) $<
	$(LUALATEX) $(LATEX_FLAGS) $<

osszes: $(FULL_COMBINED_PDF)

combined: osszes

figures: $(FIGURES_PDF)

abrak: figures

tables: $(TABLES_PDF)

tablazatok: tables

$(FIGURES_PDF): $(FIGURES_MAIN) $(COMMON_FILES) $(FIGURE_FILES) | prepare
	$(LUALATEX) $(LATEX_FLAGS) $(FIGURES_MAIN)
	$(LUALATEX) $(LATEX_FLAGS) $(FIGURES_MAIN)

$(TABLES_PDF): $(TABLES_MAIN) $(COMMON_FILES) $(TABLE_FILES) | prepare
	$(LUALATEX) $(LATEX_FLAGS) $(TABLES_MAIN)
	$(LUALATEX) $(LATEX_FLAGS) $(TABLES_MAIN)

tetel%: $(OUT_DIR)/zv_tetel_%.pdf
	@:

clean:
	$(CLEAN_TEMP)

distclean: clean
	$(CLEAN_PDF)

list:
	@echo $(PDF_FILES)
	@echo $(TETELSOR_PDF)
	@echo $(FIGURES_PDF)
	@echo $(TABLES_PDF)
	@echo $(FULL_COMBINED_PDF)

help:
	@echo "Gyakori celok:"
	@echo "  make -j$(JOBS) all      - tetelek es tetelsor parhuzamos forditasa"
	@echo "  make fast JOBS=$(JOBS)  - ugyanaz kenyelmi celkent"
	@echo "  make -j$(JOBS) full     - tetelek, tetelsor, abrak, tablazatok es osszesitett PDF"
	@echo "  make osszes             - csak az osszesitett, egybefuzott tetelkidolgozas forditasa"
	@echo "  make tetel05            - csak az 5. tetel forditasa"
	@echo "  make clean              - ideiglenes fajlok torlese"
	@echo "  make distclean          - ideiglenes fajlok es PDF-ek torlese"

.DELETE_ON_ERROR:
.PHONY: all full fast fast-full all-clean full-clean prepare osszes combined figures abrak tables tablazatok clean distclean list help
