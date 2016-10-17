//
//  SOANotificationService.m
//  iOS-10-NotificationTest
//
//  Created by Bc.whi1te_Lei on 2016/10/14.
//  Copyright © 2016年 Bc.whi1te_Lei. All rights reserved.
//

#import "SOANotificationService.h"




@interface SOANotificationService ()<UNUserNotificationCenterDelegate>
    
@end

@implementation SOANotificationService

#pragma mark - 生命周期方法
    
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions {
    

    //注册推送
    [self registerNotification:application];
    
    return YES;
}

/**
 获得Device Token 成功
 
 @param application UIApplication
 @param deviceToken deviceToken
 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
   
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
  
/**
 iOS10 app在前台 处理通知
 
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
    
    
    completionHandler(UNNotificationPresentationOptionBadge
                      |UNNotificationPresentationOptionSound
                      |UNNotificationPresentationOptionAlert);
    // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}
    

/**
 iOS10以下 远程通知处理

 @param application       <#application description#>
 @param userInfo          <#userInfo description#>
 @param completionHandler <#completionHandler description#>
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
   
    //TODO:通知的处理
    NSLog(@"below iOS 10 push click");
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
}




/**
 iOS10以下 本地通知处理
 
 @param application UIApplication
 @param notification    notification
 */
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"标题" message:notification.alertBody delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    // 图标上的数字减1
    application.applicationIconBadgeNumber -= 1;
    NSLog(@"iOS6及以下系统，收到通知:%@", notification);
}


#pragma mark UNNotificationDelegate-处理点击通知


/**
 收到服务器推送消息，下拉消息会有快捷回复的按钮，点击按钮后调用的方法
 
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
    
    completionHandler();  // 系统要求执行这个方法
    //否则报错
    // Warning: UNUserNotificationCenter delegate received call to -userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler: but the completion handler was never called.
    
}


#pragma mark action处理
//在非本App界面时收到本地消息，下拉消息会有快捷回复的按钮，点击按钮后调用的方法，根据identifier来判断点击的哪个按钮，notification为消息内容

//iOS8-10之前  处理本地通知点击
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler{
    
    
    completionHandler();
}

//iOS8-10之前  处理远程通知点击
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(nonnull NSDictionary *)userInfo completionHandler:(nonnull void (^)())completionHandler{

    
    completionHandler();
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
                                      //获取用户setting权限
                                      [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                                          NSLog(@"%@", settings);
                                      }];
                                  } else {
                                      // 点击不允许
                                      NSLog(@"注册失败");
                                  }
                              }];
        
        [[UNUserNotificationCenter currentNotificationCenter] setDelegate:self];
        
    }else if ([[UIDevice currentDevice].systemVersion floatValue] >=8.0){
        //iOS8 - iOS10(不含10)
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:
                                                       UIUserNotificationTypeAlert |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeBadge
                                                                                        categories:nil]];
        
        
            }else if ([[UIDevice currentDevice].systemVersion floatValue] < 8.0) {
        //iOS8系统以下
        //check the old API is not available
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
        if ([application respondsToSelector:@selector(registerForRemoteNotificationTypes:)]) {
            [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge |
             UIRemoteNotificationTypeAlert |
             UIRemoteNotificationTypeSound];
        }
    }
#pragma clang diagnostic pop
    
    // 注册获得device Token
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    
}





@end
