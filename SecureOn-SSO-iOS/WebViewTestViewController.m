//
//  WebViewTestViewController.m
//  SecureOn-SSO-iOS
//
//  Created by 성찬우 on 2020/11/09.
//  Copyright © 2020 성찬우. All rights reserved.
//

#import "WebViewTestViewController.h"
#import "iposso.h"

@interface WebViewTestViewController ()

@end

@implementation WebViewTestViewController

NSString *token = @"djaskldjsa890du30ejd2jd890jcsdosdfu89ewjd";

- (void)viewDidLoad {
    [super viewDidLoad];

    // WKWebView 크기 조절
    CGRect frame = self.view.frame;
    frame.size.height = frame.size.height - 80;
    frame.origin.y = frame.origin.y + 80;
    
    WKWebViewConfiguration  *config = [[WKWebViewConfiguration alloc]init];
    WKUserContentController *jsctrl = [[WKUserContentController alloc]init];
    
    [jsctrl addScriptMessageHandler:self name:@"callbackHandler"];
    [config setUserContentController:jsctrl];

    self.wkWebView = [[WKWebView alloc] initWithFrame:frame configuration:config];
    [self.wkWebView setNavigationDelegate:self];
    [self.wkWebView setUIDelegate:self];
    [self.view addSubview:self.wkWebView];

    NSURL *fileURL = [NSBundle.mainBundle URLForResource:@"WebViewTest" withExtension:@"html"];
    [self.wkWebView loadFileURL:fileURL allowingReadAccessToURL:fileURL];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {

    if ([message.name isEqualToString:@"callbackHandler"]) {
        NSLog(@"Javascript is sending a message %@", message.body);
        [self.setTokenButton setTitle:message.body forState: UIControlStateNormal];
    }
}

- (IBAction) setTokenButtonPressed:(id)sender {
    
    [self.wkWebView evaluateJavaScript:[NSString stringWithFormat:@"setToken('%@', '%@')", token, getSecId()] completionHandler:^(NSString *result, NSError *error) {
        NSLog(@" evaluateJavaScript result : %@", result);
        NSLog(@" evaluateJavaScript error  : %@", error);
    }];
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    NSLog(@"runJavaScriptAlertPanelWithMessage : %@", message);

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        completionHandler();
    }]];
    [self presentViewController:alertController animated:YES completion:^{}];
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
