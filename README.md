# TAPAS
Three A Physics Analysis Software

##Setup Tapas
Clone the Tapas repository, which contains the script tapas_bootstrap.sh. You can simply run this script to install TAPAS with all parts:
* libs3a ( Common libs for framework )
* tools3a ( Common tools for framework )
* PlotLib ( Ploting lib for custom plotting apps )
* PxlSkimmer ( Skimmer which prepares data as provided by CMS in pxlio file )
* PxlAnalyzer ( Basic machinery to run Analysis on skimmed files. You can implement your own Analysis as a SpecialAna here )

### Installing only parts of TAPAS
Only libs and tools repos are mandatory for the framework. You can call the bootstrap script with veto flags if you do not want to install a part, flags:
* -p no PlotLib
* -s no PxlSkimmer
* -a no PxlAnalyzer

##Using TAPAS
Each repository contains a set_env script which you should source before using it. To make your live easier
TAPAS creates a script called setenv_tapas.sh when you run the inital setup script. You simply need to source this script and set_env scripts in all installed repos will also be sourced. The setenv_tapas.sh script also includes a necessary change of the used git version for "modern" hooks on the Aachen cluster. You may add this line in your .bashrc if you use only parts of TAPAS.
