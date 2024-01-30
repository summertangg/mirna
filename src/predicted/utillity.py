import random
from config import mir26_testing_set as m26
from config import mir54_training_set as m54
from config import mir17_training_set as m17
from config import mir_lawrie_testing_set as mlawrie
from config import mir_larrabeiti_testing_set as mlar
from config import mir_beheshti_testing_set as mbe
from config import mir_sun_testing_set as msun


def generate_random_numbers(scope, number):
    # Generate 20 random numbers between 1 and 5104
    random_numbers = [random.randint(1, scope) for _ in range(number)]

    # Sort the random numbers in ascending order
    sorted_random_numbers = sorted(random_numbers)

    for num in sorted_random_numbers:
        print(num)


def intersect(list_1, list_2):
    set1 = set(list_1)
    set2 = set(list_2)

    common_elements = set1.intersection(set2)
    percentage = len(common_elements) * 100 / len(set2)

    print("Common {} {:.2f}%: {}".format(len(common_elements), percentage, common_elements))


def diff(list_1, list_2):
    set1 = set(list_1)
    set2 = set(list_2)

    only_in_set1 = set1.difference(set2)
    only_in_set2 = set2.difference(set1)


    print("Diff only in A {}: {}".format(len(only_in_set1), only_in_set1))
    print("Diff only in B {}: {}".format(len(only_in_set2), only_in_set2))


# intersect(m54.positive_mirnas, mlawrie.table_1)
# print('\n')
# diff(m54.positive_mirnas, mlawrie.table_1)

# print('*'*20)
# intersect(m54.positive_mirnas, mlawrie.table_2)
# print('\n')
# diff(m54.positive_mirnas, mlawrie.table_2)

# print('*'*20)
# intersect(m54.positive_mirnas, mlar.table_1)
# print('\n')
# diff(m54.positive_mirnas, mlar.table_1)

# print('*'*20)
# intersect(m54.positive_mirnas, mbe.fig_1)
# print('\n')
# diff(m54.positive_mirnas, mbe.fig_1)

print('*'*20)
intersect(m54.positive_mirnas, msun.fig_1)
print('\n')
diff(m54.positive_mirnas, msun.fig_1)

# generate_random_numbers(2552, 1)

# diff(m54.positive_mirnas, m54.positive_mirnas_2)