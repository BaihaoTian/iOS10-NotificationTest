//
//  ViewController.m
//  iOS-10-NotificationTest
//
//  Created by Bc.whi1te_Lei on 2016/9/26.
//  Copyright © 2016年 Bc.whi1te_Lei. All rights reserved.
//

#import "ViewController.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#import <UserNotifications/UNUserNotificationCenter.h>
#endif
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *pushPicBtn;
@property (weak, nonatomic) IBOutlet UIButton *pushGifBtn;
@property (weak, nonatomic) IBOutlet UIButton *pushVideoBtn;
    @property (weak, nonatomic) IBOutlet UIButton *pushiOS9Noti;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - pushBtn method

- (IBAction)pushAPic:(id)sender {
    NSLog(@"push a pic");
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        // 1.创建通知内容
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = @"闪电购测试通知";
        content.subtitle = @"测试通知";
        content.body = @"来自闪电购";
        content.badge = @1;
        NSError *error = nil;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Icon-29@2x" ofType:@"png"];
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"flv视频测试用例1" ofType:@"mp4"];
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"test1" ofType:@"gif"];

        
        // 2.设置通知附件内容
        
        UNNotificationAttachment *att = [UNNotificationAttachment attachmentWithIdentifier:@"att1"
                                                                                       URL:[NSURL fileURLWithPath:path]
                                                                                   options:nil
                                                                                     error:&error];
        //   option 选项
        //   @{UNNotificationAttachmentOptionsThumbnailHiddenKey:@NO}   是否隐藏缩略图
        //   @{UNNotificationAttachmentOptionsThumbnailClippingRectKey:(__bridge id _Nullable)((CGRectCreateDictionaryRepresentation(CGRectMake(0, 0, 1, 1))))}  剪贴矩形的缩略图 （0-1）
        //   @{UNNotificationAttachmentOptionsThumbnailTimeKey:@10}  应用影片附件时 采用第几秒作为缩略图
        
        
        if (error) {
            NSLog(@"attachment error %@", error);
        }
        content.attachments = @[att];
        content.launchImageName = @"Icon-60@2x";
        // 2.设置声音
        UNNotificationSound *sound = [UNNotificationSound defaultSound];
//        NSString *path1 = [[NSBundle mainBundle] pathForResource:@"haveorder" ofType:@"wav"];
//        UNNotificationSound *sound = [UNNotificationSound soundNamed:path1];
        
        content.sound = sound;
        
        // 3.触发模式
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
        
        // 4.设置UNNotificationRequest
        NSString *requestIdentifer = @"TestPicRequest";
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifer content:content trigger:trigger];
        
        //5.把通知加到UNUserNotificationCenter, 到指定触发点会被触发
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        }];
    }else{
        [self alertTips];
    }
}

- (IBAction)pushAGif:(id)sender {
    NSLog(@"push a gif");
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        // 1.创建通知内容
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = @"闪电购测试通知";
        content.subtitle = @"测试通知";
        content.body = @"来自闪电购";
        content.badge = @1;
        NSError *error = nil;
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"Icon-29@2x" ofType:@"png"];
        //        NSString *path = [[NSBundle mainBundle] pathForResource:@"flv视频测试用例1" ofType:@"mp4"];
                NSString *path = [[NSBundle mainBundle] pathForResource:@"test1" ofType:@"gif"];
        
        
        // 2.设置通知附件内容
        
        UNNotificationAttachment *att = [UNNotificationAttachment attachmentWithIdentifier:@"att1"
                                                                                       URL:[NSURL fileURLWithPath:path]
                                                                                   options:nil
                                                                                     error:&error];
        //   option 选项
        //   @{UNNotificationAttachmentOptionsThumbnailHiddenKey:@NO}   是否隐藏缩略图
        //   @{UNNotificationAttachmentOptionsThumbnailClippingRectKey:(__bridge id _Nullable)((CGRectCreateDictionaryRepresentation(CGRectMake(0, 0, 1, 1))))}  剪贴矩形的缩略图 （0-1）
        //   @{UNNotificationAttachmentOptionsThumbnailTimeKey:@10}  应用影片附件时 采用第几秒作为缩略图
        
        
        if (error) {
            NSLog(@"attachment error %@", error);
        }
        content.attachments = @[att];
        content.launchImageName = @"Icon-60@2x";
        // 2.设置声音
//        UNNotificationSound *sound = [UNNotificationSound defaultSound];
                NSString *path1 = [[NSBundle mainBundle] pathForResource:@"deliveryorder" ofType:@"mp3"];
                UNNotificationSound *sound = [UNNotificationSound soundNamed:path1];
        
        content.sound = sound;
        
        // 3.触发模式
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1 repeats:NO];
        
        // 4.设置UNNotificationRequest
        NSString *requestIdentifer = @"TestGifRequest";
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifer content:content trigger:trigger];
        
        //5.把通知加到UNUserNotificationCenter, 到指定触发点会被触发
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        }];
    }else{
        [self alertTips];
    }
}

- (IBAction)pushAVideo:(id)sender {
    NSLog(@"push a video");
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        // 1.创建通知内容
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = @"闪电购测试通知";
        content.subtitle = @"测试通知";
        content.body = @"来自闪电购";
        content.badge = @1;
        NSError *error = nil;
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"Icon-29@2x" ofType:@"png"];
                NSString *path = [[NSBundle mainBundle] pathForResource:@"flv视频测试用例1" ofType:@"mp4"];
        //        NSString *path = [[NSBundle mainBundle] pathForResource:@"test1" ofType:@"gif"];
        
        
        // 2.设置通知附件内容
        
        UNNotificationAttachment *att = [UNNotificationAttachment attachmentWithIdentifier:@"att1"
                                                                                       URL:[NSURL fileURLWithPath:path]
                                                                                   options:nil
                                                                                     error:&error];
        //   option 选项
        //   @{UNNotificationAttachmentOptionsThumbnailHiddenKey:@NO}   是否隐藏缩略图
        //   @{UNNotificationAttachmentOptionsThumbnailClippingRectKey:(__bridge id _Nullable)((CGRectCreateDictionaryRepresentation(CGRectMake(0, 0, 1, 1))))}  剪贴矩形的缩略图 （0-1）
        //   @{UNNotificationAttachmentOptionsThumbnailTimeKey:@10}  应用影片附件时 采用第几秒作为缩略图
        
        
        if (error) {
            NSLog(@"attachment error %@", error);
        }
        content.attachments = @[att];
        content.launchImageName = @"Icon-60@2x";
        // 2.设置声音
        UNNotificationSound *sound = [UNNotificationSound defaultSound];
        //        NSString *path1 = [[NSBundle mainBundle] pathForResource:@"haveorder" ofType:@"wav"];
        //        UNNotificationSound *sound = [UNNotificationSound soundNamed:path1];
        
        content.sound = sound;
        
        // 3.触发模式
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1 repeats:NO];
        
        // 4.设置UNNotificationRequest
        NSString *requestIdentifer = @"TestVideoRequest";
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifer content:content trigger:trigger];
        
        //5.把通知加到UNUserNotificationCenter, 到指定触发点会被触发
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        }];
    }else{
        [self alertTips];
    }

}

//- (void)scheduleNotification{
//    UILocalNotification *notification = [[UILocalNotification alloc] init];
//    //设置5秒之后
//    NSDate *pushDate = [NSDate dateWithTimeIntervalSinceNow:5];
//    if (notification != nil) {
//        // 设置推送时间（5秒后）
//        notification.fireDate = pushDate;
//        // 设置时区（此为默认时区）
//        notification.timeZone = [NSTimeZone defaultTimeZone];
//        // 设置重复间隔（默认0，不重复推送）
//        notification.repeatInterval = 0;
//        // 推送声音（系统默认）
//        notification.soundName = UILocalNotificationDefaultSoundName;
//        // 推送内容
//        notification.alertBody = @"推送主体内容";
//        //显示在icon上的数字
//        notification.applicationIconBadgeNumber = 1;
//        //设置userinfo 方便在之后需要撤销的时候使用
//        NSDictionary *info = [NSDictionary dictionaryWithObject:@"name"forKey:@"key"];
//        notification.userInfo = info;
//        //添加推送到UIApplication
//        UIApplication *app = [UIApplication sharedApplication];
//        [app scheduleLocalNotification:notification];
//    }
//}

    

#pragma mark - alert 
- (void)alertTips{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"请使用iOS10以上的机器尝试新的推送"  delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
