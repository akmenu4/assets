# SPDX-License-Identifier: 0BSD
# SPDX-FileCopyrightText: 2026 lifehackerhansol

DST_DIR	?= $(CURDIR)/out

SRC_DIR_LANG	:=	$(CURDIR)/language
SRC_FILES_LANG	:=	$(shell find $(SRC_DIR_LANG) -type f)
SRC_DIR_UI		:=	$(CURDIR)/ui
SRC_FILES_UI	:=	$(shell find $(SRC_DIR_UI) -type f)
SRC_DIR_FONTS	:=	$(CURDIR)/fonts
SRC_BDFFILES	:=	$(shell find $(SRC_DIR_FONTS) -type f -name "*.bdf")

DST_LANG 		:= $(patsubst $(SRC_DIR_LANG)/%,$(DST_DIR)/language/%,$(SRC_FILES_LANG))
DST_UI 			:= $(patsubst $(SRC_DIR_UI)/%,$(DST_DIR)/ui/%,$(SRC_FILES_UI))
DST_PCFFILES	:=	$(patsubst $(SRC_DIR_FONTS)/%.bdf,$(DST_DIR)/fonts/%.pcf,$(SRC_BDFFILES))

all: $(DST_LANG) $(DST_UI) $(DST_PCFFILES)

$(DST_DIR)/language/%: $(SRC_DIR_LANG)/%
	@echo "  CP    $<"
	@mkdir -p $(dir $@)
	@cp -R $< $@

$(DST_DIR)/ui/%: $(SRC_DIR_UI)/%
	@echo "  CP    $<"
	@mkdir -p $(dir $@)
	@cp -R $< $@

$(DST_PCFFILES):	$(SRC_BDFFILES)
	@echo "  BDFTOPCF $<"
	@mkdir -p $(dir $@)
	@bdftopcf -p1 -l -L $< -o $@
