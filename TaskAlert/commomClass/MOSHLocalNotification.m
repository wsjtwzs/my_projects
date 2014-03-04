//
//  MOSHLocalNotification.m
//  fenice
//
//  Created by 魔时网 on 13-12-3.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import "MOSHLocalNotification.h"
#import "GlobalConfig.h"

@implementation MOSHLocalNotification

//判断某个通知提醒是否存在
+ (UILocalNotification*)notificationIsExited:(UILocalNotification *)noti
{
    NSArray *allNotifications = [[UIApplication sharedApplication]scheduledLocalNotifications];
//    MOSHLog(@"notiCount = %d",allNotifications.count);
    
    for(UILocalNotification *notification in allNotifications){
        if ([notification.userInfo isEqualToDictionary:[noti userInfo]]) {
            return notification;
        }
    }
    return nil;
}

+ (BOOL) notificationIsMoreThanLimit
{
     NSArray *allNotifications = [[UIApplication sharedApplication]scheduledLocalNotifications];
    if (allNotifications.count >= 60) {
        return YES;
    }
    return NO;
}

+ (AddNotificationResult)addNotification:(UILocalNotification *)noti
{
    //超过限制
    if ([self notificationIsMoreThanLimit]) {
        return AddNotificationResult_fail_moreThanLimit;
    }
    
    UILocalNotification *notification = [MOSHLocalNotification notificationIsExited:noti];
    
    //如果没找到该通知提醒
    if(!notification){
        
        //注册通知条件 大于 当前时间
        if ([noti.fireDate compare:[NSDate date]] == NSOrderedDescending) {
            
           return [self addLocalNotification:noti];
            
            }
        else {
            return AddNotificationResult_fail_earlierThanCurrentTime;
        }
    }
    else {
        //如果已注册提醒时间与现有时间不相同 则删除原有的 添加新提醒
        if(([notification.fireDate compare:noti.fireDate] != NSOrderedSame) && ([noti.fireDate compare:[NSDate date]] == NSOrderedDescending)){
            [[UIApplication sharedApplication] cancelLocalNotification:notification];
            return  [self addLocalNotification:noti];
        }
        else {
            return AddNotificationResult_fail_earlierThanCurrentTime;
        }
        
    }
}

+ (AddNotificationResult) addLocalNotification:(UILocalNotification *)noti
{
    
    //超过限制
    if ([self notificationIsMoreThanLimit]) {
        return AddNotificationResult_fail_moreThanLimit;
    }
    
    
    //注册提醒
    if(noti){
      
        [[UIApplication sharedApplication]scheduleLocalNotification:noti];
        
        return AddNotificationResult_success;
    }
    else {
        return  AddNotificationResult_fail;
    }

}

+ (void) deleteNotification:(UILocalNotification *)noti
{
   UILocalNotification *notification = [MOSHLocalNotification notificationIsExited:noti];
    //如果找到该通知提醒
    if(notification){
        // 删除订阅
        [[UIApplication sharedApplication]cancelLocalNotification:notification];
    }
}

+ (void) deletteAllNotification
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

@end
    
    
    
