# QPCR R Codes

This script is for the calculation of deltaCt values given a particular threshold using raw output data from a stepOne thermocycler. It can also be used with ggplot to output a plot of the fluoresence curves. The fluoresence values are normalised such that they all start at 0, by minusing the value of the first cycle from all cycles and then the approx() base R function is used to find the point of which the fluoresence crosses a given threshold.

The input file is a data.frame which contains your wells that you used, the genes in them and the sample number (biological repeats). An example of this would be:

well |  gene | sample|
-----|-------|-------|
|A1   | DMD   |1|
|A2    |DMD   |2|
|A3    |DMD   |3|
|A4    |ACTB  |1 |
|A5    |ACTB | 2|
|A6    |ACTB | 3|

This can be done in excel and imported as a csv or could be written in R, using the data.frame() function.

The function requires multiple inputs and their descriptions are:

##### x = number of cycles
##### df = data frame as outlined above 
##### y = the fluroescence threshold you want your CT to be calculated from
##### z = One of the following: "graph" for your output to be the ggplot graphs or "deltact" to return a dataframe with deltact values. not inputting a value for this will simply return frames of Ct values calculated for each gene
##### hk = the housekeeping gene or reference that you wish for your deltact calculation to use

### An example of the "graph" output is:

![image](https://user-images.githubusercontent.com/47229599/161538267-49a6b252-2099-4c1b-b61f-2bafb79f30f2.png)

The curves are facetted for both gene and sample, giving a much nicer plot than what is given by the stepOne machine.

### if z = "deltact", the ouput will be:

 | ACTB   |    DMD   |  TAF5L   |
 |---------|----------|----------|
|0   |    1.781906 |  11.695359 | 
|0  |      7.258967 |12.441481   |     
|0 |49.79131  | 10.032020|       

providing a table of deltaCt values against the control which can easily be manipulated and used for plotting or statistics.

### providing no z value returns this:

 
$ACTB
|meanCT|     sample |  deltact  |
|------|------------|-----------|
|45.02982 |    1    |      0    |          
|41.19410 |    2    |      0    |        
|40.00672 |    3    |      0    |      

$DMD
|meanCT|     sample |  deltact  |
|------|------------|-----------|
|56.72518 |    1    |      11.695359    |          
|48.45306 |    2    |      7.258967    |        
|50.03874 |    3    |      10.032020     |   
          
### And so on, returning a data.frame for each individual gene, with deltact calculated against whichever reference was supplied as hk  

