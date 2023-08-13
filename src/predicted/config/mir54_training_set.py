positive_mirnas = [
    "hsa-let-7d",
    "hsa-let-7e",
    "hsa-let-7g",
    "hsa-mir-106a",
    "hsa-mir-106b",
    "hsa-mir-143",
    "hsa-mir-146a",
    "hsa-mir-146b",
    "hsa-mir-150",
    "hsa-mir-155",
    "hsa-mir-15a",
    "hsa-mir-16-1",
    "hsa-mir-17",
    "hsa-mir-182",
    "hsa-mir-18a",
    "hsa-mir-18b",
    "hsa-mir-199a",
    "hsa-mir-19a",
    "hsa-mir-19b",
    "hsa-mir-20a",
    "hsa-mir-21",
    "hsa-mir-210",
    "hsa-mir-221",
    "hsa-mir-24",
    "hsa-mir-30b",
    "hsa-mir-320a",
    "hsa-mir-328",
    "hsa-mir-139",
    "hsa-mir-34a",
    "hsa-mir-34b",
    "hsa-mir-365a",
    "hsa-mir-451b",
    "hsa-mir-485",
    "hsa-mir-9",
    "hsa-mir-92a",
    "hsa-mir-93",
    "hsa-mir-181a",
    "hsa-mir-217",
    "hsa-mir-361",
    "hsa-mir-363",
    "hsa-let-7f",
    "hsa-mir-20b",
    "hsa-mir-26a",
    "hsa-mir-26b",
    "hsa-mir-29b",
    "hsa-mir-29c",
    "hsa-mir-125b",
    "hsa-mir-145",
    "hsa-mir-223",
    "hsa-mir-301a",
    "hsa-mir-23a",
    "hsa-mir-23b",
    "hsa-mir-27a",
    "hsa-mir-27b"
]


random_mirnas = [
    "hsa-mir-1250",
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
    "hsa-mir-7855",
    "hsa-mir-8082",
    "hsa-mir-6881",
    "hsa-mir-887",
    "hsa-mir-6847",
    "hsa-mir-6822",
    "hsa-mir-6807",
    "hsa-mir-4309",
    "hsa-mir-6764",
    "hsa-mir-6731",
    "hsa-mir-939",
    "hsa-mir-5696",
    "hsa-mir-5004",
    "hsa-mir-4723",
    "hsa-mir-3976",
    "hsa-mir-5001",
    "hsa-mir-4422",
    "hsa-mir-4418",
    "hsa-mir-3912",
    "hsa-mir-3622a",
    "hsa-mir-4329",
    "hsa-mir-3202",
    "hsa-mir-3130",
    "hsa-mir-1270",
    "hsa-mir-548o",
    "hsa-mir-337",
    "hsa-mir-543",
    "hsa-mir-576",
    "hsa-mir-12132",
    "hsa-mir-12124",
    "hsa-mir-5089",
    "hsa-mir-3192",
    "hsa-mir-1915",
    "hsa-mir-762",
    "hsa-mir-7847",
    "hsa-mir-5571",
    "hsa-mir-2467",
    "hsa-mir-8089"
]

random_mirnas_2 = [
    "hsa-mir-8089",
    "hsa-mir-2467",
    "hsa-mir-5571",
    "hsa-mir-7847",
    "hsa-mir-762",
    "hsa-mir-1915",
    "hsa-mir-3192",
    "hsa-mir-5089",
    "hsa-mir-12132",
    "hsa-mir-12124",
    "hsa-mir-543",
    "hsa-mir-576",
    "hsa-mir-3202",
    "hsa-mir-4329",
    "hsa-mir-4422",
    "hsa-mir-5001",
    "hsa-mir-3976",

]

random_mirnas_3 = [
    "hsa-mir-548o",
    "hsa-mir-337",
    "hsa-mir-3130",
    "hsa-mir-1270",
    "hsa-mir-3622a",
    "hsa-mir-3912",
    "hsa-mir-4418",
    "hsa-mir-5001",

]


all_mirnas = positive_mirnas + random_mirnas
all_mirnas_2 = positive_mirnas + random_mirnas_2

interaction_file = "mirdb_interactions_m54_training_2.csv"
clean_file = "mirdb_interactions_m54_testing_clean.csv"
natural_file = "mirdb_interactions_m54_testing_natural.csv"

clean_set_1 = ['hsa-mir-106b', 'hsa-mir-21', 'hsa-mir-24', 'hsa-mir-16-1', 'hsa-mir-199a', 'hsa-mir-9', 'hsa-mir-182', 'hsa-mir-29c', 'hsa-mir-139', 'hsa-mir-485',]

clean_set_2 = ['hsa-mir-363', 'hsa-mir-361', 'hsa-mir-125b', 'hsa-mir-18a', 'hsa-mir-93', 'hsa-mir-106a', 'hsa-mir-365a', 'hsa-mir-26a', 'hsa-mir-20b', 'hsa-mir-320a']
working = ['hsa-mir-363', 'hsa-mir-93', 'hsa-mir-106a', 'hsa-mir-20b', 'hsa-mir-106b', 'hsa-mir-27a']


clean_set_3 = ['hsa-mir-26b', 'hsa-mir-223', 'hsa-mir-27a', 'hsa-let-7e', 'hsa-mir-29b', 'hsa-mir-221', 'hsa-mir-23a', 'hsa-let-7g', 'hsa-mir-23b', 'hsa-mir-217',]

clean_set_4 = ['hsa-mir-150', 'hsa-let-7d', 'hsa-mir-30b', 'hsa-let-7f', 'hsa-mir-301a', 'hsa-mir-34b', 'hsa-mir-18b', 'hsa-mir-328']


# Correct testing mirna:
# 'hsa-mir-363', 'hsa-mir-93', 'hsa-mir-106a', 'hsa-mir-20b'

#, 'hsa-let-7e', 'hsa-mir-29b'

