//
//  HTTPClient+RootVIewData.m
//  TaskAlert
//
//  Created by 魔时网 on 14-2-25.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import "HTTPClient+RootVIewData.h"

@implementation HTTPClient (RootVIewData)

- (NSArray *) rootViewData
{
    TaskVIewModel *task1 = [[TaskVIewModel alloc] initWithDictionary:@{@"title":@"减肥大作战",@"subtitle":@"我是一只永远吃吃吃不胖的小鸟",@"task":@[[[TaskNotificationModel alloc] initWithDictionary:@{@"title":@"跑步十公里",@"tid":@"A_1"}]]}];
    
     TaskVIewModel *task2 = [[TaskVIewModel alloc] initWithDictionary:@{@"title":@"锻炼身体 保卫祖国",@"subtitle":@"外练一口气，内练安筋骨皮",@"task":@[[[TaskNotificationModel alloc] initWithDictionary:@{@"title":@"跑步十公里",@"tid":@"B_1"}]]}];
    
     TaskVIewModel *task3 = [[TaskVIewModel alloc] initWithDictionary:@{@"title":@"起床之战",@"subtitle":@"早起的虫儿有鸟吃",@"task":@[[[TaskNotificationModel alloc] initWithDictionary:@{@"title":@"起床之早晨篇",@"tid":@"C_1"}]]}];
    
    return @[task1,task2,task3];
}

- (TaskVIewModel *) addNewTask
{
     TaskVIewModel *task = [[TaskVIewModel alloc] initWithDictionary:@{@"title":@"减肥大作战",@"subtitle":@"我是一只永远吃吃吃不胖的小鸟",@"task":@[[[TaskNotificationModel alloc] initWithDictionary:@{@"title":@"跑步十公里",@"tid":@"A_1"}]]}];
    return task;
}

@end
