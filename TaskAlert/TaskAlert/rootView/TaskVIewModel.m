//
//  TaskVIewModel.m
//  TaskAlert
//
//  Created by wuzhensong on 14-2-22.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import "TaskVIewModel.h"

@implementation TaskVIewModel

//+ (TaskVIewModel *) taskViewModelWithDictronary:(NSDictionary *)dic
//{
//    TaskVIewModel *model = [[TaskVIewModel   alloc] setValuesForKeysWithDictionary:dic];
//    model.headImage = [UIImage imageNamed:@"header"];
//    return model;
//}

-(id) initWithDictionary:(NSDictionary*) jsonObject
{
    if((self = [super init]))
    {
        [self setValuesForKeysWithDictionary:jsonObject];
        self.headImage = [UIImage imageNamed:@"header"];
    }
    return self;
}

- (void) setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"task"]) {
        self.taskArray = [NSMutableArray arrayWithArray:value];
    }
    else {
        [super setValue:value forUndefinedKey:key];
    }
}

@end
