# Lawrie, Charles H., et al. "Expression of microRNAs in diffuse large B cell lymphoma is associated with immunophenotype, survival and transformation from follicular lymphoma." Journal of cellular and molecular medicine 13.7 (2009): 1248-1260.


table_1 = [
    "hsa-mir-125b",
    "hsa-mir-143",
    "hsa-mir-451b",
    "hsa-mir-145",
    "hsa-mir-10b",
    "hsa-mir-34a",
    "hsa-mir-100",
    "hsa-mir-9",
    "hsa-mir-155",
    "hsa-mir-21",
    "hsa-mir-150",
    "hsa-mir-363",
    "hsa-mir-223",
    "hsa-mir-584",
    "hsa-mir-361",
    "hsa-mir-625",
    "hsa-mir-495",
    "hsa-mir-181a"
]

table_2 = [
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
    "hsa-mir-100"
]

# hsa-miR-26b	1.88E-02	FCL	1.42
# hsa-miR-217	2.84E-02	FCL	2.44
# hsa-miR-634	9.50E-04	FCL	2.54
# hsa-miR-150	4.55E-02	FCL	3.46

working = ['hsa-mir-363', 'hsa-mir-93', 'hsa-mir-106a', 'hsa-mir-20b', 'hsa-mir-106b', 'hsa-mir-27a']

clean_file = "mirdb_interactions_lawrie_testing_clean.csv"
natural_file = "mirdb_interactions_lawrie_testing_natural.csv"
table_1_file = "mirdb_interactions_lawrie_testing_table_1_with_sequence.csv"
table_2_file = "mirdb_interactions_lawrie_testing_table_2_with_sequence.csv"

sequence_table_1 = {
    "hsa-mir-125b": "UCCCUGAGACCCUAACUUGUGA",
    "hsa-mir-143": "UGAGAUGAAGCACUGUAGCUC",
    "hsa-mir-451b": "UAGCAAGAGAACCAUUACCAUU",
    "hsa-mir-145": "GUCCAGUUUUCCCAGGAAUCCCU",
    "hsa-mir-10b": "UACCCUGUAGAACCGAAUUUGUG",
    "hsa-mir-34a": "UGGCAGUGUCUUAGCUGGUUGU",
    "hsa-mir-100": "AACCCGUAGAUCCGAACUUGUG",
    "hsa-mir-9": "UCUUUGGUUAUCUAGCUGUAUGA",
    "hsa-mir-155": "UUAAUGCUAAUCGUGAUAGGGGUU",
    "hsa-mir-21": "UAGCUUAUCAGACUGAUGUUGA",
    "hsa-mir-150": "UCUCCCAACCCUUGUACCAGUG",
    "hsa-mir-363": "AAUUGCACGGUAUCCAUCUGUA",
    "hsa-mir-223": "UGUCAGUUUGUCAAAUACCCCA",
    "hsa-mir-584": "UUAUGGUUUGCCUGGGACUGAG",
    "hsa-mir-361": "UUAUCAGAAUCUCCAGGGGUAC",
    "hsa-mir-625": "AGGGGGAAAGUUCUAUAGUCC",
    "hsa-mir-495": "AAACAAACAUGGUGCACUUCUU",
    "hsa-mir-181a": "AACAUUCAACGCUGUCGGUGAGU"
}

sequence_table_2 = {
    "hsa-mir-200c": "UAAUACUGCCGGGUAAUGAUGGA",
    "hsa-mir-638": "AGGGAUCGCGGGCGGGUGGCGGCCU",
    "hsa-mir-518a": "GAAAGCGCUUCCCUUUGCUGGA",
    "hsa-mir-199a": "CCCAGUGUUCAGACUACCUGUUC",
    "hsa-mir-93": "CAAAGUGCUGUUCGUGCAGGUAG",
    "hsa-mir-22": "AAGCUGCCAGUUGAAGAACUGU",
    "hsa-mir-34a": "UGGCAGUGUCUUAGCUGGUUGU",
    "hsa-mir-362": "AAUCCUUGGAACCUAGGUGUGAGU",
    "hsa-mir-206": "UGGAAUGUAAGGAAGUGUGUGG",
    "hsa-mir-451b": "UAGCAAGAGAACCAUUACCAUU",
    "hsa-mir-636": "UGUGCUUGCUCGUCCCGCCCGCA",
    "hsa-mir-92a": "UAUUGCACUUGUCCCGGCCUGU",
    "hsa-mir-27b": "UUCACAGUGGCUAAGUUCUGC",
    "hsa-mir-199b": "CCCAGUGUUUAGACUAUCUGUUC",
    "hsa-mir-27a": "UUCACAGUGGCUAAGUUCCGC",
    "hsa-mir-24": "UGGCUCAGUUCAGCAGGAACAG",
    "hsa-mir-106a": "AAAAGUGCUUACAGUGCAGGUAG",
    "hsa-mir-20a": "UAAAGUGCUUAUAGUGCAGGUAG",
    "hsa-mir-19b": "UGUGCAAAUCCAUGCAAAACUGA",
    "hsa-mir-99a": "AACCCGUAGAUCCGAUCUUGUG",
    "hsa-mir-18b": "UAAGGUGCAUCUAGUGCAGUUAG",
    "hsa-mir-100": "AACCCGUAGAUCCGAACUUGUG"
}

