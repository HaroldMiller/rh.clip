#!/bin/bash 
#    clip version 0.01 Written by Harold Miller - harold@redhat.com
#    Removes lines from (log) text files, to allow the interesting stuff to be visible

keyfile="clip.key"

do_help() {
        echo -e "Clip Version 0.01\n"
        echo -e "Usage: clip [file name]"
        echo -e " or "
        echo -e " clipadd [key term]"
        echo -e " or "
        echo -e " clipclear "
        echo -e " " 
	echo -e " clip [file name]: Deletes lines lines from [file name] that match entries in  clip.key"
        echo -e " "
        echo -e " clipadd [key term]: adds [key term] to the clip.key file"
        echo -e " "
        echo -e " clipclear: removes all lines from the clip.key file"
	exit
          } ;

if [[ $1 == "-h" ]] 
   then 
     do_help;
   fi

if [[ `basename $0` == "clip" && -z $1 ]]
   then
     do_help;
   fi

case `basename $0` in 
   "clip"      )   orig_filename=$1; 
                   working_filename=$1;
                   grepkey="";
                   declare -i j;
                   j=0;
                   while [ 1 ]
                     do
                       read grepkey || break;
                       echo 'grepkey='$grepkey;
                       temp_filename=$orig_filename'.'$j;
                       echo 'temp_filename='$temp_filename;
 #  here is my bug. I need the following line to be executed:
                       grep -v \"$grepkey\" $working_filename > $temp_filename;
                       working_filename=$temp_filename; 
                       j=$j+1;
                     done < $keyfile;;
   "clipadd"    )  echo $1 >> clip.key ;;
   "clipclear"  )  rm clip.key; touch clip.key ;;
esac

