//
//  ControllerFactory.h
//  moshTicket
//
//  Created by 魔时网 on 13-11-13.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlobalConfig.h"
#import "HTTPClient.h"

#import "TaskNotificationModel.h"

@interface ControllerFactory : NSObject

+ (UIViewController *) taskViewControllerWithTaskNotification:(TaskNotificationModel *)model;

@end
