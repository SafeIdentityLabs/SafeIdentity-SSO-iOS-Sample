//
//  iposso.h
//  iposso
//

#import <Foundation/Foundation.h>

//int	nHttpErrorCode;
//int nSSOErrorCode;
//
//NSString *nsUrl;
//NSString *ssoToken;

NSString* ipo_sso_init(NSString *url);
//20140801 smoh modify and added
//NSString* ipo_sso_auth_id(NSString *uid, NSString *pwd, NSString *bOverwrite, NSString *cip);

NSString* ipo_sso_auth_id(NSString *uid, NSString *pwd, NSString *bOverwrite, NSString *cip, NSString *secId);
NSString* ipo_sso_verify_token(NSString *sToken, NSString *cip, NSString *secId);
//NSString* ipo_sso_verify_token_sec(NSString *sToken, NSString *cip, NSString *secId);
void ipo_sso_unregusersession(NSString *sToken);
NSString* ipo_sso_user_view(NSString *sToken, NSString *cip);
//NSString* ipo_sso_get_service_list(NSString *sbase, NSString *scope, NSString *sToken, NSString *permission, NSString *cip);
//NSString* ipo_sso_get_permission(NSString *srdn, NSString *sToken, NSString *cip);
NSString* ipo_sso_make_simple_token(NSString *version, NSString *uid, NSString *cip, NSString *secId);
NSString* ipo_sso_reg_user_session(NSString *uid, NSString *cip, NSString *bOverwrite, NSString *secId);
NSString* ipo_sso_put_value(NSString *tagName, NSString *tagValue, NSString *token);
NSString* ipo_sso_get_value(NSString *tagName, int index, NSString *token, NSString *cip, NSString *secId);
NSString* ipo_sso_get_all_values(NSString *token, NSString *cip, NSString *secId);
int ipo_sso_user_pwd_init(NSString *uid, NSString *userPwd, int nPwdMustChangeFlag, NSString *cip);
int ipo_sso_user_modify_pwd(NSString *token, NSString *currentPwd, NSString *newPwd, NSString *cip);
int ipo_sso_user_search(NSString *uid);
NSString* ipo_sso_get_user_role_list(NSString *token, NSString *cip);
NSString* ipo_sso_get_resource_permission(NSString *srdn, NSString *token, NSString *cip, NSString *roleSearch);
NSString* ipo_sso_get_resource_list(NSString *base, NSString *scope, NSString *token, NSString *permission, NSString *cip, NSString *roleSearch);

void ipo_set_ssotoken(NSString *nstoken, NSMutableString *ssoTokenKey);
NSString *ipo_get_ssotoken(NSMutableString *ssoTokenKey);
void ipo_sso_logout(NSMutableString *ssoTokenKey);

NSString* postDataExcute(NSDictionary *dictionaryData);

void setSSOLastError(int nError);
int getSSOLastError();

void setHttpLastError(int nError);
int getHttpLastError();

int makeErrorCode(char *err);

void setUrlString(NSString *url);
NSString* getUrlString();
static NSString* hexval(NSData *data);
NSString * EncryptString(NSString *plainSourceStringToEncrypt);
NSString * DecryptString(NSString *base64StringToDecrypt);

//20140801 smoh added
NSString* getSecId();
