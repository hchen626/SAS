Example uses of HASH in SAS. HASH is leveraged in the background for PROC SQL when you perform INNER JOINs.

However, PROC SQL does not leverage Hash when it comes to OUTER JOINs

In my example, I leverage HASH in the datastep where I would like to count the number of matches between the master file and lookup table.

I noticed a big performance difference between HASH and PROC SQL when dealing with large data sets.

The advantage is that we don't have sort either Master or Lookup table prior to merging or joining.
   - This can save time when either tables are extremely big
   - Remember that the SAS data step could be generalized as row level processing 
