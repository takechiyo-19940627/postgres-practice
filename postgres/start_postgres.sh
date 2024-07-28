#!/bin/bash

# クラスタの数を指定（例：2）
CLUSTER_COUNT=2

# 各クラスタを初期化して起動
for i in $(seq 1 $CLUSTER_COUNT); do
    CLUSTER_PATH="$PGDATA/cluster$i"
    
    if [ ! -d "$CLUSTER_PATH" ]; then
        echo "Initializing cluster $i..."
        initdb --locale=en_US.UTF-8 --encoding=UTF8 -D "$CLUSTER_PATH"
        
        # ポート番号を設定（5432, 5433, ...）
        PORT=$((5431 + i))
        echo "port = $PORT" >> "$CLUSTER_PATH/postgresql.conf"
    fi
    
    echo "Starting cluster $i..."
    pg_ctl -D "$CLUSTER_PATH" -l "$CLUSTER_PATH/logfile" start
done

# コンテナを起動したままにする
echo "All clusters started. Keeping container running..."
tail -f /dev/null