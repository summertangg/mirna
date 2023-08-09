# Source: Table 2
# Lawrie, Charles H., et al. "Expression of microRNAs in diffuse large B cell lymphoma is associated with immunophenotype, survival and transformation from follicular lymphoma." Journal of cellular and molecular medicine 13.7 (2009): 1248-1260.


# Clean_set results: 
# J48 M1
# Correctly Classified Instances           7               87.5    %
# Incorrectly Classified Instances         1               12.5    %
#  a b   <-- classified as
#  7 1 | a = Yes
#  0 0 | b = No
# J48 M2 
# Correctly Classified Instances           8              100      %
# Incorrectly Classified Instances         0                0      %
#  a b   <-- classified as
#  8 0 | a = Yes
#  0 0 | b = No

clean_set = [
    "hsa-mir-200c",
    "hsa-mir-638",
    "hsa-mir-518a",
    "hsa-mir-22",
    "hsa-mir-362",
    "hsa-mir-206",
    "hsa-mir-636",
    "hsa-mir-199b",
    "hsa-mir-99a",
    "hsa-mir-100",
    "hsa-mir-634",
]

clean_set_for_m17 = [
'hsa-mir-199a', 'hsa-mir-362', 'hsa-mir-27a', 'hsa-mir-26b', 'hsa-mir-518a', 'hsa-mir-217', 'hsa-mir-636', 'hsa-mir-99a', 'hsa-mir-93', 'hsa-mir-106a', 'hsa-mir-150', 'hsa-mir-638', 'hsa-mir-100', 'hsa-mir-18b', 'hsa-mir-634', 'hsa-mir-24', 'hsa-mir-206', 'hsa-mir-200c', 'hsa-mir-22', 'hsa-mir-199b'
]

# Natural set results: Total 15 57.69% overlapping with m54 training set
# J48 M2 
# Correctly Classified Instances          23              100      %
# Incorrectly Classified Instances         0                0      %
# J48 M1
# Correctly Classified Instances          22               95.6522 %
# Incorrectly Classified Instances         1                4.3478 %

natural_set = [
    "hsa-mir-200c",
    "hsa-mir-638",
    "hsa-mir-518a",
    "hsa-mir-199a",
    "hsa-mir-93",
    "hsa-mir-22",
    "hsa-mir-34a",
    "hsa-mir-362",
    "hsa-mir-206",
    "hsa-mir-451b",
    "hsa-mir-636",
    "hsa-mir-92a",
    "hsa-mir-27b",
    "hsa-mir-199b",
    "hsa-mir-27a",
    "hsa-mir-24",
    "hsa-mir-106a",
    "hsa-mir-20a",
    "hsa-mir-19b",
    "hsa-mir-99a",
    "hsa-mir-18b",
    "hsa-mir-100",
    "hsa-mir-26b",
    "hsa-mir-217",
    "hsa-mir-634",
    "hsa-mir-150"
]

clean_file = "mirdb_interactions_m26_testing_clean.csv"
natural_file = "mirdb_interactions_m26_testing_natural.csv"
