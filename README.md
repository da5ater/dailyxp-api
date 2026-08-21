# DailyXP API

Public containerized Rails API modular monolith with PostgreSQL. Portable, no AWS dependency.

## Canonical product

Product contract: [DailyXP V1 PRD](https://github.com/da5ater/dailyxp/blob/main/docs/design/dailyxp-v1.md) at `4382b7bcc2b2553cdac15a9c43eed9dfab084d9d`.

## Stack

- Rails 7 API, Ruby 3.4, PostgreSQL 16
- Docker Compose: `api`, `db`, `proxy` (nginx), `mail` (mailcatcher for test)
- Jobs/cache via Solid Queue / Solid Cache (PostgreSQL) – no Redis
- Storage adapter: filesystem (default) or S3-compatible (MinIO) – domain never imports AWS SDK directly
- SMTP: `letter_opener` in dev, `smtp` test adapter

## Prerequisites

- Docker + Compose
- No AWS credentials required for local stack

## Quick start (clean machine)

```sh
cp .env.example .env
docker compose up --build -d
docker compose exec api bin/rails db:prepare
curl http://localhost:3000/health        # => {"status":"ok","version":"1"}
curl http://localhost:3000/api/v1/protocol # => {"version":1,"compatible":true}
docker compose exec api bin/rails test
```

## Adapter config

```sh
# filesystem (default)
STORAGE_ADAPTER=filesystem

# S3-compatible (MinIO)
STORAGE_ADAPTER=s3
S3_ENDPOINT=http://storage:9000
S3_BUCKET=dailyxp
```

Domain code uses `StorageAdapter` interface; `S3Adapter` is only instantiated via config, tests stub the adapter without loading `aws-sdk`.

## Shutdown / migration / backup / restore

```sh
docker compose down              # graceful shutdown, volumes preserved
docker compose exec api bin/rails db:migrate
docker compose exec api bin/rails db:migrate:status
docker compose exec db pg_dump -U dailyxp dailyxp_api_development > backup.sql
docker compose exec db psql -U dailyxp dailyxp_api_development < backup.sql
docker compose exec api bin/rails db:rollback
```

PostgreSQL state is in `pgdata` volume; `docker compose down -v` removes it.

## Health and protocol

- `GET /health` – liveness, no auth, no AWS
- `GET /api/v1/protocol` – versioned protocol fixture shared with `da5ater/dailyxp`

## Cost and portability

Local stack is zero-AWS. See `docs/cost.md`. AWS adapters do not enter domain logic. Portable to home server via same Compose file.

## License

GPL-3.0-or-later
