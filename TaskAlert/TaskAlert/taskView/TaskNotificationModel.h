//
//  TaskNotificationModel.h
//  TaskAlert
//
//  Created by 魔时网 on 14-3-3.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import "MOSHNotificationModel.h"

typedef enum {
    TaskState_successed  = 1,
    TaskState_failed = 2,
    TaskState_unstart = 3,
} TaskState;

@interface TaskNotificationModel : MOSHNotificationModel

@property (nonatomic, strong) NSString      *title;
@property (nonatomic, strong) NSString      *alertBody;
@property (nonatomic, strong) NSString      *tid;
@property (nonatomic, assign) NSInteger     successNumber;
@property (nonatomic, assign) NSInteger     totalNumber;
@property (nonatomic, strong) NSMutableArray *taskStateArray;//完成情况


- (id) initWithDictionary:(NSDictionary *)dic;
/*
 改变task中某日期的完成状态
 */
- (BOOL) changeTaskStateAtIndex:(NSInteger)index withState:(TaskState)state;

@end
