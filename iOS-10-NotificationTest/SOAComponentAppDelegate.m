//
//  SOAComponentAppDelegate.m
//  BridgeLabiPhone
//
//  Created by liuyang on 9/20/16.
//  Copyright © 2016 redcat. All rights reserved.
//

#import "SOAComponentAppDelegate.h"
#import <UIKit/UIApplication.h>

//#import "SOASystemConfigService.h"
//#import "SOAUmengService.h"
//#import "SOAiConsoleService.h"
//#import "SOABaiduService.h"
@interface SOAComponentAppDelegate()<UNUserNotificationCenterDelegate>

@end

@implementation SOAComponentAppDelegate {
    NSMutableArray<id<UIApplicationDelegate>>* allServices;
}

-(void)registeServices {
//    [self registeService:[[SOASystemConfigService alloc] init]];
    [self registeService:[[SOANotificationService alloc] init]];
//    [self registeService:[[SOAUmengService alloc] init]];
//    [self registeService:[[SOAiConsoleService alloc] init]];
//    [self registeService:[[SOABaiduService alloc] init]];
}

#pragma mark - 获取SOAComponent单实例

+ (instancetype)instance {
    static SOAComponentAppDelegate *insance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        insance = [[SOAComponentAppDelegate alloc] init];
    });
    return insance;
}

#pragma mark - 获取全部服务

-(NSMutableArray *)services {
    if (!allServices) {
        allServices = [[NSMutableArray alloc]init];
        [self registeServices];
    }
    return allServices;
}

#pragma mark - 服务动态注册

-(void)registeService:(id<UIApplicationDelegate>)service {
    if (![allServices containsObject:service]) {
        [allServices addObject:service];
    }
}  


@end
