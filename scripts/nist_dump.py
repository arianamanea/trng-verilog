# Dumps random bits for NIST SP 800-22 testing

with open("random_bits.txt", "w") as f:
    import random
    for _ in range(100000):
        f.write(str(random.randint(0, 1)))
