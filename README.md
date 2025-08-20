# Effect of Different Teaching Methods on Test Scores

## Project Overview: 
In this project I carried out an experiment using simulated data in SAS, to try and estimate the effect that different teaching methods have on students' test scores. I used a 2x2 factorial treatment design. The two teaching methods were traditional and flipped. The students were either high school-aged or college-aged. See 'Wurzer_Written_Report' for more details on the treatment structure. Blocks were done by the subject of class (Math, History, etc.) 

I used a beta distribution of the response variable -- mean test scores -- because they fall on a proportion form 0 to 1. 

## Files:
- Wurzer_Written_Report.pdf -- final project report that details every step of the project; includes all relevant figures and tables.
- main_code.sas -- Main SAS code used to determine interaction between method and type, and differences in mean test scores
- power_analysis.sas -- SAS code used to estimate number of blocks needed to achieve ~80% power, Professor Ptukhina used this to simulate the data used in the project.

