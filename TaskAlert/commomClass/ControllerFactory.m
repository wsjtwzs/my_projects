//
//  ControllerFactory.m
//  moshTicket
//
//  Created by 魔时网 on 13-11-13.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import "ControllerFactory.h"
#import "TaskViewController.h"  

@implementation ControllerFactory

+ (UIViewController *) taskViewControllerWithTaskNotification:(TaskNotificationModel *)model
{
    return [[TaskViewController alloc] initWithNibName:NSStringFromClass([TaskViewController class]) bundle:nil taskNotificationModel:model];
}

@end
