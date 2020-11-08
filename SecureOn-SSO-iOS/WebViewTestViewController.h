//
//  WebViewTestViewController.h
//  SecureOn-SSO-iOS
//
//  Created by 성찬우 on 2020/11/09.
//  Copyright © 2020 성찬우. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebViewTestViewController : UIViewController <WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler>

@property (weak, nonatomic) IBOutlet UIButton *setTokenButton;
@property (nonatomic, strong) WKWebView *wkWebView;

@end

NS_ASSUME_NONNULL_END
