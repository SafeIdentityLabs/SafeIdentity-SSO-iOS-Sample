//
//  ApiViewController.h
//  SecureOn-SSO-iOS
//
//  Created by 성찬우 on 2020/04/06.
//  Copyright © 2020 성찬우. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonUtil.h"

NS_ASSUME_NONNULL_BEGIN

@interface ApiViewController : UITableViewController

@property (nonatomic, strong) NSArray *ssoApiListData;

+ (void) setCommonUtil:(CommonUtil *)iCommonUtil;   //commonUtil class data 전달 받는 메서드

@end

NS_ASSUME_NONNULL_END
