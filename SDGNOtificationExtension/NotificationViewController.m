//
//  NotificationViewController.m
//  SDGNOtificationExtension
//
//  Created by Bc.whi1te_Lei on 2016/10/12.
//  Copyright © 2016年 Bc.whi1te_Lei. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>

@interface NotificationViewController () <UNNotificationContentExtension>

@property IBOutlet UILabel *label;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"1234567");

    // Do any required interface initialization here.
}

- (void)didReceiveNotification:(UNNotification *)notification {
    self.label.text = notification.request.content.body;
    NSLog(@"1234567");
}

@end
