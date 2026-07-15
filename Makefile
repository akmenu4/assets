# SPDX-License-Identifier: 0BSD
# SPDX-FileCopyrightText: 2026 lifehackerhansol

ASSETS_DIR	?= $(CURDIR)
ASSETS_DEST	?= $(ASSETS_DIR)/out

SRC_DIR_LANG	:=	$(ASSETS_DIR)/language
SRC_FILES_LANG	:=	$(shell find $(SRC_DIR_LANG) -type f)
SRC_DIR_UI		:=	$(ASSETS_DIR)/ui
SRC_FILES_UI	:=	$(shell find $(SRC_DIR_UI) -type f)
SRC_DIR_FONTS	:=	$(ASSETS_DIR)/fonts
SRC_BDFFILES	:=	$(shell find $(SRC_DIR_FONTS) -type f -name "*.bdf")

DST_LANG 		:= $(patsubst $(SRC_DIR_LANG)/%,$(ASSETS_DEST)/language/%,$(SRC_FILES_LANG))
DST_UI 			:= $(patsubst $(SRC_DIR_UI)/%,$(ASSETS_DEST)/ui/%,$(SRC_FILES_UI))
DST_PCFFILES	:=	$(patsubst $(SRC_DIR_FONTS)/%.bdf,$(ASSETS_DEST)/fonts/%.pcf,$(SRC_BDFFILES))

.PHONY:	assets

assets: $(DST_LANG) $(DST_UI) $(DST_PCFFILES)

$(ASSETS_DEST)/language/%: $(SRC_DIR_LANG)/%
	@echo "  CP    $<"
	@mkdir -p $(dir $@)
	@cp -R $< $@

$(ASSETS_DEST)/ui/%: $(SRC_DIR_UI)/%
	@echo "  CP    $<"
	@mkdir -p $(dir $@)
	@cp -R $< $@

$(DST_PCFFILES):	$(SRC_BDFFILES)
	@echo "  BDFTOPCF $<"
	@mkdir -p $(dir $@)
	@bdftopcf -p1 -l -L $< -o $@
