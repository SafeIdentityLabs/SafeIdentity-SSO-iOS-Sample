//
//  SsoUtil.h
//  iposso
//


#import <Foundation/Foundation.h>

@interface SsoUtil : NSObject

//null 체크 메서드
+(NSString *)checkNull:(NSString *)str;
//number 체크 메서드
+(BOOL)isNumber:(NSString *)str;
// trim 관련 메서드
+(NSString *)ltrim:(NSString *)iData;
+(NSString *)rtrim:(NSString *)iData;
+(NSString *)trim:(NSString *)iData;
@end
