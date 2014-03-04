//
//  TaskViewController.h
//  TaskAlert
//
//  Created by 魔时网 on 14-3-3.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import "BaseTableViewController.h"
#import "TaskNotificationModel.h"

@interface TaskViewController : BaseTableViewController<UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic, strong) TaskNotificationModel *taskNoti;
@property (strong, nonatomic) IBOutlet UIView *infoHeaderView;
@property (weak, nonatomic) IBOutlet WSTextField *titleTextField;
@property (weak, nonatomic) IBOutlet WSTextView *alertTextView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil taskNotificationModel:(TaskNotificationModel *)model;

@end
