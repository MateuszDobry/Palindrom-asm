#include <stdio.h>
#include <stdlib.h>
#include <wchar.h>
#include <string.h>

typedef struct {
    wchar_t* address;
    size_t length;
} PalindromeEntry;

// Deklaracja funkcji palindrom
extern PalindromeEntry* palindrom(wchar_t* tekst);

int main() {
    wchar_t* tekst1 = L"racecar";
    
    PalindromeEntry* results1 = palindrom(tekst1);
    // Wypisywanie wyników dla pierwszego tekstu
    for (size_t i = 0; results1[i].length > 0; i++) {
        wprintf(L"Palindrome: %.*ls, Length: %zu, Address: %p\n",
            (int)results1[i].length, results1[i].address,
            results1[i].length, (void*)results1[i].address);
    }

    free(results1); 

    wchar_t* tekst2 = L"kajakarstwowt";
    PalindromeEntry* results2 = palindrom(tekst2);

    // Wypisywanie wyników dla drugiego tekstu
    for (size_t i = 0; results2[i].length > 0; i++) {
        wprintf(L"Palindrome: %.*ls, Length: %zu, Address: %p\n",
            (int)results2[i].length, results2[i].address,
            results2[i].length, (void*)results2[i].address);
    }

    free(results2); 
    return 0;
}




