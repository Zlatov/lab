# MinIO

## CLI

```bash
wget https://dl.min.io/aistor/mc/release/linux-amd64/mcli_20260312041855.0.0_amd64.deb
sudo dpkg -i mcli_20260312041855.0.0_amd64.deb
mcli --version


mcli alias set zenominio https://minio.example.com:API_PORT ACCESS_KEY SECRET_KEY

mcli mirror zenominio/ilovehobby-staging zenominio/mini-dark-staging
mcli mirror --dry-run zenominio/zenonline-production zenominio/zenonline-staging
mcli mirror --dry-run --remove zenominio/zenonline-production zenominio/zenonline-staging
mcli mirror --dry-run --overwrite --remove --max-workers 16 --quiet zenominio/zenonline-production zenominio/zenonline-staging
mcli mirror --overwrite --remove --max-workers 8 zenominio/zenonline-production zenominio/zenonline-staging
```
