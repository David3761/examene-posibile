# Subiectul 3 — biblioteca statică `libiocla.a`

Acest subiect nu cere scris algoritmi, ci *interpretarea binarului*: ne uităm
în arhiva `libiocla.a` cu unelte de inspecție (`nm`, `objdump`, `ar`, `strings`)
ca să aflăm ce simboluri conține și apoi apelăm funcțiile potrivite din `file.asm`.

Toate exemplele se compilează cu `Makefile`-ul dat, linkând arhiva:

```sh
nasm -f elf64 -g file.asm -o file.o
gcc -g -no-pie file.o libiocla.a -o file
./file
```

---

## a) Arătați variabilele statice ale bibliotecii

O variabilă/funcție „statică” în C devine un **simbol local** în fișierul obiect:
nu este exportată, deci nu poate fi văzută din alt fișier la linkare. În `nm`,
simbolurile locale apar cu **literă mică**, iar cele globale cu **literă mare**.

```sh
nm libiocla.a
```

Rezultat:

```
0000000000000008 b a          <- local (bss)      -> variabilă statică
0000000000000000 R b          <- GLOBAL (rodata)
000000000000005b t best_funx  <- local (text)     -> funcție statică
0000000000000000 B c          <- GLOBAL (bss)
0000000000000024 R disney     <- GLOBAL (rodata)
0000000000000004 B dory       <- GLOBAL (bss)
                 U gets        <- nedefinit (din libc)
0000000000000032 T iz_chill   <- GLOBAL (text)
000000000000001f T lucky7     <- GLOBAL (text)
000000000000004c t nemo       <- local (text)     -> funcție statică
0000000000000000 t print      <- local (text)     -> funcție statică
                 U puts        <- nedefinit (din libc)
0000000000000028 r roro        <- local (rodata)   -> variabilă statică
0000000000000010 b stack       <- local (bss)      -> variabilă statică
0000000000000075 T super_safe  <- GLOBAL (text)
```

Cheia tipurilor: literă **mică** = simbol **local** (static); `t`=cod, `b`=bss
(date neinițializate), `r`=rodata (constante), `d`=date inițializate.

**Variabilele statice** (simboluri locale de date) sunt:

| Simbol | Tip | Secțiune |
|--------|-----|----------|
| `a`    | `b` | .bss     |
| `stack`| `b` | .bss     |
| `roro` | `r` | .rodata  |

Iar **funcțiile statice** (cod local) sunt: `best_funx`, `nemo`, `print`.

> Pentru a vedea doar simbolurile locale se poate folosi și:
> `nm libiocla.a | grep -E ' [a-z] '`

---

## b) Apelați funcția `iz_chill()`

`iz_chill` este simbol **global** (`T` în `nm`), deci se apelează direct: o
declarăm `extern` și o chemăm. Ea afișează `Hello from the otter side!`.

În `file.asm`:

```nasm
extern iz_chill
...
main:
    push rbp
    mov rbp, rsp

    call iz_chill           ; afiseaza "Hello from the otter side!"
```

Cum am aflat ce afișează? Cu disasamblare + relocări:

```sh
objdump -dr -M intel libiocla.a
```

`iz_chill` face `lea rax, [rip+...]` către `.rodata+0x4` apoi `call puts`.
Dumpul secțiunii arată ce e acolo:

```sh
objdump -s -j .rodata libiocla.a
```
```
0008 48656c6c 6f206672 ...   Hello fr...
002c 4e6f206d 6f726520 ...   No more IOCLA!!!
```

Deci `iz_chill` printează `Hello from the otter side!`.

---

## c) Apelați funcția care afișează „No more IOCLA!”

Din dumpul de mai sus, șirul `No more IOCLA!!!` (la `.rodata+0x2c`) este folosit
de funcția **`best_funx`** (ea face `lea .rodata+0x28 (+ addend)` apoi `call puts`).

**Problema:** `best_funx` este `t` (literă mică) → simbol **local/static**. Nu
este exportat, deci `extern best_funx` + `call best_funx` dă eroare la linkare
(`undefined reference to best_funx`). Linkerul rezolvă referințele doar către
simboluri **globale**.

**Soluția:** apelăm funcția prin **adresa calculată** față de un simbol global
din același fișier obiect. Funcțiile din `iocla.o` păstrează aceeași ordine (și
aceleași distanțe relative) și în executabilul final, pentru că fac parte din
aceeași secțiune `.text`. Din `nm`:

```
0000000000000032 T iz_chill     (global)
000000000000005b t best_funx    (local)
```

Distanța: `0x5b - 0x32 = 0x29`. Deci `best_funx` se află mereu la `iz_chill + 0x29`.

În `file.asm`:

```nasm
extern iz_chill
...
    ; c: best_funx e static, il apelez prin adresa relativa la iz_chill
    mov rax, iz_chill
    add rax, 0x29           ; best_funx = iz_chill + 0x29
    call rax                ; afiseaza "No more IOCLA!!!"
```

> Offsetul `0x29` se obține din `nm libiocla.a` (adresa lui `best_funx` minus
> adresa lui `iz_chill`). Dacă biblioteca se schimbă, se recalculează la fel.

---

## `file.asm` complet (rezolvarea subiectului 3)

```nasm
section .data

section .text
extern printf
extern iz_chill
global main

main:
    push rbp
    mov rbp, rsp

    ; b: apelez functia globala iz_chill
    call iz_chill           ; "Hello from the otter side!"

    ; c: apelez functia statica best_funx prin adresa (iz_chill + 0x29)
    mov rax, iz_chill
    add rax, 0x29
    call rax                ; "No more IOCLA!!!"

    ; Return 0.
    xor rax, rax
    leave
    ret
```

### Verificare

```sh
make
./file
```

Ieșire (corespunde cu `results.txt`):

```
Hello from the otter side!
No more IOCLA!!!
```
