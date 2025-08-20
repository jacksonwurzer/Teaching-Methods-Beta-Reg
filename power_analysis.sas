/************************************************************************
 Project: Effect of Different Teaching Methods on Test Scores
 Purpose: Estimate number of blocks needed to reach ~80% power
 Author:  Jackson Wurzer
 Date:    May 1st, 2024
************************************************************************/


/*
 Inputting Data
   - Each row gives the average score for a method × type combination
   - Expanded across 6 blocks (replicates) using DO loop */
data beta_power;
    input method $ type $ score;
    do block = 1 to 6;    
        output;
    end;
    datalines;
    t h 0.70   /* Treatment (flipped) method, type h (high school) */
    f h 0.92   /* Control (traditional) method, type h (high school) */
    t c 0.72   /* Treatment (flipped) method, type c (college) */
    f c 0.89   /* Control (traditional) method, type c (college) */
    ;
run;


/* Fit GLIMMIX Model */
proc glimmix data=beta_power method=quadrature;
    class block method type;
    model score = method|type / dist=beta;
    random intercept / subject=block; /* random intercept for block */
    parms (0.1)(250) / hold=1,2;   /* Fix variance/cov estimates */
    ods output tests3 = f_anova;   /* Save Type III ANOVA results */
run;


/* Power Calculation */
data power;
    set f_anova;
    alpha = 0.05;                                  /* Significance level */
    ncparm = numDF * FValue;                       /* Noncentrality */
    Critical_F = finv(1 - alpha, numDF, denDF, 0); /* Critical F cutoff */
    Power = 1 - probF(Critical_F, numDF, denDF, ncparm); /* Estimated power */
run;


/* Display Power Estimates */
proc print data=power label;
    title "Estimated Power for Method × Type Effects";
run;
