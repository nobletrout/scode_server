#!/bin/bash
# replace site1 and site2 with your website.
# use gzip compression and embedded images ftw
site1="example.com"
site2="example.net"
port=80
rm -f phil
mkfifo phil

if ["$port" -lt "1024"]
then
    dosudo='sudo'
else
    dosudo=''
fi

while (`true`)
  do
  $dosudo nc -w 7 -l -p 80 < phil | grep --line-buffered 'Host: .*' | 
  awk -v site1="$site1" -v site2="$site2" '{ 
                         if (match($0,site1)) 
                            {system("cat site1.bytes"); exit 0} 
                         else if(match($0, site2)) 
                            {system("cat site2.bytes"); exit 0} 
                         else 
                            {print "NO THANK YOU"; exit 0; } 
                         }' > phil
  done
