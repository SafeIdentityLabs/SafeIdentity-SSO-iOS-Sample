//
//  AppDelegate.m
//  SecureOn-SSO-iOS
//
//  Created by 성찬우 on 2019/11/27.
//  Copyright © 2019 성찬우. All rights reserved.
//

#import "AppDelegate.h"
#import "iposso.h"
#import "CommonUtil.h"
#import "LoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {

    if( !url ) {
        return NO;
    }
        
    NSLog(@"AppDelegate - url.absoluteString: %@", url.absoluteString);
    NSLog(@"AppDelegate - url query : %@", [url query]);
    
    //ssoToken이 있으면 값 세팅
    NSString *ssoToken = [url query];
    
    if (ssoToken != nil && ssoToken != NULL) {
        NSLog(@"AppDelegate - ssotoken is not null.");
        
        NSString *ssoTokenKey = ipo_sso_init([CommonUtil expPageUrl]);
        ssoToken = [ssoToken substringFromIndex:9];
        NSLog(@"AppDelegate - ssoToken : %@", ssoToken);
        
        ipo_set_ssotoken(ssoToken, ssoTokenKey);
        ipo_sso_verify_token(ssoToken, [CommonUtil clientIp], getSecId());
    } else {
        NSLog(@"AppDelegate - ssoToken is null and web income");
        NSString *samplePageUrl = [NSString stringWithFormat:@"http://192.168.1.236:8080/demo/ios/msso_auth_id_sample.jsp?secId=%@", getSecId()];
        NSURL *sampleUrl = [[NSURL alloc] initWithString:samplePageUrl];
        [[UIApplication sharedApplication] openURL:sampleUrl];
        return NO;
    }

    NSString *UrlString = [url absoluteString];
    
    [[NSUserDefaults standardUserDefaults] setObject:UrlString forKey:@"url"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
