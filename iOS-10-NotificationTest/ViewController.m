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
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1 repeats:NO];
        
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
        UNNotificationSound *sound = [UNNotificationSound defaultSound];
        //        NSString *path1 = [[NSBundle mainBundle] pathForResource:@"haveorder" ofType:@"wav"];
        //        UNNotificationSound *sound = [UNNotificationSound soundNamed:path1];
        
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
