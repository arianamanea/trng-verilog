# Rulează asta în terminalul de python
with open("random_bits.txt", "r") as f:
    bits = f.read()
    # Afișează primele 10 numere convertite din grupuri de 8 biți
    for i in range(0, 80, 8):
        byte = bits[i:i+8]
        print(f"Binar: {byte} -> Decimal: {int(byte, 2)}")
# Vizualizare biți random extrași din TRNG Verilog
with open("random_bits.txt", "r") as f:
    bits = f.read()

total = len(bits)
zeros = bits.count('0')
ones = bits.count('1')

if total > 0:
    p_zeros = (zeros / total) * 100
    p_ones = (ones / total) * 100
    print(f"--- Statistici TRNG ---")
    print(f"Total biți: {total}")
    print(f"Zerouri: {zeros} ({p_zeros:.2f}%)")
    print(f"Unuri:   {ones} ({p_ones:.2f}%)")
    print(f"Bias:    {abs(p_ones - 50):.2f}%")
else:
    print("Fișierul este gol!")