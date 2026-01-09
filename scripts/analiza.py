with open("../bits_hardware.txt", "r") as f:
    bits = f.read()

total = len(bits)
zeros = bits.count('0')
ones = bits.count('1')

print(f"--- Rezultate TRNG ---")
print(f"Total biți extrași: {total}")
print(f"Zero: {zeros} ({(zeros/total)*100:.2f}%)")
print(f"Unu:  {ones} ({(ones/total)*100:.2f}%)")