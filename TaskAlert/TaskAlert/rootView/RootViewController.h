//
//  ViewController.h
//  VUtest
//
//  Created by mosh on 13-7-30.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavView.h"
#import "BaseViewController.h"

typedef enum{
    NavViewState_close,//收缩状态
    NavViewState_open,//打开状态
    NavViewState_Display,//显示状态
} NavViewState;

@interface RootViewController : BaseViewController<UIAlertViewDelegate,NavViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSMutableArray           *dataArray;//数据源
@property (nonatomic, strong) NSMutableArray     *navArray;//存放视图
@property (nonatomic, assign) NavViewState          state;
//@property (nonatomic, assign) BOOL              isUphold;//是否伸张状态


@end
