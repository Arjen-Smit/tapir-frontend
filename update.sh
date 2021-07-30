npmUpdate=`npm update`
npmAuditFix=`npm audit fix`
npmAudit=`npm audit`
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
  pullrequest=`gh pr create --title "Auto update" --body "# npm update: $npmUpdate # Audit Fix: $npmAuditFix # after audit: $npmAudit" --assignee Arjen-Smit --head $branch --label "Package update"`

  echo $pullrequest
  exit
fi
