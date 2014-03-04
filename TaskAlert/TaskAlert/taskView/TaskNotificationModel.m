//
//  TaskNotificationModel.m
//  TaskAlert
//
//  Created by 魔时网 on 14-3-3.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import "TaskNotificationModel.h"

@implementation TaskNotificationModel

//- (BOOL) changeTaskStateAtIndex:(NSInteger)index withState:(TaskState)state
//{
//    if (index >= 0 && index < self.taskStateArray.count) {
//        
//        [self.taskStateArray replaceObjectAtIndex:index withObject:[NSNumber numberWithInteger:state]];
//        return YES;
//    }
//    else {
//        return NO;
//    }
//}

//+ (TaskModel *) taskModelWithDictionary:(NSDictionary *)dic
//{
//    TaskModel *model = [[TaskModel alloc] init];
//    model.name = dic[@"name"];
//    return model;
//}

- (id) initWithDictionary:(NSDictionary *)dic
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

/*
 *用户信息 作为判断不同提醒的依据
 *子类重写
 */
- (NSDictionary *)getUserInfo
{
    return @{@"title":self.title,@"alert":self.alertBody,@"firedate":self.fireDate};
}


@end
