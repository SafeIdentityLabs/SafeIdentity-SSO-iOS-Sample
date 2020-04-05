//
//  NVDS2.h
//  iposso
//


#ifndef __NVDS2_H__
#define __NVDS2_H__

#ifdef __cplusplus
extern "C" {
#endif 
	
#include "StringList.h"
	
#define TERM_SYMBOL '*'
#define OPER_SYMBOL '-'
#define REPL_SYMBOL '%'
	
	typedef struct _NVDS_CONTEXT {
		char * sQuery;
		int nSize;
		PSTRINGLIST	 pList;
	} NVDS_CONTEXT, *PNVDS_CONTEXT;
	
		
	PNVDS_CONTEXT NVDS2_Init();
	int NVDS2_Release(PNVDS_CONTEXT);
	
	int NVDS2_Add(PNVDS_CONTEXT pContext, char *szName, char *szValue);
	int NVDS2_Delete(PNVDS_CONTEXT pContext, char *szName);
	char* NVDS2_Find(PNVDS_CONTEXT pContext, char *szName);
	int NVDS2_Replace(PNVDS_CONTEXT pContext, char *szName, char *szValue);
	
	char* NVDS2_FindByIndex(PNVDS_CONTEXT pContext, char *szName, int index);
	
	
	int NVDS2_GetIndex(PNVDS_CONTEXT pContext, char *szName, char *szValue);
	char* NVDS2_GetQuery(PNVDS_CONTEXT pContext);
	int NVDS2_SetQuery(PNVDS_CONTEXT pContext, char *szInputQuery);
	int NVDS2_ResetQuery(PNVDS_CONTEXT pContext);
	
	char* NVDS2_Decode(PNVDS_CONTEXT pContext, char* szPlainText);
	char* NVDS2_Encode(PNVDS_CONTEXT pContext, char* szPlainText);
	
	char* _NVDS2_GetNextPointer(char *szQuery, char cSeparator);
	char* _NVDS2_GetToken(PSTRINGLIST pList, char *pStart, char *pEnd);
	

#ifdef __cplusplus
}
#endif

#endif

