echo Running MARVeLus CI/CD
eval $(opam env)
./configure
opam exec -- dune build @install --root .
# opam exec -- dune install --root .
cd ./test/marvelus
STR=$(make 2>&1)
SUB='Error'

if [[ ${STR} ]];  then
  echo Error;
  exit 1
fi