//
//  WebViewController.h
//  SecureOn-SSO-iOS
//
//  Created by 성찬우 on 2020/04/06.
//  Copyright © 2020 성찬우. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonUtil.h"

NS_ASSUME_NONNULL_BEGIN

@interface WebViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *urlText;    //url 객체
@property (weak, nonatomic) IBOutlet UIWebView *ssoWebView;   //웨뷰

-(IBAction)goURL:(id)sender;    //이동 버튼 처리 메서드
-(IBAction)barButtonClick:(id)sender;   //탭바 버튼 클릭 이벤트 처리 메서드

-(void) webViewDidStartLoad: (UIWebView *) webView; //웹뷰가 시작 될때 호출되는 메서드
-(void) webViewDidFinishLoad: (UIWebView *) webView;    //웹뷰가 끝날때 호출되는 메서드
-(void) webView: (UIWebView *)webView didFailLoadWithError:(NSError *)error;    //웹뷰가 로딩 실패할때 호출되는 메서드

+ (void) setResponseData:(NSMutableData *)aData;
+ (NSMutableData *)responseData;

+ (void) setResponseEncoding:(NSInteger)aValue;
+ (NSInteger)responseEncoding;

+ (void) setCommonUtil:(CommonUtil *)iCommonUtil;   //commonUtil class data 전달 받는 메서드

@end

NS_ASSUME_NONNULL_END
