import os
from vcdvcd import VCDVCD

script_dir = os.path.dirname(os.path.abspath(__file__))
vcd_path = os.path.join(script_dir, '..', 'trng_wave.vcd')

print(f"Caut fișierul la: {os.path.abspath(vcd_path)}")

if not os.path.exists(vcd_path):
    print(f" EROARE: Fișierul VCD nu a fost găsit!")
    exit(1)

try:
    vcd = VCDVCD(vcd_path)
    
    bit_signal = vcd['trng_top_tb.random_bit']
    valid_signal = vcd['trng_top_tb.random_valid']

    captured_bits = []

    # tv = Time-Value pairs
    for time, val_valid in valid_signal.tv:
        if val_valid == '1':
            # Sintaxa CORECTĂ pentru vcdvcd este signal[time]
            val_bit = bit_signal[time]
            if val_bit in ['0', '1']:
                captured_bits.append(val_bit)

    output_path = os.path.join(script_dir, "random_bits.txt")
    with open(output_path, "w") as f:
        f.write("".join(captured_bits))

    print(f" SUCCES! S-au extras {len(captured_bits)} biți reali.")
    print(f"Rezultat salvat în: {output_path}")

except Exception as e:
    print(f"EROARE CRITICĂ: {str(e)}")