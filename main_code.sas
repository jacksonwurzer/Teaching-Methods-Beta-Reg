/************************************************************************
 Project: Effect of Different Teaching Methods on Test Scores
 Author: Jackson Wurzer
 Date:   May 8th, 2024
************************************************************************/


/* Input Data */
data scores;
    input block method $ type $ score;
    datalines;
    1 t h 0.65
    2 t h 0.63
    3 t h 0.72
    4 t h 0.71
    5 t h 0.70
    6 t h 0.71
    1 f h 0.94
    2 f h 0.93
    3 f h 0.93
    4 f h 0.92
    5 f h 0.92
    6 f h 0.93
    1 t c 0.75
    2 t c 0.68
    3 t c 0.72
    4 t c 0.73
    5 t c 0.66
    6 t c 0.71
    1 f c 0.87
    2 f c 0.86
    3 f c 0.92
    4 f c 0.90
    5 f c 0.92
    6 f c 0.89
    ;
run;

/* Print dataset for verification */
proc print data=scores;
run;


/* GLIMMIX Model – Covariance Parameters (Figure 3) */
proc glimmix data=scores method=quadrature;
    class block method type;
    model score = method|type / dist=beta;
    random intercept / subject=block;
run;


/* Interaction Plot (Figure 4) */
proc glimmix data=scores method=quadrature;
    class block method type;
    model score = method|type / dist=beta;
    random intercept / subject=block;
    lsmeans method*type / plot=meanplot(sliceby=type ilink join);
run;


/*
 Type III Tests (Figure 5)
  - Same model as Figure 3 */

proc glimmix data=scores method=quadrature;
    class block method type;
    model score = method|type / dist=beta;
    random intercept / subject=block;
run;



/* LS-Means and Simple Effects (Figures 6, 7, 8) */

proc glimmix data=scores method=quadrature;
    class block method type;
    model score = method|type / dist=beta;
    random intercept / subject=block;
    lsmeans method*type / ilink cl oddsratio slicediff=(method type);
run;
