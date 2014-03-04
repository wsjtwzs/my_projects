//
//  TaskVIewModel.h
//  TaskAlert
//
//  Created by wuzhensong on 14-2-22.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import "BaseModel.h"

@interface TaskVIewModel : BaseModel

@property (nonatomic, strong) UIImage       *headImage;
@property (nonatomic, strong) NSString      *title;
@property (nonatomic, strong) NSString      *subtitle;
@property (nonatomic, strong) NSMutableArray *taskArray;

//+ (TaskVIewModel *) taskViewModelWithDictronary:(NSDictionary *)dic;
-(id) initWithDictionary:(NSDictionary*) jsonObject;
@end
