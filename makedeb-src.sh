#!/bin/bash

for i in common ; do
	PKGNAME=`cat $i/debian_specific/control | grep "Package:" | cut -d" " -f2`
	PKGVER=`cat $i/debian_specific/control | grep "Version:" | cut -d" " -f2`
	PKGARCH=`cat $i/debian_specific/control | grep "Architecture:" | cut -d" " -f2`

	echo $PKGNAME $PKGVER $PKGARCH

	rm -rf tmp
	mkdir -p tmp

	cd $i
	./makedeb-src.sh ../tmp
	cd ..

	exit 0

	##update control
	#mkdir -p tmp/DEBIAN
	#cp $i/debian_specific/control tmp/DEBIAN/control
	#echo "Installed-Size: `du -sk tmp | cut -f1`" >> tmp/DEBIAN/control
	#
	#cp $i/debian_specific/postrm tmp/DEBIAN/postrm

	#dpkg --build tmp/ $PKGNAME-${PKGVER}_$PKGARCH.deb
	cd tmp
	debuild -S
	cd ..

	rm -rf tmp
done

