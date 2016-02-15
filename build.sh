#!/bin/bash

cd /inasafe
git checkout develop
git fetch
git clean -df
git reset --hard origin/develop
VERSION=`cat metadata.txt | grep ^version | sed 's/version=//g'`
scripts/release.sh
mv /tmp/inasafe.${VERSION}.zip /build
mv /tmp/InaSAFE-${VERSION}-plugin.exe /build
cat /build/header.html > /build/index.html
echo "<p class='text-center'>This is the InaSAFE Nightly Build repo last build at : " >> /build/index.html
date >> /build/index.html
echo "</p><p class='text-center'>Windows installer <a href='/InaSAFE-${VERSION}-plugin.exe'>InaSAFE-${VERSION}-plugin.exe</a></br>" >> /build/index.html
echo "</p><p class='text-center'>Plugin repo: http://nightly.inasafe.org/plugins.xml" >> /build/index.html
echo "</p><p class='text-center'>Usage <a href='https://github.com/AIFDR/inasafe/wiki/Nightly%20Builds'>instructions</a>" >> /build/index.html
echo "</p>" >> /build/index.html
cat /build/footer.html >> /build/index.html
touch /build/index.html
cp /build/plugins.xml.tmpl /build/plugins.xml
rpl "[[VERSION]]" "${VERSION}" /build/plugins.xml
DATE=`date`
rpl "[[DATE]]" "${DATE}" /build/plugins.xml
