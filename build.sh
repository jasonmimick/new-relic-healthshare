#!/bin/bash -f
#
# normalize a possibly relative file path
# usage normalize_path <path>
normalize_path()
{
  path=$1
  platform=$(uname)
  if [ $platform == "Darwin" ]; then
    np=$(ruby -e 'puts File.expand_path("'$path'")')
  else
    np=$(readlink -f $path)
  fi
  echo $np
}

# parse ccontrol qlist info
# from install_dir/bin/ccontrol
# and extract the instance name for
# this install_dir
instance_name() {
    install_dir=$1
    ccontrol=$install_dir/bin/ccontrol
    list=`$ccontrol qlist | awk -F\^ '{ print $1"^"$2 }'`
    for config in `echo "$list" | sort`
        do
            instance=`echo $config | cut -d'^' -f1`
            dir=`echo $config | cut -d'^' -f2`
            if [ "$dir" = "$install_dir" ]; then
                echo $instance
                return 1
            fi
        done
    return 0
}

install_dir=$( normalize_path $1)
instance=$( instance_name $install_dir )
csession="$install_dir/bin/csession"
namespace=$2
user=$3
password=$4
source_dir=$( normalize_path ./src ) 
system="\\\$system"
echo install_dir=$install_dir instance=$instance csession=$csession
echo user=$user password=$password source_dir=$source_dir

/usr/bin/expect <<End_Of_Expect
spawn $csession $instance -U $namespace 
expect "Username: " {
        send "$user\r"
}
expect "Password: " {
        send "$password\r"
}
expect "$namespace>" {
		send "do $system.OBJ.ImportDir(\"$source_dir\",\"*.xml\",\"ck\")\r"
        expect "$namespace>"
        send "halt\r"
}

End_Of_Expect

echo ""
