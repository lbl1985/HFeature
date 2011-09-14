#include <string.h>
#include <math.h>
#include "mex.h"

void mexFunction( int nlhs, mxArray *plhs[], 
		  int nrhs, const mxArray *prhs[] ){

  // Get the dimensions of input vector X
  // assuming DxN 
  int d = mxGetM( prhs[0] );
  int n = mxGetN( prhs[0] );

  int nr,nc;

  if(d>n)
    mexWarnMsgTxt("D>N. Make sure X is DxN!");
  
  if(nrhs <2){
    nr = ceil( (double)n /(d+1) )*d;
    nc = n - ceil( (double)n /(d+1))+1;
  }
  else{
    double *tptr = mxGetPr(prhs[1]);
    nr = tptr[0];
    nc = tptr[1];
  }

//  mexPrintf("DEBUG: Forming Hankel with nr:%d nc:%d\n",nr,nc);

  // Allocate space for output
  plhs[0] = mxCreateDoubleMatrix(nr, nc, mxREAL);
  
  // Form Hankel
  double *ptrO = mxGetPr(plhs[0]);
  double *ptrI = mxGetPr(prhs[0]);
  int c=0;
  for(int j=0;j<nc;j++){
    memcpy(ptrO,ptrI,sizeof(double)*nr);
    ptrI += d;
    ptrO += nr;    
  }


}
