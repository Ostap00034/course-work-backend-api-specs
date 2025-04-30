# Makefile for api-specs: generate Go code from all .proto files

PROTOC     := protoc
PROTO_DIR  := .
PROTO_FILES := $(shell find $(PROTO_DIR) -type f -name '*.proto')

.PHONY: all clean

all: generate

generate:
	@echo "➡ Generating Go code from Protobuf definitions..."
	@for proto in $(PROTO_FILES); do \
		echo "  • $$proto"; \
		$(PROTOC) -I $(PROTO_DIR) $$proto \
			--go_out $(PROTO_DIR) --go_opt paths=source_relative \
			--go-grpc_out $(PROTO_DIR) --go-grpc_opt paths=source_relative; \
	done
	@echo "✅ Generation complete."

clean:
	@echo "🗑 Removing generated files..."
	@find $(PROTO_DIR) -type f \( -name '*.pb.go' -o -name '*_grpc.pb.go' \) -delete
	@echo "✅ Clean complete."
