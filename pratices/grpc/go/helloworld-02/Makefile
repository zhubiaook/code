gen:
	protoc --proto_path=proto --go_out=plugins=grpc:. proto/*.proto

clean:
	rm pb/*go

server:
	go run cmd/server/main.go

client:
	go run cmd/client/main.go
