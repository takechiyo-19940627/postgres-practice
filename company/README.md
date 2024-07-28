# postgres-practice
## 1. これは何のためのリポジトリか
Postgresで色々検証するための環境、データを用意するためのリポジトリ

## 2. 初回手順
### 2-1 コンテナの起動
```
$ docker-compose up -d
```

### 2-2 テーブルの準備
#### 2-2-1 コンテナに入る
```
$ docker-compose exec db sh
```

#### 2-2-2 以下のコマンドを実行する
```
$ psql -U postgres -d center < home/sql/create_tables.sql
```

### 2-2-3 テーブルが作成されているか確認
```
# postgresに入る
$ psql -U postgres -d center

# 以下のコマンド実行して意図したテーブルが作成されていたらOK
center=# SELECT * FROM pg_tables WHERE schemaname = 'public';
```

### 2-3 テストデータの投入
```
psql -U postgres -d center < home/sql/seed_companies.sql
psql -U postgres -d center < home/sql/seed_ms_refectures.sql
psql -U postgres -d center < home/sql/seed_employees.sql
```
