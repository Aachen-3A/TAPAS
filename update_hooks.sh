# first get th dir where the install script is placed
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

RepoArray=( libs3a tools3a PxlAnalyzer PxlSkimmer PlotLib)
for repo in "${RepoArray[@]}"
do
  echo ${repo}
  hookdir=$DIR/${repo}/hooks
  #echo $hookdir
  if [ -d $hookdir ]; then
    cd $hookdir
    git pull
    cd $DIR
  else
    echo 'no hooks folder in repo' ${repo}
  fi
done
echo 'Finished pulling latests version of githookcontroller in all repos'
