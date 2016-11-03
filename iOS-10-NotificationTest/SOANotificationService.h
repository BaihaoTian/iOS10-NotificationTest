//
//  SOANotificationService.h
//  iOS-10-NotificationTest
//
//  Created by Bc.whi1te_Lei on 2016/10/14.
//  Copyright © 2016年 Bc.whi1te_Lei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIApplication.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#import <UserNotifications/UNUserNotificationCenter.h>
#endif
#import <UIKit/UIUserNotificationSettings.h>

@interface SOANotificationService : NSObject <UIApplicationDelegate, UIAlertViewDelegate, UNUserNotificationCenterDelegate>


//iOS10 app在前台 处理通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler;

//iOS10 处理交互
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void(^)())completionHandler;
@end
