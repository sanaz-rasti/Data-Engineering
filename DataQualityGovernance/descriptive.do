
* load the dependencies
use "CombinedCohorts.dta", clear


* Filter the observations
keep if cohort == 1

. summarize height_cm if cohort == 1

    Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
   height_cm |         75    165.9573    9.889609        140        193

. 
. count if cohort == 1 & missing(height_cm)
  9,741



