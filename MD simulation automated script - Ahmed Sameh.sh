#!/bin/bash

# This script tends to run an automated energy minimzation (EM) for a set of proteins in a specific folder, or at once. 

#Firstly, before starting any procedure, GROMACS needs to be activated so that you can use its command.
source /usr/local/gromacs/bin/GMXRC

#Checking for the format of the input file.
echo "Enter the path of the protein you wish to under go the procedure (note: its prefered if this protein is alone in a specified directory)"
read A
echo "Your input path in which the protein is present is $A"
echo "-----------------------------------------------------------------"
echo "Enter the name of your protein with the extension, example: example_protein.pdb (the protein should be in .pdb extention)"
read B
cd $A
case "$B" in
  *.pdb )
    echo "file is in correct format, process will proceed right away" ;;
  * )
    echo "ERROR, file is not in .pdb extension"
    exit ;;
esac
echo "==================================================================="

#Removing crystal waters from the protein
echo "Protein $B will undergo process of crystal water removal"
echo "A new pdb file will be created, this new pdb file is the same as the one you entered but without waters"
#read file_name
#case "$file_name" in
#  *.pdb )
#    echo "file is in correct format, process will proceed right away" ;;
#  * )
#    echo "ERROR, file is not in .pdb extension"
#    exit ;;
#esac

grep -v HOH $B > nowater.pdb
echo "The new created file is called nowater.pdb"
echo "==================================================================="

#Pdb2gmx step, in which the pdb file is used to generate 3 files, topolgy file for the molecule, A position restraint file, and a processed structure file.
echo "nowater.pdb will undergo the process right away to generate the .gro file"
#echo "Enter the name of the processed file as you wish to name it in .gro format"
#read processed
#case "$processed" in
#  *.gro )
#    echo "file is in correct format, process will proceed right away" ;;
#  * )
#    echo "ERROR, file is not in .gro extension"
#    exit ;;
#esac
for file in $A
do 
  cd $A
  gmx pdb2gmx -f nowater.pdb -o processed_pdb2gmx_step.gro -ff charmm36 -water tip3p
#  gmx editconf -f tauf.pdb  -o processed_pdb2gmx_step.gro
  echo "The selected forcefield is CHARRMM36"
  echo "The generated files are called topol.top and processed_pdb2gmx_step.gro"
done
echo "==================================================================="

#Solvation step, which is to choose the medium to simulate the protein in a medium like brain.
#Firstly, we define the box dimensions.
echo "processed_pdb2gmx_step.gro file will undergo the process to set the dimensions of the solvation box"
#echo "Enter the name of the output file in .gro format"
#read box
#case "$box" in
#  *.gro )
#    echo "file is in correct format, process will proceed right away" ;;
#  * )
#    echo "ERROR, file is not in .gro extension"
#    exit ;;
#esac
gmx editconf -f processed_pdb2gmx_step.gro -o defined_box.gro -c -d 1.0 -bt cubic
echo "The new created file is called defined_box.gro"
echo "======================================================================="

#Secondly,we create the solvation box using the sepcified solvation file
echo "solvated_box.gro will undergo the process of solvatio right away"
#echo "Enter the name of the output solvated file in .gro extention"
#read solv
gmx solvate -cp defined_box.gro -cs spc216.gro -o solvated_box.gro -p topol.top 
echo "The output file is called solvated_box.gro"
echo "================================================================================"

#Next step is addig ions.
echo "Now with the process of adding ions"
echo "Firstly a .mdp file, called ions.mdp, will be downloaded containing the whole info about the used ions"
#wget https://osf.io/5vfeh/
#echo "A .tpr file then will be genrated called ions.tpr"
#read v
gmx grompp -f ions.mdp -c solvated_box.gro -p topol.top -o ions.tpr -maxwarn 1
##echo "ions.tpr is generated" 
##echo "Now we have an atomic-level description of our system in the binary file ions.tpr. We will pass this file to the genion command"
gmx genion -s ions.tpr -o solvated_box_with_ions.gro -p topol.top -pname SOD -nname CLA -neutral -conc 0.15
##echo "Now a file called solvated_box_with_ions.gro is created and will undergo final step which is energy minimzation"
##echo "================================================================================"

#Energy minimization step now will proceed.
##echo "Firstly, minim.mdp file will be installed containing the parametrs that accordingly will initiate the energy minimzation step"
#wget http://www.mdtutorials.com/gmx/lysozyme/Files/minim.mdp
#echo "Enter file format in .tpr extension"
#read yalahwy
gmx grompp -f minim.mdp -c solvated_box_with_ions.gro -p topol.top -o em.tpr -maxwarn 1 
echo "A new file is generated called em.tpr, which is the file accordingly energy minimization will occur"
#Now with the MD step to initiate Energy MInimzation
gmx mdrun -v -deffnm em

#Equillibrium step
#wget http://www.mdtutorials.com/gmx/lysozyme/Files/nvt.mdp
gmx grompp -f nvt.mdp -c em.gro -r em.gro -p topol.top -o nvt.tpr -maxwarn 1
gmx mdrun -deffnm nvt

#part 2
gmx grompp -f npt.mdp -c nvt.gro -r nvt.gro -t nvt.cpt -p topol.top -o npt.tpr -maxwarn 1
gmx mdrun -deffnm npt

#MD production
#wget http://www.mdtutorials.com/gmx/lysozyme/Files/md.mdp
gmx grompp -f md.mdp -c npt.gro -t npt.cpt -p topol.top -o md_0_1.tpr


#Now MD run
gmx mdrun -deffnm md_0_1




#echo "Enter your path you idiot"
#read reply
#echo "your path is $reply"

#echo "Enter the protein you wish for to undergo the procedure, idiot"
#read enter

#for pdb in reply
#do
#  cd $reply
#  gmx grompp -f minim.mdp -c 1AKI_solv_ions.gro -p $enter -o yalahwy.tpr
#  echo "yalahwy"
#done


