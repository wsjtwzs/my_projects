//
//  HTTPClient+RootVIewData.h
//  TaskAlert
//
//  Created by 魔时网 on 14-2-25.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import "HTTPClient.h"
#import "TaskVIewModel.h"
#import "TaskNotificationModel.h"

@interface HTTPClient (RootVIewData)


- (NSArray *) rootViewData;

- (TaskVIewModel *) addNewTask;

@end
