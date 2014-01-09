// Modification of ex-stoc.cpp for compiling to Octave. Credits for
// original below. See notes.txt for history. 
// This one gives a probability mass function

/*************************** ex-stoc.cpp **********************************
* Author:        Agner Fog
* Date created:  2001-11-11
* Last modified: 2008-11-28
* Project:       stocc.zip
* Source URL:    www.agner.org/random
*
* Description:
* Example showing how to use non-uniform random variate generator library.   *
* Necessary files are in stocc.zip.                                          *
*                                                                            *
* Instructions:
* Compile for console mode and run.
*
* Further documentation:
* The file ran-instructions.pdf contains further documentation and 
* instructions.
*
* Copyright 2001-2008 by Agner Fog. 
* GNU General Public License http://www.gnu.org/licenses/gpl.html
*****************************************************************************/

#include <octave/oct.h>
#include <time.h>                      // define time()
#include "randomc.h"                   // define classes for random number generators
#include "stocc.h"                     // define random library classes

#ifndef MULTIFILE_PROJECT
// If compiled as a single file then include these cpp files, 
// If compiled as a project then compile and link in these cpp files.
   #include "mersenne.cpp"             // code for random number generator
   #include "stoc1.cpp"                // random library source code
   #include "stoc3.cpp"                // random library source code
   #include "wnchyppr.cpp"             // calculate probabilities of Wallenius distribution
      #include "fnchyppr.cpp"             // calculate probabilities of Fisher's distribution
   #include "userintf.cpp"             // define system specific user interface
#endif


DEFUN_DLD(wnhg8,args,nargout,
"Random numbers with Wallenius Distribution. \n Usage: \n \n wnhg(n,m,N,omega,x) \n ")
{
   int seed = (int)time(0);            // random seed
   StochasticLib3 sto(seed);           // make instance of random library
   int i;                              // loop counter
   double r;                           // random number
   int ir;                             // random integer number
   double f;                           // calculated function value

   // Octave inputs
   // wallenius_pdf(x,n,m1,m2,omega)
   octave_int32 x1 = args(0).int32_scalar_value(); // 
   octave_int32 n = args(1).int32_scalar_value(); // number balls taken
   octave_int32 m1 = args(2).int32_scalar_value(); // red balls
   octave_int32 m2 = args(3).int32_scalar_value(); // white balls
   double omega = args(4).double_value(); // odds

   // make object for calculating mean, variance and probabilities
   CWalleniusNCHypergeometric nchyp(n, m1, m1+m2, omega, 1E-10f);
   // e.g. n = 80, m = 60, N = 100, omega = 1, peaks near 57

   // Calculate expected frequency
   f = nchyp.probability(x1);
   //printf("%1.3e  ", f);

   EndOfProgram();                     // system-specific exit code
   return octave_value_list(octave_value(f));
}
