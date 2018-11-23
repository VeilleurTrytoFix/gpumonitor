#!/bin/bash
result=$(export DISPLAY=:0 && xhost + > /dev/null && amdconfig --list-adapter)
first=1

echo "{"
echo "\"data\":["



while IFS= read -r line ; do

   index=$(echo -n {"$line"} | cut -c8 )
   gpuuid=$(echo -n {"$line"} | tr -cd '[A-Za-z0-9]')
   #test si index est bien un nombre
   re='^[0-9]+$'
   if [[ $index =~ $re ]] ; then
      if (( "$first" != "1" ))
      then
       echo ,
      fi

      echo -n {"\"{#GPUINDEX}"\":\"$index"\", \"{#GPUUUID}"\":\"$gpuuid\"}
   fi

 if (( "$first" == "1" ))
  then
#    echo ,
    first=0
  fi
done < <(printf '%s\n' "$result")

echo
echo "]"
echo "}"
