#!/usr/bin/env make
#
# Makefile to work with the repo.
# Build like this:
# - make install
# - make test
# - make build

# ------------------------------------------------------------------------
#
# General stuff, reusable for all Makefiles.
#

# Detect OS
OS = $(shell uname -s)

# Defaults
ECHO = echo

# Make adjustments based on OS
ifneq (, $(findstring CYGWIN, $(OS)))
	OS_CYGWIN = "true"
	ECHO = /bin/echo -e
else ifneq (, $(findstring Linux, $(OS)))
	OS_LINUX = "true"
else ifneq (, $(findstring Darwin, $(OS)))
	OS_MAC = "true"
endif

# Colors and helptext
NO_COLOR	= \033[0m
ACTION		= \033[32;01m
OK_COLOR	= \033[32;01m
ERROR_COLOR	= \033[31;01m
WARN_COLOR	= \033[33;01m

# Print out colored action message
ACTION_MESSAGE = $(ECHO) "$(ACTION)---> $(1)$(NO_COLOR)"

# Which makefile am I in?
WHERE-AM-I = "$(CURDIR)/$(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))"
THIS_MAKEFILE := $(call WHERE-AM-I)

# Echo some nice helptext based on the target comment
HELPTEXT = $(call ACTION_MESSAGE, $(shell egrep "^\# target: $(1) " $(THIS_MAKEFILE) | sed "s/\# target: $(1)[ ]*-[ ]* / /g"))

# Check version  and path to command and display on one line
CHECK_VERSION = printf "%-10s %-20s %s\n" "`basename $(1)`" "`which $(1)`" "`$(1) --version $(2)`"

# Get current working directory, it may not exist as environment variable.
PWD = $(shell pwd)

# target: help                    - Displays help.
.PHONY:  help
help:
	@$(call HELPTEXT,$@)
	@sed '/^$$/q' $(THIS_MAKEFILE) | tail +3 | sed 's/#\s*//g'
	@$(ECHO) "Usage:"
	@$(ECHO) " make [target] ..."
	@$(ECHO) "target:"
	@egrep "^# target:" $(THIS_MAKEFILE) | sed 's/# target: / /g'



# ------------------------------------------------------------------------
#
# Specifics for this project.
#

# Path to source and build libs
BUILD   = build
HTDOCS  = htdocs
SRC     = src

# LESS files and their built respectives.
LESSC			= npx lessc
CSSMINI			= npx clean-css-cli
BUILD_LESS 		=  $(BUILD)/less
SRC_LESS 		=  $(SRC)/less
LESS_SOURCES    = $(wildcard $(SRC_LESS)/*.less)
LESS_CSS        = $(LESS_SOURCES:$(SRC)/less/%.less=$(BUILD_LESS)/css/%.css)
LESS_MIN_CSS    = $(LESS_SOURCES:$(SRC)/less/%.less=$(BUILD_LESS)/css/%.min.css)

# JS files and their built respectives.
JS_LINTER	= npx eslint
JS_MINIFIER	= npx uglify-es
BUILD_JS 	=  $(BUILD)/js
SRC_JS	 	=  $(SRC)/js
JS_SOURCES	= $(wildcard $(SRC_JS)/*.js)
JS_SRC_MIN  = $(JS_SOURCES:$(SRC_JS)/%.js=$(BUILD_JS)/%.min.js)

# HTML files
HTML_LINT 		= npx htmlhint
HTML_SOURCES	= $(SRC) $(HTDOCS)
#HTML_SOURCES	= $(wildcard $(SRC)/*.html $(HTDOCS)/*.html)

# JS lib files to include in bundle
JS_TARGET			= html-slideshow.bundle.min.js
JS_TARGET_SOURCES 	= $(wildcard $(SRC_JS)/lib/*.js) $(JS_SRC_MIN)

# CSS lib files to include in bundle
CSS_TARGET			= html-slideshow.bundle.min.css
CSS_TARGET_SOURCES 	= $(wildcard $(SRC)/css/lib/*.css) $(LESS_MIN_CSS)




# ------------------------------------------------------------------------
#
# General and combined targets
#

# target: all                     - Default target
all: help
	@$(call HELPTEXT,$@)



# target: install                 - Install what is needed
install:
	@$(call HELPTEXT,$@)
	npm install



# target: prepare                 - Prepare to build
prepare:
	@$(call HELPTEXT,$@)
	@install -d $(BUILD_LESS)/css
	@install -d $(BUILD_JS)



# target: build                   - Build all target files
build: less js bundle
	@$(call HELPTEXT,$@)



# target: test                    - Execute all tests and linters
test: less-lint js-lint html-lint
	@$(call HELPTEXT,$@)



# target: clean                   - Removes generated build files.
clean:
	@$(call HELPTEXT,$@)
	rm -rf build



# target: clean-all               - Removes installed utilities.
clean-all: clean
	@$(call HELPTEXT,$@)
	rm -rf node_modules



# target: linter-fix              - Use linters to fix codestyle.
linter-fix: linter-fix
	@$(call HELPTEXT,$@)
	$(JS_LINTER) $(JS_SOURCES) --fix



# ------------------------------------------------------------------------
#
# Bundler.
#
# target: bundle                  - Bundle all the files as a target.
bundle: bundle-js bundle-css
	@$(call HELPTEXT,$@)
	rsync -a $(BUILD_LESS)/$(CSS_TARGET) $(HTDOCS)/css/$(CSS_TARGET)
	rsync -a $(BUILD_JS)/$(JS_TARGET) $(HTDOCS)/js/$(JS_TARGET)



# target: bundle-css              - Bundle the CSS files as a target.
bundle-css:
	@$(call HELPTEXT,$@)
	cat $(CSS_TARGET_SOURCES) > $(BUILD_LESS)/$(CSS_TARGET)
	$(CSSMINI) $(BUILD_LESS)/$(CSS_TARGET) > /tmp/mini.css
	mv /tmp/mini.css $(BUILD_LESS)/$(CSS_TARGET)



# target: bundle-js               - Bundle the JavaScript files as a target.
bundle-js:
	@$(call HELPTEXT,$@)
	cat $(JS_TARGET_SOURCES) > $(BUILD_JS)/$(JS_TARGET)



# ------------------------------------------------------------------------
#
# LESS.
#
# target: less                    - Compile the LESS stylesheet(s).
less: prepare less-css less-min-css
	@$(call HELPTEXT,$@)
	rsync -a $(BUILD_LESS)/css/html-slideshow.min.css $(HTDOCS)/css

less-css: $(LESS_CSS)
less-min-css: $(LESS_MIN_CSS)

$(BUILD_LESS)/css/%.css: $(SRC_LESS)/%.less
	@$(call ACTION_MESSAGE,$< -> $@)
	$(LESSC) --include-path=$(SRC_LESS) $< $@

$(BUILD_LESS)/css/%.min.css: $(SRC_LESS)/%.less
	@$(call ACTION_MESSAGE,$< -> $@)
	$(LESSC) --include-path=$(SRC_LESS) --clean-css $< $@
	$(CSSMINI) $@ > /tmp/mini.css
	mv /tmp/mini.css $@

# target: less-lint               - Lint the LESS stylesheet(s).
less-lint: $(LESS_SOURCES)
	@$(call HELPTEXT,$@)
	@for file in $(LESS_SOURCES); do \
		$(ECHO) " $$file"; \
		$(LESSC) --include-path=$(SRC_LESS) --lint $$file; \
	done



# ------------------------------------------------------------------------
#
# JavaScript.
#
# target: js                      - Compile and minify JavaScript.
js: prepare js-min
	@$(call HELPTEXT,$@)
	rsync -a $(BUILD_JS)/html-slideshow.min.js $(HTDOCS)/js

# target: js-min                  - Minify JavaScript.
js-min: $(JS_SRC_MIN)
	@$(call HELPTEXT,$@)

$(BUILD_JS)/%.min.js: $(SRC_JS)/%.js
	@$(call ACTION_MESSAGE,$< -> $@)
	$(JS_MINIFIER)  $< --output $@

# target: js-lint                 - Lint JavaScript.
js-lint: $(JS_SOURCES)
	@$(call HELPTEXT,$@)
	$(JS_LINTER) $(JS_SOURCES)




# ------------------------------------------------------------------------
#
# HTML
#
# target: html-lint               - Lint HTML files
html-lint: $(HTML_SOURCES)
	@$(call HELPTEXT,$@)
	$(HTML_LINT) $(HTML_SOURCES)
