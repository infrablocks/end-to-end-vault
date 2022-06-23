resource "sql_migrate" "db" {
  provider = sql.postgres

  migration {
    id = 1
    up = <<SQL
CREATE TABLE vault_kv_store (
  parent_path TEXT COLLATE "C" NOT NULL,
  path        TEXT COLLATE "C",
  key         TEXT COLLATE "C",
  value       BYTEA,
  CONSTRAINT pkey PRIMARY KEY (path, key)
);
SQL

    down = "DROP TABLE IF EXISTS vault_kv_store;"
  }

  migration {
    id = 2
    up = <<SQL
CREATE INDEX parent_path_idx ON vault_kv_store (parent_path);
SQL

    down = "DROP INDEX IF EXISTS parent_path_idx;"
  }

}


