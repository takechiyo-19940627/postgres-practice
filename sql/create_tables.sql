CREATE TABLE IF NOT EXISTS ms_prefectures (
  id integer primary key,
  name varchar(10) not null,
  created_at timestamp,
  updated_at timestamp,
  deleted_at timestamp
);

CREATE TABLE IF NOT EXISTS companies (
  id integer primary key,
  name varchar(255) not null,
  ms_prefecture_id integer not null,
  created_at timestamp,
  updated_at timestamp,
  deleted_at timestamp,

  foreign key (ms_prefecture_id) references ms_prefectures(id)
);

CREATE TABLE IF NOT EXISTS employees (
  id integer primary key,
  name varchar(255) not null,
  company_id integer not null,
  created_at timestamp,
  updated_at timestamp,
  retired_at timestamp,
  deleted_at timestamp,

  foreign key (company_id) references companies(id)
)
