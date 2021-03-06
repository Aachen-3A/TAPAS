#!/bin/bash
##
## bootstrap_tapas.sh
## 
## Copyright 2015 Tobias Pook <pook <at> physik.rwth-aachen.de>
## 
## This script sets up the TAPAS framework
##
## LICENSE
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program; if not, write to the Free Software
## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
## MA 02110-1301, USA.

echo "usage "$0 "[options]"
echo "Options"
echo "-d dir - Optional path where to install repos"
echo "-p plotting - Veto libraries for plotting"
echo "-a analyze - Veto libraries pxlAnalyzer"
echo "-s skim - Veto libraries for skimming"

# parse command line option
dir=`pwd`

analyze=0
skim=0
plotting=0

while getopts "aspd:" opt; do
  case $opt in
    a)
      analyze=1 >&2
      ;;
    s)
      skim=1 >&2
      ;;
    p)
      plotting=1 >&2
      ;;
    d)
      $dir=$OPTARG >&2
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done

## start to create custom set_env
pwd=`pwd`
echo $pwd

# create set_env
echo "# This is a TAPAS set_env script. Source it before usage of TAPAS \n" > setenv_tapas.sh
echo '# make sure a git version above 1.8.1 is used. This is necessary for all hooks to work.' >> setenv_tapas.sh
echo "export TAPASDOC=$pwd/doc/" >> setenv_tapas.sh
source ./setenv_tapas.sh
echo '# make sure a git version above 1.8.1 is used. This is necessary for all hooks to work.' >> setenv_tapas.sh
echo '#alternative git version' >> setenv_tapas.sh
echo 'ALTGIT=/cvmfs/cms.cern.ch/slc6_amd64_gcc481/external/git/1.8.3.1-cms/bin/' >> setenv_tapas.sh
echo 'if [[ ":$PATH:" == *":$ALTGIT:"* ]]; then' >> setenv_tapas.sh
echo 'echo "git 1.8.3 already in path"' >> setenv_tapas.sh
echo 'else' >> setenv_tapas.sh
echo 'export PATH=$ALTGIT:$PATH' >> setenv_tapas.sh
echo 'fi' >> setenv_tapas.sh

echo '#################################'
echo '### clone all requested repos ###'
echo '#################################'

# get libs tools and doc repo, always needed

git clone git@github.com:Aachen-3A/TapasDoc.git doc
#make sure the gh-pages branch is used
cd ./doc/
git checkout gh-pages
cd $pwd


git clone git@github.com:Aachen-3A/libs3a.git $dir/libs3a
cd $dir/libs3a
git checkout -b dev origin/dev
git checkout master
chmod u+x setup.sh
./setup.sh
source set_env.sh
cd $dir
echo "source $dir/libs3a/set_env.sh" >> setenv_tapas.sh

git clone git@github.com:Aachen-3A/tools3a.git $dir/tools3a
cd $dir/tools3a
git checkout -b dev origin/dev
git checkout master
chmod u+x setup.sh
./setup.sh
source set_env.sh
cd $dir
echo "source $dir/tools3a/set_env.sh" >> setenv_tapas.sh


#get othe repos without veto
if [ $analyze -eq 0 ]; then
    git clone git@github.com:Aachen-3A/PxlAnalyzer.git $dir/PxlAnalyzer
    echo "source $dir/PxlAnalyzer/set_env.sh" >> setenv_tapas.sh
    cd $dir/PxlAnalyzer
    git checkout -b dev origin/dev
    git checkout master
    cd $dir
fi

if [ $plotting -eq 0 ]; then
    git clone git@github.com:Aachen-3A/PlotLib.git $dir/PlotLib
    echo "source $dir/PlotLib/set_env.sh" >> setenv_tapas.sh
    cd $dir/PxlAnalyzer
    git checkout -b dev origin/dev
    git checkout master
    cd $dir
fi

if [ $skim -eq 0 ]; then
    git clone git@github.com:Aachen-3A/PxlSkimmer.git $dir/PxlSkimmer
    cd $dir/PxlSkimmer
    git checkout -b dev origin/dev
    git checkout master
    source $dir/PxlSkimmer/bootstrap_PxlSkimmer.sh
    echo "source $dir/PxlSkimmer/set_env.sh" >> setenv_tapas.sh
    cd $dir
fi



echo '#################################'
echo '### Finished installation     ###'
echo '#################################' 

echo 'TAPAS has been successfully installed'
echo 'Remember to always source the script setenv_tapas.sh before using the Framework'
