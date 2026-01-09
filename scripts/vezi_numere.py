with open("../bits_hardware.txt", "r") as f:
    bits = f.read()

print("--- Primele 20 de numere generate de TRNG (0-255) ---")

# Luăm biții în grupuri de câte 8 (1 byte)
for i in range(0, 160, 8):
    grup_biti = bits[i:i+8]
    if len(grup_biti) == 8:
        # Convertim din binar în decimal
        numar = int(grup_biti, 2)
        print(f"Biți: {grup_biti}  =>  Număr: {numar}")