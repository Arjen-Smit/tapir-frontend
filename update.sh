timestamp=$(date +%s)
ncuOutput=`ncu -u`
npm install
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
  pullrequest=`gh pr create --title "Auto update" --body "$ncuOutput" --assignee Arjen-Smit --head $branch --label "Package update"`

  json=`printf '{ "status":"npm update", "repositoryId": 1, "pullrequestUrl":"%s"}' "$pullrequest"`

  curl -X POST  https://personal-otzwqrko.outsystemscloud.com/Hackathon/rest/hackathon/CreateUpdate \
  -H 'Content-Type: application/json' \
  -d "${json}"

  git checkout master;
  exit
fi


