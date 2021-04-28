exit 0

# Summary:

# stages all changes
git add -A
# stages new files and modifications, without deletions (on the current directory and its subdirectories).
git add .
# stages modifications and deletions, without new files
git add -u

# Detail:

git add -A
# is equivalent to
git add .; git add -u
