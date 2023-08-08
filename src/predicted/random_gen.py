import random

# Generate 20 random numbers between 1 and 5104
random_numbers = [random.randint(1, 72) for _ in range(10)]

# Sort the random numbers in ascending order
sorted_random_numbers = sorted(random_numbers)

for num in sorted_random_numbers:
    print(num)
