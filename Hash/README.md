Example uses of HASH in SAS. HASH is leveraged in the background for PROC SQL when you perform INNER JOINs.

However, PROC SQL does not leverage Hash when it comes to OUTER JOINs

In my example, I leverage HASH in the datastep where I would like to count the number of matches between the master file and lookup table.

I have noticed a big performance difference between HASH and PROC SQL when dealing with large data sets.
