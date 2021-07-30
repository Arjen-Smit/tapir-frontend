npm update
timestamp=$(date +%s)
branch=npm-update-$timestamp

if [[ -z $(git status -s) ]]
then
  echo "Nothing to update"
else
  git checkout -b $branch
  git add package.json
  git add package-lock.json
  git commit -m "auto update"
  git push --set-upstream origin $branch
  gh pr create --title "Auto update" --body "We did an update" --assignee Arjen-Smit --head $branch
  exit
fi
