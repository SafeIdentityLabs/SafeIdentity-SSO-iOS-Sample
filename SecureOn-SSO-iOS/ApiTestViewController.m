//
//  ApiTestViewController.m
//  SecureOn-SSO-iOS
//
//  Created by 성찬우 on 2020/04/06.
//  Copyright © 2020 성찬우. All rights reserved.
//

#import "ApiTestViewController.h"
#import "SsoUtil.h"
#import "iposso.h"

@interface ApiTestViewController ()

@end

@implementation ApiTestViewController

static CommonUtil *commonUtil;
NSString *logTag = @"SsoApiTestViewController -";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.apiTestModeText setText:[NSString stringWithFormat:@"%@", self.apiTestModeValue]];
    self.retTextView.editable = NO;
    self.retTextView.text = @"";
    
    if ([self.apiTestModeValue isEqualToString:@"putValue()"]) {
        [self.firstLabel setText:@"태그명"];
        [self.secondLabel setText:@"태그값"];
        [self selectModeView:1];
    } else if ([self.apiTestModeValue isEqualToString:@"getValue()"]) {
        [self.firstLabel setText:@"태그명"];
        [self.secondLabel setText:@"index"];
        [self selectModeView:1];
    } else if ([self.apiTestModeValue isEqualToString:@"getAllValues()"] || [self.apiTestModeValue isEqualToString:@"userView()"] || [self.apiTestModeValue isEqualToString:@"getUserRoleList()"]) {
        [self selectModeView:0];
    } else if ([self.apiTestModeValue isEqualToString:@"userPwdInit()"]) {
        [self.firstLabel setText:@"사용자 ID"];
        [self.secondLabel setText:@"패스워드"];
        self.secondText.secureTextEntry = YES;
        [self selectModeView:1];
    } else if ([self.apiTestModeValue isEqualToString:@"userModifyPwd()"]) {
        [self.firstLabel setText:@"기존 패스워드"];
        [self.secondLabel setText:@"신규 패스워드"];
        self.firstText.secureTextEntry = YES;
        self.secondText.secureTextEntry = YES;
        [self selectModeView:1];
    } else if ([self.apiTestModeValue isEqualToString:@"userSearch()"]) {
        [self.firstLabel setText:@"사용자 ID"];
        [self selectModeView:2];
    } else if ([self.apiTestModeValue isEqualToString:@"getResourcePermission()"]) {
        [self.firstLabel setText:@"SRDN"];
        [self selectModeView:3];
    } else if ([self.apiTestModeValue isEqualToString:@"getResourceList()"]) {
        [self.firstLabel setText:@"BASE"];
        [self.secondLabel setText:@"PERMISSION"];
    }

}

#pragma mark - TextField Delegate

//키보드 올라올때 이벤트 처리메서드. 여기서는 textField 클릭 시 화면이 올라가도록 함
- (void) textFieldDidBeginEditing:(UITextField *) textField {
    if(textField == self.firstText) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.view.frame = CGRectMake(self.view.frame.origin.x, (self.view.frame.origin.y - 110), self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    } else if (textField == self.secondText) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.view.frame = CGRectMake(self.view.frame.origin.x, (self.view.frame.origin.y - 170), self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }
}

//키보드 내려갈때 이벤트 처리 메서드. 여기서는 뷰를 다시 원위치로 돌림
- (void) textFieldDidEndEditing:(UITextField *)textField {
    if(textField == self.firstText) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.view.frame = CGRectMake(self.view.frame.origin.x, (self.view.frame.origin.y + 110), self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    } else if (textField == self.secondText) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.view.frame = CGRectMake(self.view.frame.origin.x, (self.view.frame.origin.y + 170), self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }
}

-(IBAction)ssoApiExcute:(id)sender {
    if ([self.apiTestModeValue isEqualToString:@"putValue()"]) {
        [self putValueAction];
    } else if ([self.apiTestModeValue isEqualToString:@"getValue()"]) {
        [self getValueAction];
    } else if ([self.apiTestModeValue isEqualToString:@"getAllValues()"]) {
        [self getAllValuesAction];
    } else if ([self.apiTestModeValue isEqualToString:@"userPwdInit()"]) {
        [self userPwdInitAction];
    } else if ([self.apiTestModeValue isEqualToString:@"userModifyPwd()"]) {
        [self userModifyPwdAction];
    } else if ([self.apiTestModeValue isEqualToString:@"userSearch()"]) {
        [self userSearchAction];
    } else if ([self.apiTestModeValue isEqualToString:@"userView()"]) {
        [self userViewAction];
    } else if ([self.apiTestModeValue isEqualToString:@"getUserRoleList()"]) {
        [self getUserRoleListAction];
    } else if ([self.apiTestModeValue isEqualToString:@"getResourcePermission()"]) {
        [self getResourcePermissionAction];
    } else if ([self.apiTestModeValue isEqualToString:@"getResourceList()"]) {
        [self getResourceListAction];
    }
}

//화면 감추는 메서드
-(void)selectModeView:(int)modeVal {
    if (modeVal == 0) {
        [self.firstLabel setHidden:YES];
        [self.firstText setHidden:YES];
        [self.secondLabel setHidden:YES];
        [self.secondText setHidden:YES];
        [self.scopeLabel setHidden:YES];
        [self.roleSearchLabel setHidden:YES];
        [self.scopeSegment setHidden:YES];
        [self.roleSearchSegment setHidden:YES];
    } else if (modeVal == 1) {
        [self.scopeLabel setHidden:YES];
        [self.roleSearchLabel setHidden:YES];
        [self.scopeSegment setHidden:YES];
        [self.roleSearchSegment setHidden:YES];
    } else if (modeVal == 2) {
        [self.secondLabel setHidden:YES];
        [self.secondText setHidden:YES];
        [self.scopeLabel setHidden:YES];
        [self.roleSearchLabel setHidden:YES];
        [self.scopeSegment setHidden:YES];
        [self.roleSearchSegment setHidden:YES];
    } else if (modeVal == 3) {
        [self.secondLabel setHidden:YES];
        [self.secondText setHidden:YES];
        [self.scopeLabel setHidden:YES];
        [self.scopeSegment setHidden:YES];
    }
}

-(void)putValueAction {
    NSLog(@"%@ putValueAction start..", logTag);
    NSString *tagName, *tagValue;
    NSString *retStr;
    tagName = self.firstText.text;
    tagValue = self.secondText.text;
    
    if (tagName == nil || [tagName isEqualToString:@""]) {
        [self.firstText becomeFirstResponder]; //focus 가져오기
        [self alert:@"태그명을 입력하세요."];
        return;
    }
    
    if (tagValue == nil || [tagValue isEqualToString:@""]) {
        [self.secondText becomeFirstResponder];
        [self alert:@"태그값을 입력하세요."];
        return;
    }
    
    retStr = ipo_sso_put_value(tagName, tagValue, ipo_get_ssotoken(commonUtil.ssoTokenKey));
    NSLog(@"%@ putValueAction retStr : %@", logTag, retStr);
    self.retTextView.text = retStr;
}
-(void)getValueAction {
    NSLog(@"%@ getValueAction start..",logTag);
    NSString *tagName, *index;
    NSString *retStr;
    
    tagName = self.firstText.text;
    index = self.secondText.text;
    
    if (tagName == nil || [tagName isEqualToString:@""]) {
        [self.firstText becomeFirstResponder];
        [self alert:@"태그명을 입력하세요."];
        return;
    }
    
    if (index == nil || [index isEqualToString:@""]) {
        index = @"0";
    } else {
        if (![SsoUtil isNumber:index]) {
            [self.secondText setText:@""];
            [self.secondText becomeFirstResponder];
            [self alert:@"index에는 숫자만 입력 가능합니다."];
            return;
        }
    }
    
    if ([commonUtil.secIdFlag isEqualToString:@"TRUE"]) {
        retStr = ipo_sso_get_value(tagName, [index intValue], ipo_get_ssotoken(commonUtil.ssoTokenKey), [CommonUtil clientIp], getSecId());
    } else {
        retStr = ipo_sso_get_value(tagName, [index intValue], ipo_get_ssotoken(commonUtil.ssoTokenKey), [CommonUtil clientIp], nil);
    }
    NSLog(@"%@ getValueAction retStr : %@", logTag, retStr);
    self.retTextView.text = retStr;
}
-(void)getAllValuesAction {
    NSLog(@"%@ getAllValuesAction start", logTag);
    NSString *retStr;
    
    if ([commonUtil.secIdFlag isEqualToString:@"TRUE"]) {
        retStr = ipo_sso_get_all_values(ipo_get_ssotoken(commonUtil.ssoTokenKey), [CommonUtil clientIp], getSecId());
    } else {
        retStr = ipo_sso_get_all_values(ipo_get_ssotoken(commonUtil.ssoTokenKey), [CommonUtil clientIp], nil);
    }
    
    NSLog(@"%@ getAllValuesAction retStr : %@", logTag, retStr);
    self.retTextView.text = retStr;
}

-(void)userPwdInitAction {
    NSLog(@"%@ userPwdInitAction start..", logTag);
    NSString *userId, *pwd;
    int retInt = -1;
    
    userId = self.firstText.text;
    pwd = self.secondText.text;
    
    if (userId == nil || [userId isEqualToString:@""]) {
        [self.firstText becomeFirstResponder];
        [self alert:@"사용자 ID를 입력하세요."];
        return;
    }
    
    if (pwd == nil || [pwd isEqualToString:@""]) {
        [self.secondText becomeFirstResponder];
        [self alert:@"사용자 패스워드를 입력하세요."];
        return;
    }
    
    retInt = ipo_sso_user_pwd_init(userId, pwd, 0, [CommonUtil clientIp]);
    
    NSLog(@"%@ userPwdInitAction retInt : %d", logTag, retInt);
    self.retTextView.text = [NSString stringWithFormat:@"%d", retInt];
}

-(void)userModifyPwdAction {
    NSLog(@"%@ userModfiyPwdAction start..", logTag);
    
    NSString *currentPwd, *newPwd;
    int retInt = -1;
    
    currentPwd = self.firstText.text;
    newPwd = self.secondText.text;
    
    if (currentPwd == nil || [currentPwd isEqualToString:@""]) {
        [self alert:@"기존 패스워드를 입력하세요."];
        [self.firstText becomeFirstResponder];
        return;
    }
    
    if (newPwd == nil || [newPwd isEqualToString:@""]) {
        [self alert:@"새로운 패스워드를 입력하세요."];
        [self.secondText becomeFirstResponder];
        return;
    }
    
    retInt = ipo_sso_user_modify_pwd(ipo_get_ssotoken(commonUtil.ssoTokenKey), currentPwd, newPwd, [CommonUtil clientIp]);
    
    NSLog(@"%@ userModifyPwdAction retInt : %d", logTag, retInt);
    self.retTextView.text = [NSString stringWithFormat:@"%d", retInt];
}

-(void)userSearchAction {
    NSLog(@"%@ userSearchAction start..", logTag);
    
    NSString *userId;
    int retInt = -1;
    
    userId = self.firstText.text;
    
    if (userId == nil || [userId isEqualToString:@""]) {
        [self alert:@"검색할 사용자를 입력하세요."];
        [self.firstText becomeFirstResponder];
        return;
    }
    
    retInt = ipo_sso_user_search(userId);
    
    NSLog(@"%@ userSearchAction retInt : %d", logTag, retInt);
    self.retTextView.text = [NSString stringWithFormat:@"%d", retInt];
}

-(void)userViewAction {
    NSLog(@"%@ userViewAction start..", logTag);
    
    NSString *retStr;
    
    retStr = ipo_sso_user_view(ipo_get_ssotoken(commonUtil.ssoTokenKey), [CommonUtil clientIp]);
    
    NSLog(@"%@ userViewAction retStr : %@", logTag, retStr);
    self.retTextView.text = retStr;
}

-(void)getUserRoleListAction {
    NSLog(@"%@ getUserRoleListAction start..", logTag);

    NSString *retStr;
    
    retStr = ipo_sso_get_user_role_list(ipo_get_ssotoken(commonUtil.ssoTokenKey), [CommonUtil clientIp]);
    
    NSLog(@"%@ getUserRoleListAction retStr : %@", logTag, retStr);
    self.retTextView.text = retStr;
}

-(void)getResourcePermissionAction {
    NSLog(@"%@ getResourcePermissionAction start..", logTag);
    
    NSString *srdn, *roleSearch;
    NSString *retStr;
    
    srdn = self.firstText.text;
    
    if (srdn == nil || [srdn isEqualToString:@""]) {
        [self alert:@"SRDN을 입력 하세요."];
        [self.firstText becomeFirstResponder];
        return;
    }
    
    if ([self.roleSearchSegment selectedSegmentIndex] == 0) {
        roleSearch = @"TRUE";
    } else {
        roleSearch = @"FALSE";
    }
    
    retStr = ipo_sso_get_resource_permission(srdn, ipo_get_ssotoken(commonUtil.ssoTokenKey), [CommonUtil clientIp], roleSearch);
    
    NSLog(@"%@ getResourcePermissionAction retStr : %@", retStr);
    self.retTextView.text = retStr;
}
-(void)getResourceListAction {
    NSLog(@"%@ getResourceListAction start..", logTag);
    
    NSString *base, *permission, *scope, *roleSearch;
    NSString *retStr;
    
    base = self.firstText.text;
    permission = self.secondText.text;
    
    if (base == nil || [base isEqualToString:@""]) {
        [self.firstText becomeFirstResponder];
        [self alert:@"BASE를 입력하세요."];
        return;
    }
    
    if (permission == nil || [permission isEqualToString:@""]) {
        [self.secondText becomeFirstResponder];
        [self alert:@"Permission을 입력하세요."];
        return;
    }
    
    if ([self.scopeSegment selectedSegmentIndex] == 0) {
        scope = @"ONE";
    } else {
        scope = @"SUB";
    }
    
    if ([self.roleSearchSegment selectedSegmentIndex] == 0) {
        roleSearch = @"TRUE";
    } else {
        roleSearch = @"FALSE";
    }
    
    retStr = ipo_sso_get_resource_list(base, scope, ipo_get_ssotoken(commonUtil.ssoTokenKey), permission, [CommonUtil clientIp], roleSearch);
    
    NSLog(@"%@ getResourceListAction retStr : %@", logTag, retStr);
    self.retTextView.text = retStr;
}

- (void) alert:(NSString *) message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[CommonUtil alertTitle] message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    [alertController addAction:defaultAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


+ (void) setCommonUtil:(CommonUtil *)iCommonUtil {
    commonUtil = iCommonUtil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
