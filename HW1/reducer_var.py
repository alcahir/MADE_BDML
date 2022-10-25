import sys
import csv

count, avg_price, var_price = 0, 0, 0

for line in sys.stdin:
    batch_size, batch_avg, batch_var = map(float, line.split("\t"))
    var_part_1 = (var_price * count + batch_var * batch_size) / (count + batch_size)
    var_part_2 = count * batch_size * ((avg_price - batch_avg) / (count + batch_size)) ** 2
    var_price = var_part_1 + var_part_2
    avg_price = (avg_price * count + batch_avg * batch_size) / (count + batch_size)
    count += batch_size

print(avg_price, var_price, sep="\t")
