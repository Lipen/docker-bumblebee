[![Docker Hub](https://img.shields.io/badge/docker-latest-blue.svg)](https://hub.docker.com/r/lipen/docker-bumblebee)


# BumbleBEE on Docker

**BEE** (**B**en-Gurion University **E**qui-propagation **E**ncoder) is a compiler which enables to encode finite domain constraint problems to CNF.

**BumbleBEE** is a constraint solver which enables to read BEE model from input file, compile it to CNF using BEE, solve the generated CNF using SAT-solver with Prolog interface and output the assignment for the declared variables in the BEE model.

For any further details visit [BEE home page](http://amit.metodi.me/research/bee), this repository only contains Dockerfile for BumbleBEE solver.

## Usage

```sh
docker build -t bumblebee .
docker run --rm -v $PWD:/input bumblebee example.bee
```

```
## <<example.bee>>                <<BumbleBEE output>>
new_bool(a)                       %  \'''/ //      BumbleBEE       / \_/ \_/ \
new_int(x, -5, 5)                 % -(|||)(')     (15/06/2017)     \_/ \_/ \_/
new_int(y, -10, 0)                %   ^^^        by Amit Metodi    / \_/ \_/ \
new_int(z, 1, 10)                 %
new_int(i1, -25, 25)              %  reading BEE file ... done
int_times(x, x, i1)               %  load pl-satSolver ... OK
new_int(i2, 0, 100)               %  encoding BEE model ... done
int_times(y, y, i2)               %  solving CNF (satisfy) ...
new_int(i3, -25, 125)             a = false
int_plus(i1, i2, i3)              x = 0
new_int(i4, -24, 135)             y = 0
int_plus(i3, z, i4)               z = 7
int_lt(i4, 50)                    i1 = 0
new_int(i5, -5, 15)               i2 = 0
int_plus(x, -y, i5)               i3 = 0
new_int(i6, -15, 14)              i4 = 7
int_plus(i5, -z, i6)              i5 = 0
int_eq_reif(i6, -5, b7)           i6 = -7
bool_eq(a, b7)                    ----------
solve satisfy                     ==========
```
