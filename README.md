# UsefulAnalysisFunctions-MATLAB
A repository for any functions that I make for projects that I think could be generally useful!

~~~

MultipleComparisonCorrections.m

alphaTable = MultipleComparisonCorrection(baseAlpha, pValues, correctionMethod)

A MATLAB function that can be used to correct for multiple comparsions in statistical testing. 
Simply input the base alpha value (usually .05 in psychology), your list of p-values OR number of tests, and your chosen correction method.
Currently available methods include "None", "Bonferroni", "Holm", & "Hochberg".
Outputs an array object of the alpha values for each of your tests.

NOTE: For Holm and Hochberg corrections, the alpha values will be in the order matching the inputted p-value list.
 If the number of tests was inputted instead of a p-value table/array object, the alpha values will be listed according to 
 the smallest -> largest matching p-values instead.
  (i.e., use the first alpha value in the output array for your smallest p-value, etc.)
  
NOTE: For Holm and Hochberg corrections, if two p-values in the input table/array are identical, 
the first listed identical p-value will be assigned the highest alpha value.

#

FindKeypress.m

[keyNames, keyNumbers] = FindKeypress

A MATLAB function that finds the key name and corresponsing number of a pressed key on a keyboard. 
This function will find all key names and numbers that are pressed simultaneously.
Run this function, then after a brief wait, press the key(s) that you want to identify simultaneously in the console.
This function outputs two arrays, one with the key names and one with the key numbers. 

NOTE: When pressing multiple keys, the order of these arrays will not match! To find the specific name-numbe rpairs,
investigate each key separately by running the function multiple times/
