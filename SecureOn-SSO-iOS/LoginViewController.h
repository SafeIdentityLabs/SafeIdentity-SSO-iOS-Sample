//
//  LoginViewController.h
//  SecureOn-SSO-iOS
//
//  Created by 성찬우 on 2019/11/28.
//  Copyright © 2019 성찬우. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : UIViewController {
    int rHttpLastError; //http 오류 저장 변수
    int rSSOLastError;  //sso
    int initResult;
}

@property (weak, nonatomic) IBOutlet UITextView *secIdTextView;
@property (weak, nonatomic) IBOutlet UITextField *useridTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *typeSegmentedControl;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

NS_ASSUME_NONNULL_END
