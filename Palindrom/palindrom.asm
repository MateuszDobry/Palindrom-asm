.686
.model flat

public _palindrom
extern _malloc : proc

.data
aktualny_ciag dd 0 ; Zainicjowane na 0

.code
_sprawdz PROC
    push ebp
    mov ebp, esp
    push ebx
    mov ebx, [ebp+8] ; od lewej
    mov edx, [ebp+12] ; poczatek
    mov ebp, [ebp+16] ; od prawej
    inc ebx
    dec ebp
    cmp ebx, ebp
    je wpisz
    mov ax, [esi][2*ebx]
    cmp ax, [esi][2*ebp]
    je spr2
    jmp koniec2
spr2:
    add aktualny_ciag, dword ptr 2
    push ebp
    push edx
    push ebx
    call _sprawdz
    add esp, 12
    jmp koniec2
wpisz:
    mov eax, ebp
sub eax, ebx
cmp eax, 1
jne not_middle
    inc dword ptr aktualny_ciag
    jmp kontynuuj
not_middle:
    add dword ptr aktualny_ciag, 2
kontynuuj:
    mov [edi], edx
    add edi, 4
    mov eax, aktualny_ciag
    mov [edi], eax
    add edi, 4
koniec2:
    pop ebx
    pop ebp
    ret
_sprawdz ENDP

_palindrom PROC
    push ebp
    mov ebp, esp
    push esi
    push edi
    push ebx
    mov esi, [ebp+8] ; tablica zrodlowa
    xor ecx, ecx ; ilosc elementow w tablicy zrodlowej

    ; Liczenie d³ugoœci tablicy
licz:
    mov ax, [esi][2*ecx]
    cmp ax, 0
    je dalej
    inc ecx
    jmp licz
dalej:
    mov eax, ecx
    shl eax, 1
    push eax
    call _malloc
    pop ecx ; w ECX dalej ilosc znakow ktore mamy w tablicy zrodlowej
    shr ecx, 1
    mov edi, eax ; tablica docelowa
    push edi ; bedziemy go zmieniac
    xor ebx, ebx ; iterator od lewej
    dec ecx ; glowna petla wykona sie 12 razy bo sprawdzamy od 'k' do 'w' w prawo
    push ecx ; trzeba przechowac nasz licznik

petlay:
    mov ebp, [esp] ; iterator od prawej
    push ecx
petlax:
    mov ax, [esi][2*ebx]
    cmp ax, [esi][2*ebp]
    je spr
    dec ebp
    loop petlax
    inc ebx
    pop ecx
    loop petlay
    jmp koniec

spr:
    inc dword ptr aktualny_ciag
    push ebp ; od prawej
    mov edx, esi
    add edx, ebx
    push edx ; poczatek tego palindromu
    push ebx ; od lewej
    call _sprawdz
    add esp, 12
    dec ebp
    mov aktualny_ciag, dword ptr 1
    loop petlax

koniec:
    add esp, 4 ; przywrócenie stosu po push ecx
    pop edi
    mov eax, edi ; zwrócenie wskaŸnika na tablicê
    pop ebx
    pop edi
    pop esi
    pop ebp
    ret
_palindrom ENDP
END