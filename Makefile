# ==========================
# Project configuration
# ==========================
PROJECT_NAME := MyProject.exe
VERSION      := 1.0
SRC_DIR      := src
BUILD_DIR    := build
INCLUDE_DIR  := include
LIB_DIR      := lib
BIN          := $(BUILD_DIR)/$(PROJECT_NAME)

RUNTIME_DIR  := runtime

# ==========================
# Compiler and flags
# ==========================
CFLAGS  := -MMD -MP -g -I./$(INCLUDE_DIR)
LDFLAGS := -L./$(LIB_DIR)

LDFLAGS += -lcurl
# ==========================
# Source and object files
# ==========================
SRC          := $(wildcard $(SRC_DIR)/*.c)
INCLUDE_SRC  := $(shell find $(INCLUDE_DIR) -name '*.c' 2>/dev/null)

OBJ          := $(patsubst $(SRC_DIR)/%.c,$(BUILD_DIR)/src/%.o,$(SRC))
INCLUDE_OBJ  := $(patsubst $(INCLUDE_DIR)/%.c,$(BUILD_DIR)/include/%.o,$(INCLUDE_SRC))

# ==========================
# Build rules
# ==========================
all: $(BIN)

$(BIN): $(OBJ) $(INCLUDE_OBJ) | $(BUILD_DIR)
	@echo "🔧 Linking $@"
	gcc $(OBJ) $(INCLUDE_OBJ) -o $@ $(LDFLAGS)

$(BUILD_DIR)/src/%.o: $(SRC_DIR)/%.c | $(BUILD_DIR)
	@mkdir -p $(dir $@)
	@echo "🧩 Compiling $<"
	gcc $(CFLAGS) -c $< -o $@

$(BUILD_DIR)/include/%.o: $(INCLUDE_DIR)/%.c | $(BUILD_DIR)
	@mkdir -p $(dir $@)
	@echo "📚 Compiling library $<"
	gcc $(CFLAGS) -c $< -o $@

$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)

# ==========================
# Dependency handling
# ==========================
-include $(OBJ:.o=.d)
-include $(INCLUDE_OBJ:.o=.d)

# ==========================
# Convenience targets
# ==========================
run: $(BIN)
	@echo "🚀 Running $(BIN)"
	cp ./$(RUNTIME_DIR)/* $(BUILD_DIR)
	./$(BIN)

clean:
	@echo "🧹 Cleaning..."
	rm -rf $(BUILD_DIR)

.PHONY: all clean run
