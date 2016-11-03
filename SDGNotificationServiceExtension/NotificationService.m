//
//  NotificationService.m
//  SDGNotificationServiceExtension
//
//  Created by Bc.whi1te_Lei on 2016/10/27.
//  Copyright © 2016年 Bc.whi1te_Lei. All rights reserved.
//


#import "NotificationService.h"

@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService
/**
 让你可以在后台处理接收到的推送，传递最终的内容给 contentHandler
 重写这个方法，来重写你的通知内容，也可以在这里下载附件内容
 @param request        <#request description#>
 @param contentHandler <#contentHandler description#>
 */
- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    
    // Modify the notification content here...
    self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [modified]", self.bestAttemptContent.title];
    self.bestAttemptContent.subtitle = [NSString stringWithFormat:@"%@ [modified]",self.bestAttemptContent.subtitle];
    
    self.bestAttemptContent.categoryIdentifier = @"category1";
    self.bestAttemptContent.sound = [UNNotificationSound soundNamed:@"haveorder.wav"];
    
    self.contentHandler(self.bestAttemptContent);
}


/**
 在你获得的一小段运行代码的时间即将结束的时候，如果仍然没有成功的传入内容，会走到这个方法，可以在这里传肯定不会出错的内容，或者他会默认传递原始的推送内容
 */
- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    
    
    self.contentHandler(self.bestAttemptContent);
}

@end

