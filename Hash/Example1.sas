libname COPYTO 'my directory';

/* detect missing values */

data COPYTO.blank_check (KEEP= INVALID VALID NA);
    set datasetName end=done;
    retain INVALID VALID NA 0;
    
    IF missing(FIELD_NAME) THEN
        INVALID + 1;
    ELSE 
        VALID +1;
    
    IF done THEN output;
run;

/*
table1 = Master dataset
table2 = LOOKUP table

I want to check if the keys in the Masterset are also in the LOOKUP table
*/

/* Validity Check */

/* PROC SQL VERISION */
proc sql;
create table COPYTO.valdity_sql as
select
    case
        when a.KEY IS NULL THEN 'NA'
        WHEN a.KEY = b.KEY THEN 'VALID'
        ELSE 'INVALID'
    END as rule_flag,
    count(*) as row_count
 FROM table1 a LEFT JOIN table2 b
        on a.KEY = b.KEY
 GROUP BY 1
 ;
 
 /****** assume the lookup table as two field *******/
 
 /* KEY    |  KEY_DESCRIPTION */
 
 /* Example when leveraging HASH VERSION - I modified this methodology that I found online for my use-case */
 /* the fieldname in lookup table doesn't necessarily need to be the same in the master file */
 /* below example assumes that the fieldname are exactly the same */
 
 /* once the datastep is complete, the hash table is destroyed */
 /* it's like a temporary array where the indexes could be either numeric or character */
 
data results (KEEP=valid invalid);
     declare HASH lookup ();                       /* Declare the name of Hash object called Lookup */
     rc = lookup.DefineKey('KEY')                  /* Identify the field to use as key (what used in both master and lookup table*/
     rc = lookup.DefineData('KEY_DESCRIPTION')     /* Identify fields to use as data, i.e., lookup column want to bring into Master */
     rc = lookup.DefineDone()                        /* Complete the hash definition */
     
     do until (eof1);                              /* LOOP to read records from the lookup table */
         set mylookuptable end=eof1;               /* Use my lookup table; eof1 is to let me know when i reached the last row in lookup table */
         rc = plan.add()                           /* add each record from lookup table to hash table */
     end;
     
     retain valid invalid 0;                       /* Retain values from one obs to the next iteration during SAS data step, initialize to 0 */
     do until (eof2);                              /* LOOP to read records from my master data */
         set mymaster end=eof2;
         rc = lookup.find()                        /* Lookup each key's value in the Hash array */
         
         if rc=0 then do;                          /* IF key is found (then rc returns 0) */
             valid + 1;                            /* INCREMENT THE MATCH counter */
         end;
         else do;
             invalid + 1;                          /* key in master was not in the hash table */
         end;
     end;
     
     if eof2 then output;                          /* output my counters to the data set */
     stop;
run;
 
 /* you want to do outer join and bring in the 2nd column from lookup to master */
 
 data master_with_label (DROP=rc);
     declare HASH lookup ();                       /* Declare the name of Hash object called Lookup */
     rc = lookup.DefineKey('KEY')                  /* Identify the field to use as key (what used in both master and lookup table*/
     rc = lookup.DefineData('KEY_DESCRIPTION')     /* Identify fields to use as data, i.e., lookup column want to bring into Master */
     rc = lookup.DefineDone()                        /* Complete the hash definition */
     
     do until (eof1);                              /* LOOP to read records from the lookup table */
         set mylookuptable end=eof1;               /* Use my lookup table; eof1 is to let me know when i reached the last row in lookup table */
         rc = plan.add()                           /* add each record from lookup table to hash table */
     end;
     
     do until (eof2);                              /* LOOP to read records from my master data */
         set mymaster end=eof2;
         call missing(key_description);            /* Initialize the variable we intend to fill; In case we can't find, it's missing/null in Master */
         rc = lookup.find()                        /* Lookup each key's value in the Hash array */
         output;                                   /* output what was found in hash array to master data */
     end;
     
     stop;
run;
 
 
