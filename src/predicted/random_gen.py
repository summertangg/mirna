import random
from config import mir26_testing_set as m26
from config import mir54_training_set as m54


def generate_random_numbers():
    # Generate 20 random numbers between 1 and 5104
    random_numbers = [random.randint(1, 72) for _ in range(10)]

    # Sort the random numbers in ascending order
    sorted_random_numbers = sorted(random_numbers)

    for num in sorted_random_numbers:
        print(num)


def intersect(list_1, list_2):
    set1 = set(list_1)
    set2 = set(list_2)

    common_elements = set1.intersection(set2)
    percentage = len(common_elements) * 100 / len(set2)

    print("Total {} {:.2f}%: {}".format(len(common_elements), percentage, common_elements))


intersect(m54.all_mirnas, m26.positive_mirnas)