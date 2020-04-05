//
//  ApiTestViewController.h
//  SecureOn-SSO-iOS
//
//  Created by 성찬우 on 2020/04/06.
//  Copyright © 2020 성찬우. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonUtil.h"

NS_ASSUME_NONNULL_BEGIN

@interface ApiTestViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *apiTestModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel *scopeLabel;
@property (weak, nonatomic) IBOutlet UILabel *roleSearchLabel;

@property (weak, nonatomic) IBOutlet UITextField *apiTestModeText;
@property (weak, nonatomic) IBOutlet UITextField *firstText;
@property (weak, nonatomic) IBOutlet UITextField *secondText;

@property (weak, nonatomic) IBOutlet UISegmentedControl *scopeSegment;
@property (weak, nonatomic) IBOutlet UISegmentedControl *roleSearchSegment;

@property (weak, nonatomic) IBOutlet UITextView *retTextView;

@property (nonatomic, strong) NSString *apiTestModeValue;

-(IBAction)ssoApiExcute:(id)sender; //실행 버튼 이벤트
-(void)selectModeView:(int)modeVal; //화면 감추는 메서드

-(void)putValueAction;
-(void)getValueAction;
-(void)getAllValuesAction;
-(void)userPwdInitAction;
-(void)userModifyPwdAction;
-(void)userSearchAction;
-(void)userViewAction;
-(void)getUserRoleListAction;
-(void)getResourcePermissionAction;
-(void)getResourceListAction;

+ (void) setCommonUtil:(CommonUtil *)iCommonUtil;   //commonUtil class data 전달 받는 메서드

@end

NS_ASSUME_NONNULL_END
