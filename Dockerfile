# マルチステージビルド構成のDockerfile

#============================================================
# Stage1 : go アプリケーションのビルド
#============================================================
FROM golang:1.14 as build

# 作業ディレクトリの作成
WORKDIR /build

# 資材のコピー
COPY . .

# Alpine用の実行ファイルビルド
RUN GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build main.go


#============================================================
# Stage2 : 起動イメージの作成
#============================================================
FROM alpine:3.11

# ビルドした実行ファイルをコピー
COPY --from=build /build/main /usr/local/bin/hands_on_app

RUN ls /usr/local/bin/

# Docker起動時に実行されるコマンド
ENTRYPOINT ["/usr/local/bin/hands_on_app"]