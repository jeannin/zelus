echo Running MARVeLus CI/CD
./configure
opam exec -- dune build --root .
opam exec -- dune install --root .
cd ./test/marvelus
STR=$(make 2>&1)
SUB='Error'

if [[ ${STR} ]];  then
  echo Error;
  exit 1
fi