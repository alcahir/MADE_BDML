import sys
import csv


counter = 0
cumm_price = 0
generator = csv.reader(sys.stdin, delimiter=",")
for line in generator:
    price = line[9]

    if not price.isdigit():
        continue

    counter += 1
    cumm_price += float(price)

print(counter, cumm_price / counter, sep="\t")