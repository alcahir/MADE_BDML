import sys


total_count = 0
total_mean = 0

for line in sys.stdin:
    batch_count, batch_mean = map(float, line.split("\t"))
    total_mean = ((total_count * total_mean) + (batch_count * batch_mean)) / (total_count + batch_count)
    total_count += batch_count

print(total_count, total_mean)