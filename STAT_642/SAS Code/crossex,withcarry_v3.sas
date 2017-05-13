* ~/METH2/SAS/CROSS,WITHCARRY.SAS;
OPTIONS LS=100 PS=57 NOCENTER NODATE;
DATA DRUG;
INPUT S $ P $ D $ T $ Y C$@@;
LABEL S='SEQUENCE' P='PATIENT' D='DRUG' T='TIME' C='CARRYOVER';
CARDS;
1 1 A1 1 2.5 N 1 1 A2 2 3.2 A1 1 1 A3 3 4.4 A2
1 2 A1 1 2.0 N 1 2 A2 2 2.6 A1 1 2 A3 3 3.1 A2
1 3 A1 1 1.6 N 1 3 A2 2 2.7 A1 1 3 A3 3 3.2 A2
1 4 A1 1 0.1 N 1 4 A2 2 1.3 A1 1 4 A3 3 1.9 A2
2 1 A2 1 2.5 N 2 1 A3 2 3.5 A2 2 1 A1 3 1.9 A3
2 2 A2 1 3.8 N 2 2 A3 2 4.1 A2 2 2 A1 3 2.5 A3
2 3 A2 1 2.7 N 2 3 A3 2 2.9 A2 2 3 A1 3 2.4 A3
2 4 A2 1 1.4 N 2 4 A3 2 1.6 A2 2 4 A1 3 1.3 A3
3 1 A3 1 3.3 N 3 1 A1 2 1.9 A3 3 1 A2 3 2.7 A1
3 2 A3 1 2.1 N 3 2 A1 2 0.6 A3 3 2 A2 3 1.5 A1
3 3 A3 1 4.6 N 3 3 A1 2 3.3 A3 3 3 A2 3 3.2 A1
3 4 A3 1 3.0 N 3 4 A1 2 2.5 A3 3 4 A2 3 2.0 A1
RUN;
TITLE 'CROSSOVER DESIGN WITH TEST FOR CARRYOVER-GLM' ;
PROC GLM;
CLASS S  D T C;
MODEL Y = S  D T C;
RANDOM S T/TEST;
MEANS  S D T;
LSMEANS D/PDIFF ADJUST = TUKEY;
RUN;
TITLE 'CROSSOVER DESIGN WITH TEST FOR CARRYOVER-MIXED' ;
PROC MIXED;
CLASS S P D T C;
MODEL Y = T D C/RESIDUALS;
RANDOM S T;
LSMEANS D/ADJUST = TUKEY;
RUN;
TITLE 'CROSSOVER DESIGN WITH TEST FOR W/O CARRYOVER-GLM' ;
PROC GLM;
CLASS S P D T;
MODEL Y = S  D T;
RANDOM S T/TEST;
LSMEANS D/PDIFF ADJUST = TUKEY;
RUN;
TITLE 'CROSSOVER DESIGN WITH TEST FOR W/O CARRYOVER-MIXED' ;
PROC MIXED;
CLASS S P D T;
MODEL Y =  D/RESIDUALS;
RANDOM S T;
LSMEANS D/ADJUST = TUKEY;
RUN;

