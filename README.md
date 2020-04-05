# SafeIdentity iOS Sample

## 소개

이 프로젝트는 기존 웹에서 구현되었던 SSO(SafeIdentity)를 아이폰에서 동일한 SSO 환경을 구현하여 앱, 웹에서 SSO 시스템을 구현한 제품입니다. 본 매뉴얼에서는 제공되는 샘플에서의 사용법을 제공하고 API 관련 내용은 API 문서를 참조하시기 바랍니다.

## 시작하기 전

1. 모바일의 콘텐츠를 서비스하는 서버에 SafeAgent를 한컴 시큐어 담당 엔지니어에 설치를 요청

2. WAS 라이브러리 디렉토리에 ServerAPI 라이브러리(jar) 추가

3. exp_mobilesso.jsp 파일을 WAS 서버의 Web 서비스 경로에 파일 업로드

## 빌드 환경

- Xcode Version 11.4 (11E146) 기준
- Objective C

## 모바일 SSO API

모바일 SSO API에 대한 설명입니다.

### 모바일 SSO 헤더파일

```objectivec
#import "iposso.h"
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
ipo_sso_auth_id(로그인아이디, 비밀번호, @"TRUE", CommonUtil.clientIp, secId);
```

### 스탠다드 로그인

암복호화 서비스, 사용자 인증 수행(세션을 유지함)

덮어쓰기 유무는 "true"로 한다.

```objectivec
ipo_sso_reg_user_session(로그인아이디, CommonUtil.clientIp, @"TRUE", secId);
```

### 익스프레스 로그인

암복호화 서비스, 사용자 인증 수행(세션을 유지하지 않음)

덮어쓰기 유무는 "true"로 한다.

```objectivec
ipo_sso_make_simple_token(@"3", 아이디, CommonUtil.clientIp, secId);
```

### 로그아웃

```objectivec
ipo_sso_logout(commonUtil.ssoTokenKey);
```
