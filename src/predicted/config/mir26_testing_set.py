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

# Natural set results:
# J48 M2 
# Correctly Classified Instances          23              100      %
# Incorrectly Classified Instances         0                0      %
# J48 M1
# Correctly Classified Instances          22               95.6522 %
# Incorrectly Classified Instances         1                4.3478 %

positive_mirnas = [
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

random_mirnas = ["hsa-mir-1250",
                 "hsa-mir-329",
                 "hsa-mir-371b",
                 "hsa-mir-378h",
                 "hsa-mir-379",
                 "hsa-mir-449c",
                 "hsa-mir-4517",
                 "hsa-mir-4695",
                 "hsa-mir-4804",
                 "hsa-mir-5002",
                 "hsa-mir-5100",
                 "hsa-mir-5584",
                 "hsa-mir-6510",
                 "hsa-mir-6782",
                 "hsa-mir-6794",
                 "hsa-mir-6827",
                 "hsa-mir-7855"]

all_mirnas = positive_mirnas + random_mirnas
interaction_file = "mirdb_interactions_m26_testing.csv"
