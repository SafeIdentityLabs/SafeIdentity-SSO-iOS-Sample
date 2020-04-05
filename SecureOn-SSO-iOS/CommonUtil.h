//
//  Common.h
//  MSSOSample
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CommonUtil : NSObject <UIAlertViewDelegate> {
    NSString *userId;
    NSString *userPwd;
    NSString *ssoTokenKey;
    NSString *ssoToken;
    NSString *rHttpLastErrorMSG;
    NSString *rSSOLastErrorMSG;
//    NSString *authIdResult;
    NSString *loginResult;
    NSString *verifyResult;
}

@property (nonatomic, strong) NSString *userId; //사용자 ID
@property (nonatomic, strong) NSString *userPwd;    //사용자 패스워드
@property (nonatomic, strong) NSString *ssoTokenKey;    //사용자 토큰키
@property (nonatomic, strong) NSString *ssoToken;   //사용자 토큰
@property (nonatomic, strong) NSString *rHttpLastErrorMSG;   //http 에러 코드
@property (nonatomic, strong) NSString *rSSOLastErrorMSG;    //SSO 에러 코드
//@property (nonatomic, strong) NSString *authIdResult;       //authId 결과값
@property (nonatomic, strong) NSString *loginResult;        //login 결과값
@property (nonatomic, strong) NSString *verifyResult;       //verify Token 결과값
@property (nonatomic, strong) NSString *secIdFlag;

+(NSString *) clientIp; //사용자IP
+(NSString *) expPageUrl;   //모바일 sso 통신 페이지
+(NSString *) samplePageUrl;    //웹 테스트 페이지 URL
+(NSString *) alertTitle;   //SSO 경고 창 타이틀 문구
+(NSString *) confirmTitle;   //SSO 확인 창 타이틀 문구

//- (NSString *)ltrim:(NSString *)iData;
//- (NSString *)rtrim:(NSString *)iData;
//- (NSString *)trim:(NSString *)iData;

@end
