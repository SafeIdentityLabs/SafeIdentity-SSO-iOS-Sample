# SafeIdentity iOS Sample

## 소개

이 프로젝트는 기존 웹에서 구현되었던 SSO(SafeIdentity)를 아이폰에서 동일한 SSO 환경을 구현하여 앱, 웹에서 SSO 시스템을 구현한 제품입니다. 본 매뉴얼에서는 제공되는 샘플에서의 사용법을 제공하고 API 관련 내용은 API 문서를 참조하시기 바랍니다.

## 시작하기 전

1. 모바일의 콘텐츠를 서비스하는 서버에 SafeAgent를 한컴 시큐어 담당 엔지니어에 설치를 요청

2. WAS 라이브러리 디렉토리에 ServerAPI 라이브러리(jar) 추가

3. exp_mobilesso.jsp 파일을 WAS 서버의 Web 서비스 경로에 파일 업로드

## 빌드 환경

- Xcode Version 11.4 (11E146) 기준
- iOS 9 또는 이후 버전
- Objective C

## 모바일 SSO API

모바일 SSO API에 대한 설명입니다.

### 모바일 SSO 헤더파일

```objectivec
#import "iposso.h"
#import "CommonUtil.h"
```

### 모바일 SSO API 초기화

```objectivec
static CommonUtil *commonUtil;

- (void)viewDidLoad {
    [super viewDidLoad];

    commonUtil = [[CommonUtil alloc] init];
    [commonUtil setSsoTokenKey:ipo_sso_init([CommonUtil expPageUrl])];
}
```

### Security ID 생성

스마트폰의 IP가 고정이 불가능하기 때문에 대안으로 사용되는 기능입니다. 스마트폰의 유니크 아이디를 생성할 수 있다.

```objectivec
NSString *secId = getSecId();
```

### 엔터프라이즈 로그인

암복호화 서비스, 사용자 인증 수행(세션을 유지함), LDAP을 이용한 사용자 신원 확인, 사용자 정보 관리, 권한관리 정보 관리, 사용자 정의 데이터 관리, 계정 정보 관리 등

덮어쓰기 유무는 "true"로 한다.

```objectivec
NSString *loginResult = ipo_sso_auth_id(로그인아이디, 비밀번호, @"TRUE", CommonUtil.clientIp, secId);
```

### 스탠다드 로그인

암복호화 서비스, 사용자 인증 수행(세션을 유지함)

덮어쓰기 유무는 "true"로 한다.

```objectivec
NSString *loginResult = ipo_sso_reg_user_session(로그인아이디, CommonUtil.clientIp, @"TRUE", secId);
```

### 익스프레스 로그인

암복호화 서비스, 사용자 인증 수행(세션을 유지하지 않음)

덮어쓰기 유무는 "true"로 한다.

```objectivec
NSString *loginResult = ipo_sso_make_simple_token(@"3", 아이디, CommonUtil.clientIp, secId);
```

### 토큰 생성

엔터프라이즈, 스탠다드, 익스프레스 등 로그인 후 결과값을 갖고 토큰을 생성 할수 있다.

```objectivec
NSString *token = ipo_sso_make_simple_token(@"PutKey-PutValuesdata1234*", loginResult, CommonUtil.clientIp, secId);
```

### 토큰 검증

저장된 토큰값이 유효한지 확인 하고 로그인 처리 하면 된다.

```objectivec
ipo_sso_verify_token(토큰값, [CommonUtil clientIp], secId);
```

### 로그아웃

```objectivec
ipo_sso_logout(commonUtil.ssoTokenKey);
```

### 웹뷰 -> 네이티브

웹뷰에서 네이티브로 토큰을 넘기는 방법론만 제공 되며 모바일 SSO API를 사용해 응용해서 개발하면 된다. WebViewTestViewController와 WebViewTest.html가 샘플이다.

WebViewTest.html

```javascript
function callNative() {
    try {
        webkit.messageHandlers.callbackHandler.postMessage("{token: 'Your Token', secId: '1234'}");
    } catch(err) {
        alert(err);
    }
}
```

WebViewTestViewController.m

```objectivec
- (void)viewDidLoad {
    [super viewDidLoad];
...
    WKWebViewConfiguration  *webViewConfiguration = [[WKWebViewConfiguration alloc]init];
    WKUserContentController *userContentController = [[WKUserContentController alloc]init];

    // 웹뷰에서 네이티브에 callbackHandler 메시지를 호출
    [userContentController addScriptMessageHandler:self name:@"callbackHandler"];
    [webViewConfiguration setUserContentController:userContentController];
...
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    // 자바스크립트를 통해 던진 메시지를 구분해 처리 한다.
    if ([message.name isEqualToString:@"callbackHandler"]) {
        NSLog(@"Javascript is sending a message %@", message.body);
        [self.setTokenButton setTitle:message.body forState: UIControlStateNormal];
    }
}
```

### 네이티브 -> 웹뷰

네이티브에서 웹뷰로 토큰을 넘기는 방법론만 제공 되며 모바일 SSO API를 사용해 응용해서 개발하면 된다. WebViewTestViewController와 WebViewTest.html가 샘플이다.

WebViewTestViewController.m

```objectivec
- (IBAction) setTokenButtonPressed:(id)sender {
    [self.wkWebView evaluateJavaScript:[NSString stringWithFormat:@"setToken('%@', '%@')", token, getSecId()] completionHandler:^(NSString *result, NSError *error) {
        NSLog(@" evaluateJavaScript result : %@", result);
        NSLog(@" evaluateJavaScript error  : %@", error);
    }];
}
```

WebViewTest.html

```javascript
function setToken(token, secId) 
    document.querySelector('p').innerHTML = "token: " + token + ', secId: ' + secId;
}
```
