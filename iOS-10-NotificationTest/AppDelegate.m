//
//  AppDelegate.m
//  iOS-10-NotificationTest
//
//  Created by Bc.whi1te_Lei on 2016/9/26.
//  Copyright © 2016年 Bc.whi1te_Lei. All rights reserved.
//

#import "AppDelegate.h"
#import "SOAComponentAppDelegate.h"

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    /*
     * service 代码
     */
    id<UIApplicationDelegate> service;
    for (service in [SOAComponentAppDelegate instance].services) {
        if ([service respondsToSelector:@selector(application:didFinishLaunchingWithOptions:)]){
        [service application:application didFinishLaunchingWithOptions:launchOptions];
        }
    }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



#pragma mark deviceToken_Delegate

/**
 获得Device Token 成功

 @param application UIApplication
 @param deviceToken deviceToken
 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{

    
    NSLog(@"didRegisterForRemoteNotificationsWithDeviceToken");
    /*
     * service 代码
     */
    id<UIApplicationDelegate> service;
    for (service in [SOAComponentAppDelegate instance].services) {
        if ([service respondsToSelector:@selector(application:didRegisterForRemoteNotificationsWithDeviceToken:)]){
        [service application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
        }
    }
}

/**
 获得Device Token失败

 @param application UIApplication
 @param error       error
 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"didFailToRegisterForRemoteNotificationsWithError");

    /*
     * service 代码
     */
    id<UIApplicationDelegate> service;
    for (service in [SOAComponentAppDelegate instance].services) {
        if ([service respondsToSelector:@selector(application:didFailToRegisterForRemoteNotificationsWithError:)]){
        [service application:application didFailToRegisterForRemoteNotificationsWithError:error];
        }
    }
}
    
    
#pragma mark UNNotificationDelegate-收到通知

/**
 iOS10 app在前台 处理通知

 @param center            UNUserNotificationCenter
 @param notification      UNNotification
 @param completionHandler 设置推送通知类型
 */
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    /*
     * service 代码
     */
    id<UIApplicationDelegate> service;
    for (service in [SOAComponentAppDelegate instance].services) {
        
        if ([service respondsToSelector:@selector(userNotificationCenter:willPresentNotification:withCompletionHandler:)]){
            
            [(SOANotificationService *)service userNotificationCenter:center willPresentNotification:notification withCompletionHandler:completionHandler];
        }
    }
}

    
/**
 iOS10以下 远程通知处理
 
 @param application       UIApplication
 @param userInfo          userInfo
 @param completionHandler 设置推送通知类型（前台一般不需要追加badge）
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    
    /*
     * service 代码
     */
    id<UIApplicationDelegate> service;
    for (service in [SOAComponentAppDelegate instance].services) {
        if ([service respondsToSelector:@selector(application:didReceiveRemoteNotification:fetchCompletionHandler:)]){
            
            [service application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
        }
    }
}

/**
 iOS10以下 本地通知处理
 
 @param application UIApplication
 @param notification    notification
 */
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    /*
     * service 代码
     */
    id<UIApplicationDelegate> service;
    for (service in [SOAComponentAppDelegate instance].services) {
        if ([service respondsToSelector:@selector(application:didReceiveLocalNotification:)]){
            
            [service application:application didReceiveLocalNotification:notification];
        }
    }
}

    
#pragma mark UNNotificationDelegate-处理通知的交互

/**
 iOS 10 远程&&本地 通知的处理
 收到服务器推送消息，下拉消息会有快捷回复的按钮，点击按钮后调用的方法

 @param center            UNUserNotificationCenter
 @param response          UNNotificationResponse
 @param completionHandler 设置推送通知类型
 */
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void(^)())completionHandler{
    
    /*
     * service 代码
     */
    id<UIApplicationDelegate> service;
    for (service in [SOAComponentAppDelegate instance].services) {
        if ([service respondsToSelector:@selector(userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler:)]){
            
            [(SOANotificationService *)service userNotificationCenter:center didReceiveNotificationResponse:response withCompletionHandler:completionHandler];
        }
    }
}


//在非本App界面时收到推送消息，下拉消息会有快捷回复的按钮，点击按钮后调用的方法，根据identifier来判断点击的哪个按钮，notification为消息内容

/**
 iOS8-9  处理本地通知点击

 @param application       <#application description#>
 @param identifier        <#identifier description#>
 @param notification      <#notification description#>
 @param completionHandler <#completionHandler description#>
 */
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler{
    /*
     * service 代码
     */
    id<UIApplicationDelegate> service;
    for (service in [SOAComponentAppDelegate instance].services) {
        if ([service respondsToSelector:@selector(application:handleActionWithIdentifier:forLocalNotification:completionHandler:)]){
            
            [service application:application handleActionWithIdentifier:identifier forLocalNotification:notification completionHandler:completionHandler];
        }
    }
}
    
//

/**
 iOS8-9  处理远程通知点击

 @param application       <#application description#>
 @param identifier        <#identifier description#>
 @param userInfo          <#userInfo description#>
 @param completionHandler <#completionHandler description#>
 */
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(nonnull NSDictionary *)userInfo completionHandler:(nonnull void (^)())completionHandler{
    /*
     * service 代码
     */
    id<UIApplicationDelegate> service;
    for (service in [SOAComponentAppDelegate instance].services) {
        if ([service respondsToSelector:@selector(application:handleActionWithIdentifier:forRemoteNotification:completionHandler:)]){
            
            [service application:application handleActionWithIdentifier:identifier forRemoteNotification:userInfo completionHandler:completionHandler];
        }
    }
}

@end
