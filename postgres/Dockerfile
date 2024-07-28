# ベースイメージとしてUbuntuを使用
FROM ubuntu:20.04

# 環境変数を設定してデフォルト値を提供
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# 必要なパッケージをインストール
RUN apt-get update && apt-get install -y \
    build-essential \
    libreadline-dev \
    zlib1g-dev \
    flex \
    bison \
    libxml2-dev \
    libxslt-dev \
    libssl-dev \
    libxml2-utils \
    xsltproc \
    wget \
    git \
    locales \
    tzdata \
    nano \
    vim
  
# 利用可能なロケールを確認
RUN locale -a

# en_US.UTF-8 ロケールを生成
RUN locale-gen en_US.UTF-8

# ロケールを設定
RUN update-locale LANG=en_US.UTF-8 LANGUAGE=en_US:en

# 設定されたロケールを確認
RUN locale

# タイムゾーンを設定
RUN ln -fs /usr/share/zoneinfo/UTC /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

# Postgresのソースコードをダウンロードしてビルド
ENV PG_VERSION=14.5
RUN wget https://ftp.postgresql.org/pub/source/v${PG_VERSION}/postgresql-${PG_VERSION}.tar.gz && \
    tar -xzf postgresql-${PG_VERSION}.tar.gz && \
    cd postgresql-${PG_VERSION} && \
    ./configure --prefix=/usr/local/pgsql && \
    make && \
    make install && \
    cd .. && \
    rm -rf postgresql-${PG_VERSION}*

# 環境変数を設定
ENV PATH /usr/local/pgsql/bin:$PATH
ENV PGDATA /var/lib/postgresql/data

# PostgreSQLユーザーを作成
RUN useradd -ms /bin/bash postgres

# 必要なディレクトリを作成し、所有者を変更
RUN mkdir -p /var/lib/postgresql/data && \
    chown -R postgres:postgres /var/lib/postgresql && \
    chmod 700 /var/lib/postgresql/data

# スクリプトをコピー
COPY start_postgres.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start_postgres.sh

# PostgreSQLユーザーに切り替え
USER postgres

# コンテナ起動時に実行するコマンド
CMD ["/usr/local/bin/start_postgres.sh"]
