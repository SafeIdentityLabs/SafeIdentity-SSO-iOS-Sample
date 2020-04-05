//
//  InfoViewController.m
//  SecureOn-SSO-iOS
//
//  Created by 성찬우 on 2020/04/06.
//  Copyright © 2020 성찬우. All rights reserved.
//

#import "InfoViewController.h"
#import "iposso.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

static CommonUtil *commonUtil;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    initResult = -1;
    
    //verify token 함
    //토큰이 있는지 확인 및 있는 경우 검증 후 로그인 처리
    if (commonUtil.ssoToken != nil || commonUtil.ssoToken != NULL) {

        if ([commonUtil.secIdFlag isEqualToString:@"TRUE"]) {
            [commonUtil setVerifyResult:ipo_sso_verify_token(commonUtil.ssoToken, [CommonUtil clientIp], getSecId())];
        } else {
            [commonUtil setVerifyResult:ipo_sso_verify_token(commonUtil.ssoToken, [CommonUtil clientIp], nil)];
        }
        
        [self setLastError:commonUtil];
        
        if (rHttpLastError < 200 || rHttpLastError > 300) {
            NSLog(@"SsoAppViewController - rHttpLastError error.");
        }
        
        if (rSSOLastError != 0) {
            NSLog(@"SsoAppViewController - rSSOLastError error.");
        } else {
            initResult = 0;
            [commonUtil setUserId:commonUtil.verifyResult];
            _useridTextField.text = commonUtil.userId;
        }
    }else {
        NSLog(@"SsoAppViewController - Token is null. LoginViewController redirect.");
    }
    
    if (initResult == -1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }

}

-(void) setLastError:(CommonUtil *)commonUtil {
    rHttpLastError = getHttpLastError();
    rSSOLastError = getSSOLastError();
    [commonUtil setRHttpLastErrorMSG:[NSString stringWithFormat:@"HTTP 에러코드 : %d",rHttpLastError]];
    [commonUtil setRSSOLastErrorMSG:[NSString stringWithFormat:@"SSO 에러코드 : %d", rSSOLastError]];
    
    NSLog(@"SsoAppViewController - HTTP Return Code : %d", rHttpLastError);
    NSLog(@"SsoAppViewController - commonUtil.rHttpLastErrorMSG : %@", commonUtil.rHttpLastErrorMSG);
    NSLog(@"SsoAppViewController - SSO Return Code : %d", rSSOLastError);
    NSLog(@"SsoAppViewController - commonUtil.rSSOLastErrorMSG : %@", commonUtil.rSSOLastErrorMSG);
}

- (void)setupUI {
        
    // 아이디 필드
    _useridTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 17, 20)];;
    _useridTextField.leftViewMode = UITextFieldViewModeAlways;
    _useridTextField.layer.borderWidth = 1.0f;
    _useridTextField.layer.borderColor = UIColor.lightGrayColor.CGColor;
    _useridTextField.layer.cornerRadius = 24.0f;

    // 로그인 버튼
    _logoutButton.layer.cornerRadius = 24.0f;
    
    // SSO 버튼
    _ssoButton.layer.cornerRadius = 24.0f;

}

+ (void) setCommonUtil:(CommonUtil *)iCommonUtil {
    commonUtil = iCommonUtil;
}

#pragma mark - Event

- (IBAction)logout:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"로그아웃" message:@"로그아웃 하시겠습니까?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* logoutAction = [UIAlertAction actionWithTitle:@"로그아웃" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        ipo_sso_logout(commonUtil.ssoTokenKey);     //sso logout
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"취소" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:logoutAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];

}

- (IBAction)openApp:(id)sender {
    // 다른 앱을 열기
    NSString *issoaURL = [NSString stringWithFormat:@"issoa://?sso_token=%@", commonUtil.ssoToken];
    NSLog(@"issoaURL - %@", issoaURL);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:issoaURL]];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"HELLO"]) {
        
    } else if ([segue.identifier isEqualToString:@""]) {
        NSString *issoaURL = [NSString stringWithFormat:@"issoa://?sso_token=%@", commonUtil.ssoToken];
        
        NSLog(@"MSSOSample - issoaURL - %@", issoaURL);
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:issoaURL]];

    }
}

@end

