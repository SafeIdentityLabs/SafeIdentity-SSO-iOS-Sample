//
//  WebViewController.m
//  SecureOn-SSO-iOS
//
//  Created by 성찬우 on 2020/04/06.
//  Copyright © 2020 성찬우. All rights reserved.
//

#import "WebViewController.h"
#import "iposso.h"
#import "CommonUtil.h"
#import "InfoViewController.h"

#define HOME_URL    @"http://192.168.60.136:7070/demo/ios/msso_web_sample.jsp" //홈 버튼에 대한 URL

#define TAG_BACKBUTTON  10
#define TAG_FORWARDBUTTON   20
#define TAG_HOMEBUTTON  30
#define TAG_REFRESHBUTTON   40
#define TAG_STOPBUTTON   50

@interface WebViewController ()

@end

@implementation WebViewController

static CommonUtil *commonUtil;

static NSMutableData    * _responseData = nil;
static NSInteger        _responseEncoding = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    NSLog(@"SsoWebViewController - test : %@", commonUtil.ssoTokenKey);
    NSLog(@"SsoWebViewController - ViewDidLoad..");
    
    NSURL *url = [NSURL URLWithString:_urlText.text];
    NSString *param;
    if ([commonUtil.secIdFlag isEqualToString:@"TRUE"]) {
        param = [NSString stringWithFormat:@"ssoToken=%@&secId=%@", commonUtil.ssoToken, getSecId()];
    } else {
        param = [NSString stringWithFormat:@"ssoToken=%@", commonUtil.ssoToken];
    }
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[param dataUsingEncoding:NSUTF8StringEncoding]];
    [_ssoWebView loadRequest:request];

}

-(IBAction)goURL:(id)sender {
    [_urlText resignFirstResponder];
    
    //sso 로그인이 되어있으면 post로 토큰을 보내어서 로그인 처리
    [_ssoWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlText.text ]]];
}

-(IBAction)barButtonClick:(id)sender {
    NSInteger buttonTag = [sender tag];
    NSLog(@"buttonTag : %d", buttonTag);
    
    switch (buttonTag) {
        case TAG_BACKBUTTON:
            if ([_ssoWebView canGoBack]) {
                [_ssoWebView goBack];
            }
            break;
        case TAG_FORWARDBUTTON:
            if ([_ssoWebView canGoForward]) {
                [_ssoWebView goForward];
            }
            break;
        case TAG_HOMEBUTTON:
            [_ssoWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:HOME_URL]]];
            break;
        case TAG_REFRESHBUTTON:
            if ([_ssoWebView isLoading]) {
                [_ssoWebView stopLoading];
            } else {
                [_ssoWebView reload];
            }
            break;
        case TAG_STOPBUTTON:
            [_ssoWebView stopLoading];
            break;
        default:
            break;
    }
}

-(void) webViewDidStartLoad: (UIWebView *) webView {
    NSLog(@"SsoWebViewController - 웹뷰 로드 시작");
}

-(void) webViewDidFinishLoad: (UIWebView *) webView {
    NSLog(@"SsoWebViewController - 웹뷰 로드 끝");
}

-(void) webView: (UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"SsoWebViewController - 웹뷰 로드 에러시");
}

+ (void) setResponseData:(NSMutableData *)aData
{
    _responseData = aData;
}

+ (NSMutableData *)responseData
{
    return _responseData;
}

+ (void) setResponseEncoding:(NSInteger)aValue
{
    _responseEncoding = aValue;
}


+ (NSInteger)responseEncoding
{
    return _responseEncoding;
}

- (void) connection:(NSURLConnection *) connection
 didReceiveResponse:(NSURLResponse *) response
{
    NSLog(@"didReceiveResponse");
    NSLog (@"[%s:%d] [%@]", __func__, __LINE__, [response textEncodingName]);
    
    // response를 받을 때 페이지의 인코딩 타입을 가져오자.
    if ([[response textEncodingName] isEqualToString:@"euc-kr"] == YES)
    {
        [WebViewController setResponseEncoding:-2147481280];
    }
    else if ([[response textEncodingName] isEqualToString:@"utf-8"] == YES)
    {
        [WebViewController setResponseEncoding:NSUTF8StringEncoding];
    }
}

- (void) connection:(NSURLConnection *) connection
     didReceiveData:(NSData *) data
{
    NSLog(@"didReceiveData");
    // 날아오는 response조각들을 차곡차곡 모으자.
    //[[WebViewController responseData] appendData:data];
    
    NSString *returnString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"return data : %@" , returnString);
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
