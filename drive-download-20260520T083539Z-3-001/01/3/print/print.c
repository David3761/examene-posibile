#include <stdio.h>
#include <string.h>

void print_flag();

int main() {
    char name[50];
    printf("What's your name? ");
    fgets(name, sizeof(name), stdin);
    name[strcspn(name, "\n")] = 0;

    if (strcmp(name, "admin") == 0) {
        print_flag();
    } else {
        printf("Access denied for %s.\n", name);
    }

    return 0;
}
