%LET MONTHS_AGO = -4;  /* HOW MANY PREVIOUS MONTHS AGO FROM TODAY */

%LET DATE_TODAY      = %SYSFUNC(TODAY());                                                   /*    DDMONYYYY   */
%LET MONTH_END_DT    = %SYSFUNC(INTNX(MONTH, &DATE_TODAY., &MONTHS_AGO., E), DATE9.);       /*    DDMONYYYY   */
%LET MONTH_START_DT  = %SYSFUNC(INTNX(MONTH, &DATE_TODAY., &MONTHS_AGO., B), DATE9.);       /*    DDMONYYYY   */
%LET MONTH_TODAY_DT  = %SYSFUNC(TODAY(), DATE9.);                                           /*    DDMONYYYY   */                    

/* TO BE USED FOR FILTERTING DATASETS AND NAMING DATASETS */
%LET BEGIN_DATE      = %UNQUOTE(%STR(%'&MONTH_START_DT%'d));                                /*  '01AUG2020'd  */
%LET END_DATE        = %UNQUOTE(%STR(%'&MONTH_END_DT%'d));                                  /*  '31AUG2020'd  */
%LET DATA_DATE       = %SYSFUNC(INTNX(MONTH, &DATE_TODAY., &MONTHS_AGO., E), yymmddn8.);    /*   20200831     */
%LET TODAY_DATE      = %UNQUOTE(%STR(%'&MONTH_TODAY_DT%'d));                                /*  '03DEC2020'd  */
