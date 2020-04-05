//
//  Common.m
//  MSSOSample
//


#import "CommonUtil.h"

#define CLIENT_IP @"127.0.0.1"
//#define EXP_PAGE_URL @"https://192.168.60.136:8443/demo/ios/exp_mobilesso.jsp"
//#define SAMPLE_PAGE_URL @"https://192.168.60.136:8443/demo/ios/msso_web_sample.jsp"
#define EXP_PAGE_URL @"http://192.168.1.236:8080/demo/ios/exp_mobilesso.jsp"
#define SAMPLE_PAGE_URL @"http://192.168.1.236:8080/demo/ios/msso_web_sample.jsp"
#define ALERT_TITLE @"SafeIdentity Mobile Alert"
#define CONFIRM_TITLE @"SafeIdentity Mobile Confirm"

@implementation CommonUtil
@synthesize userId = _userId;
@synthesize userPwd = _userPwd;
@synthesize ssoTokenKey = _ssoTokenKey;
@synthesize rHttpLastErrorMSG = _rHttpLastErrorMSG;
@synthesize rSSOLastErrorMSG = _rSSOLastErrorMSG;
//@synthesize authIdResult = _authIdResult;
@synthesize loginResult = _loginResult;
@synthesize verifyResult = _verifyResult;
@synthesize secIdFlag = _secIdFlag;
//@synthesize ssoToken = _ssoToken;

+(NSString *) clientIp {
    return CLIENT_IP;
}

+(NSString *) expPageUrl {
    return EXP_PAGE_URL;
}

+(NSString *) samplePageUrl {
    return SAMPLE_PAGE_URL;
}

+(NSString *) alertTitle {
    return ALERT_TITLE;
}

+(NSString *) confirmTitle {
    return CONFIRM_TITLE;
}

+(NSUUID *) appUUID {
    return [[UIDevice currentDevice] identifierForVendor];
}

// trim 관련 메서드
//- (NSString *)ltrim:(NSString *) iData
//{
//	NSCharacterSet *cs = [NSCharacterSet whitespaceAndNewlineCharacterSet];
//	NSUInteger len = [iData length];
//	int i;
//	for (i=0; i < len; i++)
//	{
//		unichar c = [iData characterAtIndex:i];
//		if ( [cs characterIsMember:c] == NO ) break;
//	}
//	
//	NSString *trimmed = [iData substringFromIndex:i];
//	
//	return trimmed;
//}
//
//- (NSString *)rtrim:(NSString *) iData
//{
//	NSCharacterSet *cs = [NSCharacterSet whitespaceAndNewlineCharacterSet];
//	NSUInteger len = [iData length];
//	int i;
//	for (i=(len-1); i >= 0; i--)
//	{
//		unichar c = [iData characterAtIndex:i];
//		if ( [cs characterIsMember:c] == NO ) break;
//	}
//	
//	NSString *trimmed = [iData substringToIndex:i+1];
//	
//	return trimmed;
//}
//
//- (NSString *)trim:(NSString *) iData
//{
//	NSCharacterSet *cs = [NSCharacterSet whitespaceAndNewlineCharacterSet];
//	NSUInteger len = [iData length];
//	int start, end;
//	unichar c;
//	
//	for (start=0; start < len; start++)
//	{
//		c = [iData characterAtIndex:start];
//		if ( [cs characterIsMember:c] == NO ) break;
//	}
//	
//	for (end=(len-1); end >= start; end--)
//	{
//		c = [iData characterAtIndex:end];
//		if ( [cs characterIsMember:c] == NO ) break;
//	}
//	
//	NSRange r = NSMakeRange(start, end-start+1);
//	NSString *trimmed = [iData substringWithRange:r];
//	
//	return trimmed;
//}

@end
