//
//  SOAComponentAppDelegate.h
//  BridgeLabiPhone
//
//  Created by liuyang on 9/20/16.
//  Copyright © 2016 redcat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SOANotificationService.h"


@interface SOAComponentAppDelegate : NSObject

+ (instancetype)instance;

- (NSMutableArray*)services; 

@end
