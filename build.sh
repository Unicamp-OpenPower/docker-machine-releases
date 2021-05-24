github_version=$(cat github_version.txt)
#ftp_version=$(cat ftp_version.txt)
ftp_version=0.16.2-gitlab.11
del_version=$(cat delete_version.txt)

if [ $github_version != $ftp_version ]
then
  cd $GOPATH
  mkdir -p src/github.com/docker/
  cd src/github.com/docker/
  git clone https://gitlab.com/gitlab-org/ci-cd/docker-machine.git
  mv docker-machine machine
  rm machine/mk/build.mk
  cd machine/mk/
  wget https://raw.githubusercontent.com/Unicamp-OpenPower/docker-machine-build/main/build.mk
  ls
  cd ..
  TARGET_OS=linux TARGET_ARCH=ppc64le make build-x
  cd bin
  ls
  ./docker-machine-Linux-ppc64le --version
  mv docker-machine-Linux-ppc64le docker-machine-v$github_version-ppc64le

  #lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; rm /ppc64el/docker-machine/latest/docker-machine-v$ftp_version-ppc64le"
  #lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O /ppc64el/docker-machine/latest docker-machine-v$github_version-ppc64le"
  lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O /ppc64el/docker-machine docker-machine-v$github_version-ppc64le"
  #lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; rm /ppc64el/docker-machine/docker-machine-v$del_version-ppc64le"
fi
