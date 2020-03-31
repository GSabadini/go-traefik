##########
# STEP 1 #
##########

FROM golang:alpine AS builder

# Definir as variáveis ​​de ambiente necessárias para a imagem
ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

# Definir o diretório de trabalho /build
WORKDIR /build

# Copiar o código para o contêiner
COPY . .

# Buildar o aplicativo
RUN go build -a --installsuffix cgo --ldflags="-s" -o main

# Definir o diretório de trabalho /dist
WORKDIR /dist

# Copiar binário da compilação para a pasta principal (/dist)
RUN cp /build/main .

##########
# STEP 2 #
##########

# Construir uma imagem pequena
FROM scratch

# Copiar o executável
COPY --from=builder /dist/main .

# Comando para executar o binário
ENTRYPOINT ["./main"]

# Porta na qual o serviço será exposto
EXPOSE 8090