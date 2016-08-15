/* This utility is used to keep track the memory allocated from heap
 * which can be used to debug memory core dump, memory leadk issues.
 * Specifically We redefined corresponding memory handling funtions as:
 *------------------------------------------------------
 * D_malloc(int bs, int __LINE__);
 * D_calloc(int numOfBlk, int blkSz, int __LINE__);
 * D_realloc(void *p, int blkSz, int __LINE__);
 * D_free(void *p, int __LINE__);
 * D_dump();
 *------------------------------------------------------
 *
 * The rule is:
 * 1. Add "D_" as prefix;
 * 2. Add "__FILE__, __LINE__" as additional parameter.
 * 3. D_dump() will show info of which memory is not being freeed.
 * 
 * Steps of how to use:
 * 1. Put this file memtracker.h into the dir where you write your C code.
 * 2. Add 1 more line in your C file as '#include "memtracker.h"'.
 * 3. Replacing any memory applying function with corresponding function call
 *    which defined in this file, e.g, you call 'calloc(1, 100);', then you
 *    need to call 'D_calloc(1, 100, __FILE__, __LINE__);' instead. 
 *    if you want to free a pointer, using 'D_free(ptr, __FILE__,__LINE__);'.
 * 4. Add 'D_dump();' as your last code to print memory info which 
 *    being allocated but not freed.
 * 5. Open '%LESDIR%/log/MemDump.log' to check the memory infor.
 */
#ifndef MEMTRACKER_H
#define MEMTRACKER_H
#define MAXFILENAME_LEN 100

typedef struct tagNode{
	void *val;       /* memory address which being allocated*/
	int numOfBlocks; /* Number of blocks to allocate */
	long blockSize;  /* Size of each block. */
	int linNum;      /* Line number of src code where allocated this block of memory */
	char fileName[MAXFILENAME_LEN];
	struct tagNode *nxt;
}MEMTRACKER;


/*PUBLIC:
 *Below functions can be used to replace standard call, such as replacing 'malloc(...)' with 'D_malloc(...,__FILE__, __LINE__)'
 */
void* D_malloc(int blocksize, char *FILE, int LINE);
void* D_calloc(int num, int blocksize, char *FILE, int LINE);
void* D_realloc(void *p, int blocksize, char *FILE, int LINE);
void  D_free(void *p, char *FILE, int LINE);
void  D_dump();


/* PRIVATE:
 * Below section is not used by user, it's the implmentation of this utility
 */
MEMTRACKER *Head=NULL;
char LogFile[200];
FILE *fp = NULL;

typedef enum LastOpr
{
    MALLOC,
    CALLOC,
    REALLOC,
    FREE,
    INIT
} LSTOPR;

LSTOPR lo = INIT;

void OpenLogFile();

/*
int main(int argc, char* argv[])
{
    char *p;
  p = (char*)D_calloc(1, 100, __LINE__);
    //D_free(p);
    D_dump();
    return 0;
}
*/

void OpenLogFile()
{
     char *fn;
     
     if(fp)
       return;
     
     fn = getenv("LESDIR");
     if(!fn)
     {
           strcpy(LogFile, "MemDump.log");
     }
     else
     {
           strcpy(LogFile, fn);
           strcat(LogFile, "\\log\\MemDump.log");
     }
     
     printf("\nOpening log file at:[%s]\n", LogFile);
     
     fp = fopen(LogFile,"w");
     
     if(!fp)
     {
      printf("\nCan not open file MemDump.log for writing!\n");
      exit(0);
   }
}

void* D_malloc(int blocksize, char *fileNam, int lineNum)
{
    void *p;
    MEMTRACKER *pCur = Head;
    static char FN[MAXFILENAME_LEN];
    
    if(!fp)
    {
         OpenLogFile();
    }

    p = malloc(blocksize);

    if (!p)
    {
        fprintf(fp, "Can not malloc memory success!\n");
        fclose(fp);
        exit(0);
    }

    while(pCur && pCur->nxt)
        pCur = pCur->nxt;
        
  if (lo != MALLOC || strcmp(FN, fileNam))
  {     
        fprintf(fp, "\nMallocating Memory in [%s]:\n");
        fprintf(fp, "|%9s|%9s|%9s|%9s|\n", "Address","LineNum", "NumOfBlk", "BlkSize");
        fprintf(fp, "-----------------------------------------\n");
        lo = MALLOC;
        strcpy(FN, fileNam);
    }
    fprintf(fp, "|%9p|%9d|%9d|%9d|\n", p, lineNum, 1, blocksize);

    if (!pCur)
    {
        Head = pCur = (MEMTRACKER*) calloc(1, sizeof (MEMTRACKER));
        pCur->val = p;
        pCur->blockSize = blocksize;
        pCur->numOfBlocks = 1;
        pCur->linNum = lineNum;
        strcpy(pCur->fileName, fileNam);
  }
    else 
    {
        pCur->nxt = (MEMTRACKER*) calloc(1, sizeof (MEMTRACKER));
        pCur->nxt->val = p;
        pCur->nxt->blockSize = blocksize;
        pCur->nxt->numOfBlocks = 1;
        pCur->nxt->linNum = lineNum;
        strcpy(pCur->fileName, fileNam);
    }

    return p;
}

void* D_calloc(int num, int blocksize, char *fileNam, int lineNum)
{
    void *p;
    MEMTRACKER *pCur = Head;
    static char FN[MAXFILENAME_LEN];
    
    if(!fp)
    {
         OpenLogFile();
    }

    p = calloc(num, blocksize);

    if (!p)
    {
        fprintf(fp, "Can not allocate memory success!\n");
        fclose(fp);
        exit(0);
    }

    while(pCur && pCur->nxt)
        pCur = pCur->nxt;
        
  if (lo != CALLOC || strcmp(FN, fileNam))
  {     
        fprintf(fp, "\nCallocating Memory in [%s]:\n", fileNam);
        fprintf(fp, "|%9s|%9s|%9s|%9s|\n", "Address","LineNum", "NumOfBlk", "BlkSize");
        fprintf(fp, "-----------------------------------------\n");
        lo = CALLOC;
        strcpy(FN, fileNam);
    }
    
    fprintf(fp, "|%9p|%9d|%9d|%9d|\n", p, lineNum, num, blocksize);

    if (!pCur)
    {
        Head = pCur = (MEMTRACKER*) calloc(1, sizeof (MEMTRACKER));
        pCur->val = p;
        pCur->blockSize = blocksize;
        pCur->numOfBlocks = num;
        pCur->linNum = lineNum;
        strcpy(pCur->fileName, fileNam);
  }
    else 
    {
        pCur->nxt = (MEMTRACKER*) calloc(1, sizeof (MEMTRACKER));
        pCur->nxt->val = p;
        pCur->nxt->blockSize = blocksize;
        pCur->nxt->numOfBlocks = num;
        pCur->nxt->linNum = lineNum;
        strcpy(pCur->fileName, fileNam);
    }

    return p;
}

void* D_realloc(void *p0, int blocksize, char *fileNam, int lineNum)
{
    void *p;
    MEMTRACKER *pCur = Head;
    static char FN[MAXFILENAME_LEN];
    
    if(!fp)
    {
         OpenLogFile();
    }

    p = realloc(p0, blocksize);

    if (!p)
    {
        fprintf(fp, "Can not reallocate memory success!\n");
        fclose(fp);
        exit(0);
    }

    while(pCur && pCur->nxt)
        pCur = pCur->nxt;
        
  if (lo != REALLOC || strcmp(FN, fileNam))
  {     
        fprintf(fp, "\nReallocating Memory in [%s]:\n", fileNam);
        fprintf(fp, "|%9s|%9s|%9s|%9s|\n", "Address","LineNum", "NumOfBlk", "BlkSize");
        fprintf(fp, "-----------------------------------------\n");     
        lo = REALLOC;
        strcpy(FN, fileNam);
    }       

    
    fprintf(fp, "|%9p|%9d|%9d|%9d|\n", p, lineNum, 1, blocksize);

    if (!pCur)
    {
        Head = pCur = (MEMTRACKER*) calloc(1, sizeof (MEMTRACKER));
        pCur->val = p;
        pCur->blockSize = blocksize;
        pCur->numOfBlocks = 1;
        pCur->linNum = lineNum;
        strcpy(pCur->fileName, fileNam);
    }
    else 
    {
        pCur->nxt = (MEMTRACKER*) calloc(1, sizeof (MEMTRACKER));
        pCur->nxt->val = p;
        pCur->nxt->blockSize = blocksize;
        pCur->nxt->numOfBlocks = 1;
        pCur->nxt->linNum = lineNum;
        strcpy(pCur->fileName, fileNam);
    }

    return p;
}

void D_free(void *p, char *fileNam, int linNum)
{
    MEMTRACKER *pCur = Head, *prev = Head;
    static char FN[MAXFILENAME_LEN];
    
    if(!fp)
    {
         OpenLogFile();
    }
    
    while (pCur && pCur->val != p)
    {
        prev = pCur;
        pCur=pCur->nxt;
    }

    if (pCur)
    {
      if (lo != FREE || strcmp(FN, fileNam))
      {       
        fprintf(fp, "\nFreeing Memory in [%s]\n", fileNam);
        fprintf(fp, "|%9s|%9s|%9s|%9s|%9s|\n", "Address","AocFrmLin", "FreFrmLin", "NumOfBlk", "BlkSize");
        fprintf(fp, "---------------------------------------------------\n");       
        lo = FREE;
        strcpy(FN, fileNam);
      }     
      
      
      fprintf(fp, "|%9p|%9d|%9d|%9d|%9d|\n", pCur->val, pCur->linNum, linNum, pCur->numOfBlocks, pCur->blockSize);
      
        if (pCur == Head)
        {
            Head = Head->nxt;
            free(pCur);
        }
        else
        {
            prev->nxt = pCur->nxt;
            free(pCur);
        }
    }
    else
    {
        fprintf(fp,"\nWarning! At file [%s], line [%d] tried to free memory address [%9p]"
        		   " which is not registed by D_xxalloc() function, is the memory allocated from somewhere else?\n",
        		   fileNam, linNum, p);
    }
}

void  D_dump()
{
    MEMTRACKER *pCur = Head, *tmp;
    static char FN[MAXFILENAME_LEN];
    
    if(!fp)
    {
         OpenLogFile();
    }
    
    fprintf(fp, "\nNow dumping memory which not being freed:\n");
    fprintf(fp, "*********************************************\n\n");

    while (pCur)
    {
      if (strcmp(FN, pCur->fileName))
      {
          fprintf(fp, "File:[%s]\n", pCur->fileName);
          fprintf(fp, "|%9s|%9s|%9s|%9s|\n", "AocFrmLin","NumOfBlk","BlkSize","Address");
          fprintf(fp, "-----------------------------------------\n"); 
          strcpy(FN, pCur->fileName);
      }
      fprintf(fp, "|%9d|%9d|%9d|%9p|\n", 
           pCur->linNum,
           pCur->numOfBlocks,
           pCur->blockSize,
           pCur->val);
           
      tmp = pCur;
      pCur = pCur->nxt;

      /* If we need to take care of freeing the leaked memory, we can
       * comment out below code to free tmp. I commented it in case
       * user need to keep it such as cache.
       */

      /*free(tmp);*/
    }

    fprintf(fp, "\n\nDumping memory finished!\n");
    fprintf(fp, "*********************************************\n");
    
    fclose(fp);
}

#endif
