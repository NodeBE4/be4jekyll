#!/bin/bash
# function that mirror one repo
# Arguments: 1. url of target repo; 2 local folder
git config --global user.email "becare4@tutanota.com";
git config --global user.name "NodeBE4";
git config --global pull.rebase false;
git lfs install;

checkout () {
  repo_target=$1;
  folder=$2;
  git clone "${repo_target}" "${folder}";
  cd ${folder};
  git lfs pull;
  cd ..;
}

commit_push () {
  folder=$1;
  today=$(date +%FT%T);
  pwd=$(pwd);
  cd ${folder};
  echo "Start to commit ${folder}";
  git remote -v;
  git add . ;
  git commit -m"Update jekyll template ${today}";
  git pull origin master --no-edit;
  git push origin master;
  cd ${pwd};
}



## declare an array variable
declare -a arr=("opinion" "oped2" "waimei"  "society" "teahouse")

## now loop through the above array
for prj in "${arr[@]}"
do
  repo=https://$API_TOKEN_GITHUB@github.com/NodeBE4/${prj}.git;
  folder="${prj}";
  echo "Distribute to project: ${prj}";
  checkout ${repo} ${folder};
  cp -r ./shared/* "${folder}/";
  commit_push ${folder};
  # or do whatever with individual element of the array
done

echo "All done: $(date)"