# Postgresの勉強用
## 起動手順
### 1. 起動
- 以下を起動
```
docker-compose up -d
```

### 2. コンテナに入る
```
docker exec -it { container-id } bash
```

### 3. psqlで接続
```
psql -U postgres
```
※ password は postgres

## データの初期導入
※ 起動をしている前提

### 1. テーブル作成
- `dvd-rental-schema.sql` ファイルに記載されているSQLを実行する

### 2. データ作成
- `dvd-rental-sample-data.sql` ファイルに記載されているSQLを実行する