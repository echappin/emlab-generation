#!/bin/bash

########################################################################
# The jobname must only consist of the characters A-Z, a-z and 0-9!!!! #
########################################################################
USAGE="Provide name of run and name of scenario file."
#Load configuration script to substitute
if [ -f scriptConfigurations.cfg ];then 
	. scriptConfigurations.cfg
	HOME=$REMOTERESULTFOLDER
else
    echo "Define scriptConfigurations.cfg, by changing the template. Exiting script."
    exit
fi

## the first parameter gives the jobname, the second the scenario-file including the xml file-ending
## Example sh localHeadless.sh example scenarioA-ToyModel.xml
JOBNAME=$1
SCENARIO=$2
SCENARIOPATH=file://$LOCALSCENARIOFOLDER

mkdir $LOCALRESULTFOLDER/$JOBNAME
cd $LOCALRESULTFOLDER/$JOBNAME
for PBS_ARRAYID in {1..1}
do
java -d64 -server -Xmx3072m -Drun.id=$JOBNAME-$PBS_ARRAYID -DSCENARIO_FOLDER=$SCENARIOPATH -Dresults.path=$LOCALRESULTFOLDER/$JOBNAME -Dscenario.file=$SCENARIO -jar $LOCALJARFILE
done
