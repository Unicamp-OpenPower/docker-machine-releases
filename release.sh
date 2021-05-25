#!/usr/bin/env bash
github_version=$(cat github_version.txt)
edit_github_version="${github_version/-/"."}"
ftp_version=$(cat ftp_version.txt)
LOCALPATH=$GOPATH/src/github.com/docker/machine
BINPATH=$GOPATH/src/github.com/docker/machine/bin

if [ $edit_github_version != $ftp_version ]
then
  git clone https://$USERNAME:$TOKEN@github.com/Unicamp-OpenPower/repository-scrips.git
  cd repository-scrips/
  chmod +x empacotar-deb.sh
  chmod +x empacotar-rpm.sh
  sudo mv empacotar-deb.sh $BINPATH
  sudo mv empacotar-rpm.sh $BINPATH
  cd $BINPATH
  sudo ./empacotar-deb.sh docker-machine docker-machine-v$edit_github_version $edit_github_version " "
  sudo ./empacotar-rpm.sh docker-machine docker-machine-v$edit_github_version $edit_github_version " " "Machine management for a container-centric world"
  if [ $edit_github_version != $ftp_version ]
  then
    lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O /repository/debian/ppc64el/docker/ $BINPATH/docker-machine-$edit_github_version-ppc64le.deb"
    sudo lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O /repository/rpm/ppc64le/docker/ ~/rpmbuild/RPMS/ppc64le/docker-machine-$edit_github_version-1.ppc64le.rpm"
  fi
fi
