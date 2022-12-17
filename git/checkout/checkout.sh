exit 0

git fetch
git branch -r
git checkout -b branch_name remote_name/branch_name

# git checkout branch_name
# — не будет работать в современном git, если указано несколько удалённых
# репозиториев, или по другой причине. В этом случае использовать:
git checkout -b branch_name remote_name/branch_name
