import sys
import csv

#const
BATCH_SIZE = 1
BATCH_VAR = 0

count, avg_price, var_price = 0, 0, 0
generator = csv.reader(sys.stdin, delimiter=",")
for line in generator:
    price = line[9]

    if not price.isdigit():
        continue

    var_part_1 = (var_price * count + BATCH_VAR * BATCH_SIZE) / (count + BATCH_SIZE)
    var_part_2 = count * BATCH_SIZE * ((avg_price - float(price)) / (count + BATCH_SIZE)) ** 2
    var_price = var_part_1 + var_part_2
    avg_price = (avg_price * count + float(price)) / (count + BATCH_SIZE)
    count += BATCH_SIZE

print(count, avg_price, var_price, sep="\t")