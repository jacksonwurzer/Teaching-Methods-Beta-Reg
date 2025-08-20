/************************************************************************
 Project: Effect of Different Teaching Methods on Test Scores
 Purpose: Determine number of blocks needed to reach 80% power
 Author: Jackson Wurzer
 Date:   May 8th, 2024
************************************************************************/


/* Input Data */
data beta_power;
	input method $ type $ score;
	do block=1 to 6;
		output;
	end;
	datalines;
t h 0.70
f h 0.92
t c 0.72
f c 0.89
;

proc glimmix data=beta_power;
	class block method type;
	model score=method|type/d=beta;
	random intercept / subject=block;
	parms (0.1)(250)/hold=1, 2;
	ods output tests3=f_anova;
run;

data power;
	set f_anova;
	alpha=0.05;
	ncparm=numDF*Fvalue;
	Critical_F=Finv(1-alpha, numDF, denDF, 0);
	Power=1-probF(Critical_F, numDF, denDF, ncparm);
run;

proc print data=power;
run;
