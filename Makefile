# Makefile — генерация Go-стабов из всех .proto под proto/ в gen/go/

# Путь к protoc
PROTOC    := protoc

# Директории исходников и вывода
PROTO_SRC := proto
PROTO_DST := gen/go

.PHONY: all generate clean

# По умолчанию — генерировать
all: generate

# Генерация Go-кода
generate:
	@echo "➡ Generating Go code from Protobuf definitions..."
	@mkdir -p $(PROTO_DST)
	@find $(PROTO_SRC) -name '*.proto' | while read -r file; do \
		echo "  • $$file"; \
		$(PROTOC) -I $(PROTO_SRC) \
			--go_out=$(PROTO_DST) --go_opt paths=source_relative \
			--go-grpc_out=$(PROTO_DST) --go-grpc_opt paths=source_relative \
			"$$file"; \
	done
	@echo "✅ Generation complete."

# Удаление всех сгенерированных файлов
clean:
	@echo "🗑 Removing generated Go files..."
	@rm -rf $(PROTO_DST)
	@echo "✅ Clean complete."
