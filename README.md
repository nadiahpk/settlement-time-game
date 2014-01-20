# Reference

Schmidt, K.A., Johansson, J. Kristensen, N.P. and Jonzen, N.  Consequences of information use in breeding habitat selection on the evolution of settlement time. Paper in preparation.


# Quick Start

If you have git:

    $ git clone https://github.com/nadiahpk/settlement-time-game
    $ cd settlement-time-game

If you don't have git, just download and unpack the latest zip file:

[https://github.com/nadiahpk/settlement-time-game/archive/master.zip](https://github.com/nadiahpk/settlement-time-game/archive/master.zip)

In Octave

    > params;
    > [y,fval]=solveEss(.5,p)

Should give the result

    y =  0.58899


# The Wallenius solver

In the subdirectory ```wnhgsolver``` is C++ code for the Wallenius
distribution (from [Agner Fog](http://www.anger.org)) and the file
```wnhg8.cpp``` to generate ```wnhg8.oct```. You can create your own by running

    $ mkoctfile wnhg8.cpp


