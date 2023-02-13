echo Running MARVeLus CI/CD
./configure
dune build
dune install
cd ./test/marvelus
STR=$(make 2>&1)
SUB='Error'

if [[ ${STR} ]];  then
  echo Error;
  exit 1
fi