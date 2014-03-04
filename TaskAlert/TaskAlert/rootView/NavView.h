//
//  NavView.h
//  VUtest
//
//  Created by mosh on 13-7-30.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

/*
首页视图view
*/

#import <UIKit/UIKit.h>
#import "WSKit.h"
#import "TaskNotificationModel.h"
#import "TaskVIewModel.h"

@protocol NavViewDelegate;

@interface NavView : UIView<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    UITableViewCellEditingStyle _editingStyle;
}

@property (nonatomic, assign) id<NavViewDelegate> delegate;
@property (nonatomic ,strong) TaskVIewModel *model;

@property (weak, nonatomic) UIViewController  *displayCtl;
@property (weak, nonatomic) IBOutlet WSImageView *headImageView;
@property (weak, nonatomic) IBOutlet WSTextField *titleTextField;
@property (weak, nonatomic) IBOutlet WSTextField *subtitleTextField;
@property (weak, nonatomic) IBOutlet WSTableView *taskTableView;

- (id) initWithFrame:(CGRect)frame taskViewModel:(TaskVIewModel *)model displayViewController:(UIViewController *)ctl;
- (void) startWithFrame:(CGRect)frame taskViewModel:(TaskVIewModel *)model displayViewController:(UIViewController *)ctl;

@end


@protocol NavViewDelegate <NSObject>

@optional

- (void) DetailButtonPress:(TaskNotificationModel *)sender;

//长按此页面
- (void) longpressedWithView:(NavView *)view taskViewModel:(TaskVIewModel *)model;

//tableView向上拖拽
- (void) tableViewScrollToTopLongerThanLimit:(NavView *)view;

@end