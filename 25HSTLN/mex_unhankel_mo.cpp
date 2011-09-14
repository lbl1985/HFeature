#include <string.h>
#include "mex.h"

void mexFunction( int nlhs, mxArray *plhs[], 
		  int nrhs, const mxArray *prhs[] ){

  int d;
  if (nrhs <= 2){
    d = 1;
  }
  else{
    // Get the block dimension
    d = *(mxGetPr( prhs[1] ));
  }
  //  mexErrMsgTxt("Two parameters are needed!");

  // Get the dimensions of the Hankel matrix 
  int nr = mxGetM( prhs[0] );
  int nc = mxGetN( prhs[0] );

  

  if ( nr%d != 0)
    mexErrMsgTxt("Wrong block size!");

  // Compute the sequence length
  int l = nr/d+nc-1;

  // Allocate space for output
  plhs[0] = mxCreateDoubleMatrix(d, l, mxREAL);

  double *X = mxGetPr( plhs[0] );
  memset(X,(double)0.0,sizeof(double)*d*l);  // initialize X to 0

  // Counter array for X elements
  // that will hold how many times they appear in Hankel matrix
  long *counts = new long[l];
  memset(counts,(long)0,sizeof(long)*l); // initialize counts to 0 

  // initialize the pointer to input matrix
  double *ptrI = mxGetPr(prhs[0]);
  double *ptrX = X;
  long   *ptrc = counts;


// WITH AVERAGING

  // add elements 
  //mexPrintf("H = \n");
  for(int j=0; j<nc; j++) {
    for(int i=0; i<nr/d; i++){
      for(int k=0; k<d; k++){
    //    mexPrintf("%f ",(*ptrI));
        (*ptrX) += (*ptrI);
//        (*ptrX) += 1;
        ptrX++; ptrI++;
      }
      (*ptrc)++; ptrc++;
     // mexPrintf("\n");
    }
    ptrc -= (nr/d)-1;
    ptrX -= (nr-d);    
  }

  
  // average them
  ptrX = X;
  ptrc = counts;
  for(int i=0;i<l;i++){
    for(int j=0;j<d;j++){
      (*ptrX) /= (*ptrc);  
      ptrX++;
    }
    ptrc++;
  }

  delete counts;


//   WITHOUT AVERAGING
/*

  // Form Output
  // first column of Hankel
  double *ptrO = mxGetPr(plhs[0]);
  double *ptrI = mxGetPr(prhs[0]);
  for(int i=0; i<nr/d; i++){
    for(int k=0; k<d; k++){
      (*ptrO)=(*ptrI);
       ptrI++; ptrO++;
    }
  }


  // last row of Hankel
  ptrI += (nr-d);
  for(int j=1;j<nc;j++){
    for(int k=0; k<d; k++){
      (*ptrO)=(*ptrI);
      ptrI++; ptrO++;
    }
    ptrI += (nr-d);
  }

*/


}
