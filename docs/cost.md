# Cost

Local stack: $0 (Docker, Postgres). No AWS.

100 users: ~$0 (same Compose, vertical).
1000 users: resize Lightsail 2GB -> 4GB or split workers only when measured; still $0 locally.

Cheaper alternative: keep filesystem adapter, no S3, no Redis.
