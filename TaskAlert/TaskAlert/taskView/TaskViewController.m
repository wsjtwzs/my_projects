//
//  TaskViewController.m
//  TaskAlert
//
//  Created by 魔时网 on 14-3-3.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import "TaskViewController.h"
#import "TaskNotificationModel.h"
#import "MOSHLocalNotification.h"
#import "MOSHNotificationModel.h"

#define HOURTIMEINTERVAL 60*60
#define DAYTIMEINTERVAL 24*HOURTIMEINTERVAL
#define WEEKTIMEINTERVAL 7*DAYTIMEINTERVAL

static NSString *alertBody = @"请输入提醒信息";
static NSString *headerStr = @"时间计划";

static CGFloat pickerViewHeight = 246.0f;

@interface TaskViewController ()

@end

@implementation TaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil taskNotificationModel:(TaskNotificationModel *)model
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.taskNoti = model;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createBarWithLeftBarItem:MoshNavigationBarItemBack rightBarItem:MoshNavigationBarItemNone title:NAVTITLE_TASK];
    
    self.titleTextField.text = self.taskNoti.title;
    if ([GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:self.alertTextView.text]) {
        self.alertTextView.text = self.taskNoti.alertBody;
    }
    else {
        self.alertTextView.text = alertBody;
    }
    [self initWithTableView];
    [self initWithPickerView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - privateAction -
- (void) initWithTableView
{
    self.baseTableView.tableHeaderView = self.infoHeaderView;
}

- (void) initWithPickerView
{
    self.pickerView = [[WSDatePickerView alloc] initWithFrame:CGRectMake(POINT_X, SCREENHEIGHT, SCREENWIDTH, pickerViewHeight)];
    self.pickerView.delegate = self;
    [self.view addSubview:self.pickerView];
}
- (void) addNewDate
{
    [self.pickerView showPickerViewWithDate:nil animated:NO];
}

//日期
- (NSArray *) everyDateWithNotification:(UILocalNotification *)noti
{
    NSMutableArray *array = [NSMutableArray array];
    
    NSDate *date = noti.fireDate;
    
    [array addObject:date];
    
    NSDateComponents *com = [[NSDateComponents alloc] init];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *currentDate = [NSDate date];
    
    switch (noti.repeatInterval) {
        case NSCalendarUnitHour:
            [com setHour:1];
            break;
        case NSCalendarUnitDay:
            [com setDay:1];
            break;
        case NSCalendarUnitWeekday:
            [com setWeek:1];
            break;
        case NSCalendarUnitMonth:
            [com setMonth:1];
            break;
        default:
            break;
    }
    NSDate *nextDate = [calendar dateByAddingComponents:com toDate:date options:0];
    NSDate *nextCurrentDate = [calendar dateByAddingComponents:com toDate:currentDate options:0];
    while (nextDate <= nextCurrentDate) {
        [array addObject:nextDate];
        nextDate = [calendar dateByAddingComponents:com toDate:nextDate options:0];
    }
    return array;
}

#pragma  mark - tableViewDelegate -
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [GlobalConfig createViewWithFrame:CGRectMake(0, 0, tableView.frame.size.width, [self tableView:tableView heightForHeaderInSection:section])];
    
    UIButton *add = [UIButton buttonWithType:UIButtonTypeContactAdd];
    add.frame = CGRectMake(10, 0,view.frame.size.height, view.frame.size.height);
    [add addTarget:self action:@selector(addNewDate) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:add];
    
    
    UILabel *label = [GlobalConfig createLabelWithFrame:CGRectMake(add.frame.origin.x + add.frame.size.width, 0, SCREENWIDTH - 10 -(add.frame.origin.x + add.frame.size.width) ,view.frame.size.height) Text:headerStr FontSize:14 textColor:BLACKCOLOR];
    label.textAlignment = NSTextAlignmentRight;
    [view addSubview:label];
    
    return view;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    UILocalNotification *noti = [MOSHLocalNotification notificationIsExited:self.taskNoti];
    if (noti) {
        if (noti.repeatInterval != 0) {
            return [self everyDateWithNotification:noti].count;
        }
        else {
            return 1;
        }
    }
    else {
        return 0;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"date";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    UILocalNotification *noti = [MOSHLocalNotification notificationIsExited:self.taskNoti];
    NSArray *array = [self everyDateWithNotification:noti];
    cell.textLabel.text = [GlobalConfig date:array[indexPath.row] format:DATEFORMAT_02];
    
    return cell;
}

#pragma mark - textViewDelegate -
- (void) textFieldDidEndEditing:(UITextField *)textField
{
    if ([GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:textField.text]) {
        self.taskNoti.title = textField.text;
    }
}

- (void) textViewDidEndEditing:(UITextView *)textView
{
    if ([GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:textView.text]) {
        self.taskNoti.alertBody = textView.text;
    }
    else {
        textView.text = alertBody;
    }
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:alertBody]) {
        textView.text = nil;
    }
    return YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark - pickerViewDelegate -
- (void) selectDate:(NSDate *)date startDate:(NSDate *)startDate
{
    if ([GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:self.titleTextField.text Alert:@"亲，您还没有填写任务名哦"]) {
        
        //找到原消息
        NSString *alertBody = self.titleTextField.text;
        if ([GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:self.alertTextView.text]) {
            alertBody = self.alertTextView.text;
        }
        
        TaskNotificationModel *noti = [[TaskNotificationModel  alloc] init];
        noti.fireDate = startDate;
        noti.alertBody = alertBody;
        noti.title = self.titleTextField.text;
        
        UILocalNotification *localNoti = [MOSHLocalNotification notificationIsExited:noti];
        
        
        if (localNoti) {
            
            noti.fireDate = date;
            noti.repeatInterval = localNoti.repeatInterval;
            
            [MOSHLocalNotification deleteNotification:localNoti];
            [MOSHLocalNotification addNotification:noti];
            
        }
        else {
            noti.fireDate = date;
            [MOSHLocalNotification addNotification:noti];
        }
    }
}

//- (NSInteger) selectData
@end
