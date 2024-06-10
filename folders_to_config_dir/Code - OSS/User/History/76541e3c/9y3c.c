#include<stdlib.h>
#include<stdio.h>
#include<string.h>
#define BUFSIZE 100
#define NAME_LEN 60

int main(void)
{
    char buf[BUFSIZE];
    char filename[60];
    FILE *fp;

    puts("Enter name of text file to display: ");
    fgets(filename, NAME_LEN, stdin);
    filename[strcspn(filename, "\n")] = '\0';
}