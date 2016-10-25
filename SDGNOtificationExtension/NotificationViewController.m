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

@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // Do any required interface initialization here.
}

- (void)didReceiveNotification:(UNNotification *)notification {
    
    self.TitleLabel.text = notification.request.content.title;
    self.subtitleLabel.text = notification.request.content.subtitle;
    self.messageLabel.text = notification.request.content.body;
    
//    [self.imageView setImage:[UIImage imageNamed:@"123.jpeg"]];
    
    
}

@end
