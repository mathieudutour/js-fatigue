BIN_DIR ?= node_modules/.bin

BUILD_DIR ?= build
BUILD_TARGET ?= src/
BUILD_FLAGS ?=

BABEL_FLAGS ?=

TEST_TARGET ?= tests/
TEST_FLAGS ?= --require babel-register

P="\\033[34m[+]\\033[0m"

#
# CLEAN
#

clean:
	echo "  $(P) Cleaning"
	rm -rf build/

#
# BUILD
#

build: clean
	echo "  $(P) Building"
	$(BIN_DIR)/babel $(BUILD_TARGET) --out-dir $(BUILD_DIR) $(BABEL_FLAGS)

build-watch: clean
	echo "  $(P) Building forever"
	$(BIN_DIR)/babel $(BUILD_TARGET) --out-dir $(BUILD_DIR) --watch $(BABEL_FLAGS)

#
# TEST
#

lint:
	echo "  $(P) Linting"
	$(BIN_DIR)/eslint $(BUILD_TARGET) && $(BIN_DIR)/eslint $(TEST_TARGET)

test: lint
	echo "  $(P) Testing"
	NODE_ENV=test $(BIN_DIR)/ava $(TEST_TARGET) $(TEST_FLAGS)

test-watch:
	echo "  $(P) Testing forever"
	NODE_ENV=test $(BIN_DIR)/ava --watch $(TEST_TARGET) $(TEST_FLAGS)

#
# MAKEFILE
#

.PHONY: \
	clean \
	build build-watch \
	lint test test-watch

.SILENT:
