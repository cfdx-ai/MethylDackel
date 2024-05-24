## Test

To run test just do `python test.py`

#### TODO: dynamically take reference genome path for test. Right now it is hard coded.

## Test BAM file description

* small_bismark.bam  
  This small BAM contains reads with various cases
    * Read with all matching.
    * Read with Insertion.
    * Read with Deletion.
    * Read that contains C at the beginning and also at the end.
    * Read that maps to the beginning of the contig.