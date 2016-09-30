//
//  AppDelegate.m
//  iOS-10-NotificationTest
//
//  Created by Bc.whi1te_Lei on 2016/9/26.
//  Copyright © 2016年 Bc.whi1te_Lei. All rights reserved.
//

#import "AppDelegate.h"

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#import <UserNotifications/UNUserNotificationCenter.h>
#endif

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self registerNotification:application];
    
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
#pragma mark - Notification Method

/**
 注册通知相关
 
 identifier：行为标识符，用于调用代理方法时识别是哪种行为。
 title：行为名称。
 UIUserNotificationActivationMode：即行为是否打开APP。
 authenticationRequired：是否需要解锁。
 destructive：这个决定按钮显示颜色，YES的话按钮会是红色。
 behavior：点击按钮文字输入，是否弹出键盘

 @param application UIApplication
 */
- (void)registerNotification:(UIApplication *)application{
    
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
            //iOS10特有
            UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
            // 必须写代理，不然无法监听通知的接收与点击
            center.delegate = self;
            [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert |
                                                     UNAuthorizationOptionBadge |
                                                     UNAuthorizationOptionSound)
                                  completionHandler:^(BOOL granted, NSError * _Nullable error) {
                if (granted) {
                    // 点击允许
                    NSLog(@"注册成功");
                    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                    //获取用户setting权限
                    NSLog(@"%@", settings);
                    }];
                } else {
                    // 点击不允许
                    NSLog(@"注册失败");
                }
            }];
        }else if ([[UIDevice currentDevice].systemVersion floatValue] >=8.0){
            //iOS8 - iOS10
            [application registerUserNotificationSettings:
             [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeBadge
                                               categories:nil]];
            
        }else if ([[UIDevice currentDevice].systemVersion floatValue] < 8.0) {
            //iOS8系统以下
            [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge |
                                                            UIRemoteNotificationTypeAlert |
                                                            UIRemoteNotificationTypeSound];
        }
        // 注册获得device Token
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    
 
   
}

#pragma mark deviceToken_Delegate

/**
 获得Device Token 成功

 @param application UIApplication
 @param deviceToken deviceToken
 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{

    NSString *deviceTokenStr = [[[[deviceToken description]
                                  stringByReplacingOccurrencesOfString:@"<" withString:@""]
                                 stringByReplacingOccurrencesOfString:@">" withString:@""]
                                stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"deviceTokenStr:%@",deviceTokenStr);
}

/**
 获得Device Token失败

 @param application UIApplication
 @param error       error
 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
#pragma mark UNNotificationDelegate-收到通知


/**
 iOS10处理通知

 @param center            UNUserNotificationCenter
 @param notification      UNNotification
 @param completionHandler 设置推送通知类型
 */
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    
    // 这里真实需要处理交互的地方
    // 获取通知所带的数据

    NSDictionary * userInfo = notification.request.content.userInfo;
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSLog(@"iOS10 前台收到远程通知:%@", userInfo);
       
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}


/**
 iOS10以下通知处理

 @param application UIApplication
 @param userInfo    userInfo
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"iOS6及以下系统，收到通知:%@", userInfo);
}



#pragma mark UNNotificationDelegate-点击通知


/**
 在没有启动本App时，收到服务器推送消息，下拉消息会有快捷回复的按钮，点击按钮后调用的方法

 @param center            UNUserNotificationCenter
 @param response          UNNotificationResponse
 @param completionHandler 设置推送通知类型
 */
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void(^)())completionHandler{
    
    //根据identifier来判断点击的哪个按钮
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSLog(@"iOS10 收到远程通知:%@",userInfo);
        
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
    // Warning: UNUserNotificationCenter delegate received call to -userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler: but the completion handler was never called.
    completionHandler();  // 系统要求执行这个方法
    
}

/**
 远程推送APP在前台处理点击 (ios 新增)

 @param application       UIApplication
 @param userInfo          userInfo
 @param completionHandler 设置推送通知类型（前台一般不需要追加badge）
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    
    NSLog(@"didReceiveRemoteNotification:%@",userInfo);

    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
}
@end
