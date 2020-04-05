//
//  LoginViewController.m
//  SecureOn-SSO-iOS
//
//  Created by 성찬우 on 2019/11/28.
//  Copyright © 2019 성찬우. All rights reserved.
//

#import "LoginViewController.h"
#import "InfoViewController.h"
#import "WebViewController.h"
#import "ApiViewController.h"
#import "iposso.h"
#import "CommonUtil.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

static CommonUtil *commonUtil;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    
    commonUtil = [[CommonUtil alloc] init];

    //plist 읽어오기
    NSString *configPath = [[NSBundle mainBundle] pathForResource:@"sso_config" ofType:@"plist"];
    NSDictionary *configDic = [[NSDictionary alloc] initWithContentsOfFile:configPath];
    [commonUtil setSecIdFlag:[configDic objectForKey:@"SEC_ID_FLAG"]];
    NSLog(@"LoginViewController - SEC_ID_FLAG : %@", commonUtil.secIdFlag);
        
    NSString *secId;
    if ([commonUtil.secIdFlag isEqualToString:@"TRUE"]) {
        secId = getSecId();
        self.secIdTextView.editable = NO;
        self.secIdTextView.text = secId;
    }
    
    initResult = -1;
    
    //sso 초기화
    [commonUtil setSsoTokenKey:ipo_sso_init([CommonUtil expPageUrl])];
    
    [self setLastError:commonUtil];
    
    if (rHttpLastError < 200 || rHttpLastError > 300) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[CommonUtil alertTitle] message:commonUtil.rHttpLastErrorMSG preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
        [alertController addAction:defaultAction];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    
    if(rSSOLastError !=0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[CommonUtil alertTitle] message:commonUtil.rSSOLastErrorMSG preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
        [alertController addAction:defaultAction];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    } else {
        NSLog(@"LoginViewController - MSSO Sample SSO init success..");
        
        //ssoToken 가져오기
        [commonUtil setSsoToken:ipo_get_ssotoken(commonUtil.ssoTokenKey)];
        
        //토큰이 있는지 확인 및 있는 경우 검증 후 로그인 처리
        if (commonUtil.ssoToken != nil || commonUtil.ssoToken != NULL) {
            
            if ([commonUtil.secIdFlag isEqualToString:@"TRUE"]) {
                [commonUtil setVerifyResult:ipo_sso_verify_token(commonUtil.ssoToken, [CommonUtil clientIp], getSecId())];
            } else {
                [commonUtil setVerifyResult:ipo_sso_verify_token(commonUtil.ssoToken, [CommonUtil clientIp], nil)];
            }
            
            NSLog(@"LoginViewController - verifyResult : %@", commonUtil.verifyResult);

            [self setLastError:commonUtil];
            
            if (rHttpLastError < 200 || rHttpLastError > 300) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[CommonUtil alertTitle] message:commonUtil.rHttpLastErrorMSG preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
                [alertController addAction:defaultAction];
                [self presentViewController:alertController animated:YES completion:nil];
                return;
            }
            
            if (rSSOLastError != 0) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[CommonUtil alertTitle] message:commonUtil.rSSOLastErrorMSG preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
                [alertController addAction:defaultAction];
                [self presentViewController:alertController animated:YES completion:nil];
                return;
            } else {
                NSLog(@"LoginViewController - Verify Success and userID setting..");
                initResult = 0;
                [commonUtil setUserId:commonUtil.verifyResult];

                [InfoViewController setCommonUtil:(CommonUtil *) commonUtil];
                [ApiViewController setCommonUtil:(CommonUtil *) commonUtil];
                [WebViewController setCommonUtil:(CommonUtil *) commonUtil];
                
                [self performSelector:@selector(loadNextViewController) withObject:nil afterDelay:0];
            }
        } else {
            NSLog(@"LoginViewController - SSO Token is no exist..");
        }
    }
}

-(void)loadNextViewController
{
    [self performSegueWithIdentifier:@"TabBarSegue" sender:self];
}

- (void)setupUI {
        
    // 아이디 필드
    _useridTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 17, 20)];;
    _useridTextField.leftViewMode = UITextFieldViewModeAlways;
    _useridTextField.layer.borderWidth = 1.0f;
    _useridTextField.layer.borderColor = UIColor.lightGrayColor.CGColor;
    _useridTextField.layer.cornerRadius = 24.0f;

    // 비밀번호 필드
    _passwordTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 17, 20)];;
    _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    _passwordTextField.layer.borderWidth = 1.0f;
    _passwordTextField.layer.borderColor = UIColor.lightGrayColor.CGColor;
    _passwordTextField.layer.cornerRadius = 24.0f;
    
    // Express, Standard, Enterprise
    _typeSegmentedControl.layer.cornerRadius = 24.0f;

    // 로그인 버튼
    _loginButton.layer.cornerRadius = 24.0f;
}

//rHttpLastError, rSSOLastError 변수에 값 세팅
-(void) setLastError:(CommonUtil *)commonUtil {
    rHttpLastError = getHttpLastError();
    rSSOLastError = getSSOLastError();
    [commonUtil setRHttpLastErrorMSG:[NSString stringWithFormat:@"HTTP 에러코드 : %d",rHttpLastError]];
    [commonUtil setRSSOLastErrorMSG:[NSString stringWithFormat:@"SSO 에러코드 : %d", rSSOLastError]];
    
    NSLog(@"LoginViewController - HTTP Return Code : %d", rHttpLastError);
    NSLog(@"LoginViewController - commonUtil.rHttpLastErrorMSG : %@", commonUtil.rHttpLastErrorMSG);
    NSLog(@"LoginViewController - SSO Return Code : %d", rSSOLastError);
    NSLog(@"LoginViewController - commonUtil.rSSOLastErrorMSG : %@", commonUtil.rSSOLastErrorMSG);
}

#pragma mark - TextField Delegate

//return 키 이벤트 처리 메서드
- (BOOL) textFieldShouldReturn:(UITextField *) textField
{
    if (textField == _useridTextField) {
        [_passwordTextField becomeFirstResponder];    //사용자 ID에서 패스워드 텍스트필드로 이동
    }else {
        [textField resignFirstResponder];
    }
    return NO;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"TabBarSegue"]) {
        
        if (initResult == 0) {
            return;
        }
        
        NSInteger selectSsoVersion = [self.typeSegmentedControl selectedSegmentIndex];
        //ID가 없는 경우
        if (self.useridTextField.text.length == 0) {
            [self.useridTextField becomeFirstResponder]; //focus 가져오기
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[CommonUtil alertTitle] message:@"사용자 ID를 입력하세요." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
            [alertController addAction:defaultAction];
            [self presentViewController:alertController animated:YES completion:nil];
            return;
        }

        commonUtil.userId = [NSString stringWithFormat:@"%@", self.useridTextField.text];
               
        if (selectSsoVersion == -1) {
           UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[CommonUtil alertTitle] message:@"SSO Version을 선택하세요." preferredStyle:UIAlertControllerStyleAlert];
           UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
           [alertController addAction:defaultAction];
           [self presentViewController:alertController animated:YES completion:nil];
           return;
        } else if (selectSsoVersion == 0) {
           if ([commonUtil.secIdFlag isEqualToString:@"TRUE"]) {
               commonUtil.loginResult = ipo_sso_make_simple_token(@"3", commonUtil.userId,  CommonUtil.clientIp, getSecId());
           } else {
               commonUtil.loginResult = ipo_sso_make_simple_token(@"3", commonUtil.userId,  CommonUtil.clientIp, nil);
           }
        } else if (selectSsoVersion == 1) {
           if ([commonUtil.secIdFlag isEqualToString:@"TRUE"]) {
               commonUtil.loginResult = ipo_sso_reg_user_session(commonUtil.userId, CommonUtil.clientIp, @"TRUE", getSecId());
           } else {
               commonUtil.loginResult = ipo_sso_reg_user_session(commonUtil.userId, CommonUtil.clientIp, @"TRUE", nil);
           }
        } else if (selectSsoVersion == 2) {
           //PWD가 없는 경우
           if (self.passwordTextField.text.length == 0) {
               [self.passwordTextField becomeFirstResponder];
               UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[CommonUtil alertTitle] message:@"사용자 패스워드를 입력하세요." preferredStyle:UIAlertControllerStyleAlert];
               UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
               [alertController addAction:defaultAction];
               [self presentViewController:alertController animated:YES completion:nil];
               return;
           }
           
           commonUtil.userPwd = [NSString stringWithFormat:@"%@", self.passwordTextField.text];
           
           if ([commonUtil.secIdFlag isEqualToString:@"TRUE"]) {
               commonUtil.loginResult = ipo_sso_auth_id(commonUtil.userId, commonUtil.userPwd, @"TRUE", CommonUtil.clientIp, getSecId());
           } else {
               commonUtil.loginResult = ipo_sso_auth_id(commonUtil.userId, commonUtil.userPwd, @"TRUE", CommonUtil.clientIp, nil);
           }
        }

        commonUtil.loginResult = ipo_sso_make_simple_token(@"PutKey-PutValuesdata1234*", commonUtil.loginResult, CommonUtil.clientIp, getSecId());

        [self setLastError:commonUtil];

        if (rHttpLastError < 200 || rHttpLastError > 300) {
           UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[CommonUtil alertTitle] message:commonUtil.rHttpLastErrorMSG preferredStyle:UIAlertControllerStyleAlert];
           UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
           [alertController addAction:defaultAction];
           [self presentViewController:alertController animated:YES completion:nil];
           return;
        }

        if(rSSOLastError !=0) {
           UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[CommonUtil alertTitle] message:commonUtil.rSSOLastErrorMSG preferredStyle:UIAlertControllerStyleAlert];
           UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
           [alertController addAction:defaultAction];
           [self presentViewController:alertController animated:YES completion:nil];
           return;
        } else {
           // 로그인 성공
           commonUtil.ssoToken = commonUtil.loginResult;
           ipo_set_ssotoken(commonUtil.ssoToken, commonUtil.ssoTokenKey);
           
           [InfoViewController setCommonUtil:(CommonUtil *) commonUtil];
           [ApiViewController setCommonUtil:(CommonUtil *) commonUtil];
           [WebViewController setCommonUtil:(CommonUtil *) commonUtil];
        }

    }
}

@end
