SRC_DIR := src
FIGURES_DIR := $(SRC_DIR)/figures
TABLES_DIR := $(SRC_DIR)/tables
OUT_DIR := output
LUALATEX := lualatex
LATEX_FLAGS := -interaction=nonstopmode -halt-on-error -output-directory=$(OUT_DIR)

TETEL_FILES := $(wildcard $(SRC_DIR)/zv_tetel_*.tex)
TETELSOR_MAIN := $(SRC_DIR)/zv_tetelsor.tex
TEX_FILES := $(TETEL_FILES) $(TETELSOR_MAIN)
COMMON_FILES := $(filter-out $(TEX_FILES),$(wildcard $(SRC_DIR)/*.tex))
FIGURES_MAIN := $(FIGURES_DIR)/zv_abrak.tex
FIGURE_FILES := $(filter-out $(FIGURES_MAIN),$(wildcard $(FIGURES_DIR)/*.tex))
TABLES_MAIN := $(TABLES_DIR)/zv_tablazatok.tex
TABLE_FILES := $(filter-out $(TABLES_MAIN),$(wildcard $(TABLES_DIR)/*.tex))
PDF_FILES := $(patsubst $(SRC_DIR)/%.tex,$(OUT_DIR)/%.pdf,$(TEX_FILES))
TETELSOR_PDF := $(OUT_DIR)/zv_tetelsor.pdf
FIGURES_PDF := $(OUT_DIR)/zv_abrak.pdf
TABLES_PDF := $(OUT_DIR)/zv_tablazatok.pdf

ifeq ($(OS),Windows_NT)
MKDIR_OUT = if not exist "$(OUT_DIR)" mkdir "$(OUT_DIR)"
CLEAN_TEMP = -del /Q /F "$(OUT_DIR)\*.aux" "$(OUT_DIR)\*.log" "$(OUT_DIR)\*.out" "$(OUT_DIR)\*.toc" "$(OUT_DIR)\*.fls" "$(OUT_DIR)\*.fdb_latexmk" "$(OUT_DIR)\*.synctex.gz" "$(OUT_DIR)\*.bbl" "$(OUT_DIR)\*.bcf" "$(OUT_DIR)\*.blg" "$(OUT_DIR)\*.run.xml" "$(OUT_DIR)\*.lof" "$(OUT_DIR)\*.lot" "$(OUT_DIR)\*.lol" "$(OUT_DIR)\*.idx" "$(OUT_DIR)\*.ilg" "$(OUT_DIR)\*.ind" 2>NUL
CLEAN_PDF = -del /Q /F "$(OUT_DIR)\*.pdf" 2>NUL
else
MKDIR_OUT = mkdir -p "$(OUT_DIR)"
CLEAN_TEMP = rm -f "$(OUT_DIR)"/*.aux "$(OUT_DIR)"/*.log "$(OUT_DIR)"/*.out "$(OUT_DIR)"/*.toc "$(OUT_DIR)"/*.fls "$(OUT_DIR)"/*.fdb_latexmk "$(OUT_DIR)"/*.synctex.gz "$(OUT_DIR)"/*.bbl "$(OUT_DIR)"/*.bcf "$(OUT_DIR)"/*.blg "$(OUT_DIR)"/*.run.xml "$(OUT_DIR)"/*.lof "$(OUT_DIR)"/*.lot "$(OUT_DIR)"/*.lol "$(OUT_DIR)"/*.idx "$(OUT_DIR)"/*.ilg "$(OUT_DIR)"/*.ind
CLEAN_PDF = rm -f "$(OUT_DIR)"/*.pdf
endif

all: prepare $(PDF_FILES)
	$(MAKE) clean

prepare:
	$(MKDIR_OUT)

$(OUT_DIR)/%.pdf: $(SRC_DIR)/%.tex $(COMMON_FILES) $(TETELSOR_MAIN) $(FIGURE_FILES) $(TABLE_FILES) | prepare
	$(LUALATEX) $(LATEX_FLAGS) $<
	$(LUALATEX) $(LATEX_FLAGS) $<

figures: prepare $(FIGURES_PDF)
	$(MAKE) clean

abrak: figures

tables: prepare $(TABLES_PDF)
	$(MAKE) clean

tablazatok: tables

$(FIGURES_PDF): $(FIGURES_MAIN) $(COMMON_FILES) $(FIGURE_FILES) | prepare
	$(LUALATEX) $(LATEX_FLAGS) $(FIGURES_MAIN)
	$(LUALATEX) $(LATEX_FLAGS) $(FIGURES_MAIN)

$(TABLES_PDF): $(TABLES_MAIN) $(COMMON_FILES) $(TABLE_FILES) | prepare
	$(LUALATEX) $(LATEX_FLAGS) $(TABLES_MAIN)
	$(LUALATEX) $(LATEX_FLAGS) $(TABLES_MAIN)

clean:
	$(CLEAN_TEMP)

distclean: clean
	$(CLEAN_PDF)

list:
	@echo $(PDF_FILES)
	@echo $(TETELSOR_PDF)
	@echo $(FIGURES_PDF)
	@echo $(TABLES_PDF)

.PHONY: all prepare figures abrak tables tablazatok clean distclean list
