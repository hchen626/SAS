%LET MONTHS_AGO = -4;  /* HOW MANY PREVIOUS MONTHS AGO FROM TODAY */

%LET DATE_TODAY      = %SYSFUNC(TODAY());                                                   /*    DDMONYYYY   */
%LET MONTH_START_DT  = %SYSFUNC(INTNX(MONTH, &DATE_TODAY., &MONTHS_AGO., B), date9.);       /*    DDMONYYYY  - Start of Month */
%LET MONTH_END_DT    = %SYSFUNC(INTNX(MONTH, &DATE_TODAY., &MONTHS_AGO., E), date9.);       /*    DDMONYYYY  - End of Month   */
%LET MONTH_TODAY_DT  = %SYSFUNC(TODAY(), date9.);                                           /*    DDMONYYYY   */

%LET TODAY_DTM       = %SYSFUNC(DATETIME());                                                /* TODAY IN DATETIME FORMAT */
%LET START_DTM       = %SYSFUNC(INTNX(DTMONTH, &TODAY_DTM., &MONTHS_AGO., B), datetime20.); /* DDMONYYYY:HH:MM:SS       */
%LET END_DTM         = %SYSFUNC(INTNX(DTMONTH, &TODAY_DTM., &MONTHS_AGO., E), datetime20.); /* DDMONYYYY:HH:MM:SS       */

/* TO BE USED FOR FILTERTING DATASETS AND NAMING DATASETS */
%LET BEGIN_DATE      = %UNQUOTE(%STR(%'&MONTH_START_DT%'d));                                /*  '01AUG2020'd  */
%LET END_DATE        = %UNQUOTE(%STR(%'&MONTH_END_DT%'d));                                  /*  '31AUG2020'd  */
%LET DATA_DATE       = %SYSFUNC(INTNX(MONTH, &DATE_TODAY., &MONTHS_AGO., E), yymmddn8.);    /*   20200831     */
%LET TODAY_DATE      = %UNQUOTE(%STR(%'&MONTH_TODAY_DT%'d));                                /*  '03DEC2020'd  */

%LET BEGIN_DTM       = %UNQUOTE(%STR(%'&START_DTM%'dt));                                    /*  '01AUG2020:00:00:00'dt  */
%LET END_DTM         = %UNQUOTE(%STR(%'&END_DTM%'dt));                                      /*  '31AUG2020:23:59:59'dt  */
