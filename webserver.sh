#!/bin/bash
# replace site1 and site2 with your website.
# use gzip compression and embedded images ftw
mkfifo phil
while (`true`); do sudo nc -w 7 -l -p 80 < phil | grep --line-buffered 'Host: .*' | awk '/site1/ {system("cat site1.bytes"); exit 0}; /site2/ {system("cat site2.bytes"); exit 0} {print "NO THANK YOU"; exit 0; } ' > phil; done
