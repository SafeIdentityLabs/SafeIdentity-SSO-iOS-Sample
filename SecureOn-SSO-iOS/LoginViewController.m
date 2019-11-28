//
//  LoginViewController.m
//  SecureOn-SSO-iOS
//
//  Created by 성찬우 on 2019/11/28.
//  Copyright © 2019 성찬우. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    [self setupUI];
}

- (void)setupUI {
        
    // 아이디 필드
    _idTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 17, 20)];;
    _idTextField.leftViewMode = UITextFieldViewModeAlways;
    _idTextField.layer.borderWidth = 1.0f;
    _idTextField.layer.borderColor = UIColor.lightGrayColor.CGColor;
//    _idTextField.layer.borderColor = [UIColor colorWithRed:0.04 green:0.23 blue:0.66 alpha:1.0].CGColor;
    _idTextField.layer.cornerRadius = 24.0f;

    // 비밀번호 필드
    _passwordTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 17, 20)];;
    _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    _passwordTextField.layer.borderWidth = 1.0f;
    _passwordTextField.layer.borderColor = UIColor.lightGrayColor.CGColor;
//    _passwordTextField.layer.borderColor = [UIColor colorWithRed:0.04 green:0.23 blue:0.66 alpha:1.0].CGColor;
    _passwordTextField.layer.cornerRadius = 24.0f;
    
    // Express, Standard, Enterprise
    _typeSegmentedControl.layer.cornerRadius = 24.0f;

    // 로그인 버튼
    _loginButton.layer.cornerRadius = 24.0f;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
