# TAPAS
Three A Physics Analysis Software

##Setup Tapas
Clone the Tapas repository, which contains the script bootstrap_tapas.sh. You can simply run this script to install TAPAS with all parts:
* libs3a ( Common libs for framework )
* tools3a ( Common tools for framework )
* PlotLib ( Ploting lib for custom plotting apps )
* PxlSkimmer ( Skimmer which prepares data as provided by CMS in pxlio file )
* PxlAnalyzer ( Basic machinery to run Analysis on skimmed files. You can implement your own Analysis as a SpecialAna here )

Maybe you need to generate an SSH-Key and add it to your GitHub-Account (see https://help.github.com/articles/generating-ssh-keys/)


### Installing only parts of TAPAS
Only libs and tools repos are mandatory for the framework. You can call the bootstrap script with veto flags if you do not want to install a part, flags:
* -p no PlotLib
* -s no PxlSkimmer
* -a no PxlAnalyzer

##Using TAPAS
Each repository contains a set_env script which you should source before using it. To make your live easier
TAPAS creates a script called setenv_tapas.sh when you run the inital setup script. You simply need to source this script and set_env scripts in all installed repos will also be sourced. The setenv_tapas.sh script also includes a necessary change of the used git version for "modern" hooks on the Aachen cluster. You may add this line in your .bashrc if you use only parts of TAPAS.

## Contributing to TAPAS 
TAPAS consists of several repos but the basic guidelines for contributions are very general.

### Coding style
Please try to produce readable code. Have a look at the other code in the repo or additional guidlines in the repository wikis to get a idea what is expected.

### Git workflow
The standard workflow assumes that you created a local branch from the dev branch and work in it until you are ready to push your changes. To do so change to the dev branch and pull to make sure your local dev branch is up to date. The next step is to merge your feature branch in to dev:

$git checkout dev

$git merge YOURBRANCH

It is possible that you need to resolve merge conflicts between your changes and the changes in dev which were added since you started working on your own branch. After resolving all conflics, the last step is to push your changes to github:

$git push origin dev

The merge procedure from the dev to master branch differs for the TAPAS repos and is documented in each individual repository.  
### Preparig your commit
It is uesful to follow some guidelines for commits in order to make the structured and understandable for other contributors:

* **Avoid using the -a option for git commit.** It may seem handy when you use it but this option often leads to commits with changes unrelated to the commit message and other code changes.
* **Use the -p option for git add.** This option lets you toogle your code changes interactivly and you decide for each piece of code if it is added to the next commit. Lets suppose you worked on several problems at the same time in your code and want to seperate changes in several commits with different topics. Simply add all files with the -p option and accept only changes related to one topic and commit only the staged changes with an appropriate commit message (see below). Repeat this procedure until all changes are added and commited.
* **Create meaningful commit messages.** Your commit message should explain all changes in your commit. The length of the commit message should scale with the severity of the changes and the number of changed lines. One line commit messages are in general only allowed if only one line of code is changed. If you change more code your commit message should at least contain: the motivation for the changes, the idea behind your changes and possible resources you used (e.g. new recomendations by CMS twiki pages).
* **(Advanced) Restructure your local commits with git rebase -i**. This command lets you reorder change and sqash your commits. ** Always make sure not to rebase already pushed changes ! **
