# SCOFIELD
Simple COde for Find drug Information in pubchEm LegenD
-------------------------------------------------------
I'm always __Uncomfortable__ for Find Drug Information. Of course, it's easy to find medicine, but finding a lot of medicine has been a pain as a beginner.  
There are many reasons that are difficult to find. Although it was the same drug, it often had multiple names, and it took a long time to refer to it.      
 
 Meanwhile, I confirmed that I could easily import data with pubchem by using PUG REST published in puchem.   
So I made a script that can get __CID,molecular formula, CanonicalSMILES, IsomericSMILES, InCheKey__ if there is a drug that is pubchem only by the name of the drug.   
I will make it as a gui later and release it.

-------------------------------------------------------------------------------------------------------------------------------------------------
# Example 
  Rscript SCOFIELD.R ./test_mat.txt ./test_output.txt
