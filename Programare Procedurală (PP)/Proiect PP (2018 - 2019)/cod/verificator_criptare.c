#include <stdio.h>
#include <string.h>

int dimensiuneFisier(FILE *f)
{
    int p, dim;

    p = ftell(f);
    fseek(f, 0, SEEK_END);
    dim = ftell(f);
    fseek(f, p, SEEK_SET);

    return dim;
}

int main()
{
    FILE *ftest, *fok;

    char nume_img_testata[101];
    char nume_img_criptata_ok[] = "enc_peppers_ok.bmp";

    unsigned int latime_img, inaltime_img, i, j, padding;
    unsigned char pOK[3], pTest[3], byteTest, byteOK, h;

    printf("Numele fisierului care contine imaginea criptata: ");
    fgets(nume_img_testata, 101, stdin);
    nume_img_testata[strlen(nume_img_testata) - 1] = '\0';

    fok = fopen(nume_img_criptata_ok, "rb");
    if(fok == NULL)
    {
        printf("\nNu am gasit imaginea criptata de referinta (enc_peppers_ok.bmp)!\n");
        return 0;
    }

    ftest = fopen(nume_img_testata, "rb");
    if(ftest == NULL)
    {
        printf("\nNu am gasit imaginea criptata pe care trebuie sa o testez (%s)!\n", nume_img_testata);
        return 0;
    }

    if(dimensiuneFisier(fok) != dimensiuneFisier(ftest))
    {
        printf("\nImaginea criptata testata (%s) nu are dimensiunea in octeti corecta!\n", nume_img_testata);
        fclose(fok);
        fclose(ftest);
        return 0;
    }

    for(h = 0; h < 54; h++)
    {
        fread(&byteOK, 1, 1, fok);
        fread(&byteTest, 1, 1, ftest);

        if(byteOK != byteTest)
        {
            printf("\nImaginea criptata testata (%s) are header-ul incorect la octetul %u!\n", nume_img_testata, h);
            fclose(fok);
            fclose(ftest);
            return 0;
        }
    }

    fseek(fok, 18, SEEK_SET);
    fread(&latime_img, sizeof(unsigned int), 1, fok);
    fread(&inaltime_img, sizeof(unsigned int), 1, fok);

    if(latime_img % 4 != 0)
        padding = 4 - (3 * latime_img) % 4;
    else
        padding = 0;

    fseek(fok, 54, SEEK_SET);
    fseek(ftest, 54, SEEK_SET);

    for(i = 0; i < inaltime_img; i++)
    {
        for(j = 0; j < latime_img; j++)
        {
            fread(pOK, 3, 1, fok);
            fread(pTest, 3, 1, ftest);

            if(memcmp(pOK, pTest, 3) != 0)
            {
                printf("\nImaginea criptata testata (%s) are o valoare incorecta a pixelului de pe linia %u si coloana %u!\n", nume_img_testata, inaltime_img - 1 - i, j);
                fclose(fok);
                fclose(ftest);
                return 0;
            }
        }

        fseek(fok,padding,SEEK_CUR);
        fseek(ftest,padding,SEEK_CUR);
    }

    printf("\nImaginea criptata testata (%s) este corect criptata!\n", nume_img_testata);

    fclose(fok);
    fclose(ftest);

    return 0;
}
