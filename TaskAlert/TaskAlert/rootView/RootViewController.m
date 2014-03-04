//
//  ViewController.m
//  VUtest
//
//  Created by mosh on 13-7-30.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import "RootViewController.h"
#import "GlobalConfig.h"
#import "HTTPClient+RootVIewData.h" 
#import "ControllerFactory.h"

#define DistanceFromTop 70 //第一个cell距离顶部的距离
#define CellWidthSpace  10 //相邻cell之间的宽度差
#define CellheightSpace  100 //展开时相邻cell之间的高度差
#define CellheightStrSpace  60 //合上时相邻cell之间的高度差
#define CellheightSpace_480  80 //展开时相邻cell之间的高度差
#define CellheightStrSpace_480  60 //合上时相邻cell之间的高度差
#define Scale           0.5//滑动比例
#define FirstCellWidth  250 //第一个cell的宽度
#define LastCellWidth  310 //最后一个cell的宽度
#define CellHeightSpace_reduce 15

static CGFloat addButtonWight = 20.0f;
//#define

@interface RootViewController ()

@end

@implementation RootViewController

- (void) viewWillAppear:(BOOL)animated
{
    if (self.state != NavViewState_close) {
        self.state = NavViewState_close;
        [self changeNavViewRect];
    }
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化
    self.view.backgroundColor = [UIColor clearColor];
    [self createTaskViewModel];
    [self createAnimationView];
    
    UIButton *add = [UIButton buttonWithType:UIButtonTypeContactAdd];
    add.frame = CGRectMake(SCREENWIDTH - addButtonWight - 10, [GlobalConfig versionIsIOS7]?20:0, addButtonWight, addButtonWight);
    [add addTarget:self action:@selector(addNewTaskView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:add];
    
    //添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    longPress.delegate = self;
    [self.view addGestureRecognizer:longPress];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

#pragma mark - createView -

- (void) createTaskViewModel
{
    self.dataArray = [NSMutableArray  array];
    
    NSArray *array = [[HTTPClient shareHTTPClient] rootViewData];
    if ([GlobalConfig isKindOfNSArrayClassAndCountGreaterThanZero:array]) {
        [self.dataArray addObjectsFromArray:array];
    }
}

- (void) createAnimationView
{
    self.navArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int i = 0 ;i < self.dataArray.count; i++) {
        
        TaskVIewModel *model = (TaskVIewModel *)self.dataArray[i];
        
        [self createAnimationView:model];
    }
}

- (void) createAnimationView:(TaskVIewModel *)model
{
    NSInteger i = [self.dataArray indexOfObject:model];
    if (i != NSNotFound) {
        CGRect rect = [self cellRectWithCurrentStateOfIndex:i state:NavViewState_close];
        
        NavView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NavView class]) owner:nil options:nil] objectAtIndex:0];
        view.userInteractionEnabled = NO;
        view.delegate = self;
        if ([view isKindOfClass:[NavView class]]) {
            [view startWithFrame:rect taskViewModel:model displayViewController:self];
        }
        [self.view addSubview:view];
        [self.navArray addObject:view];
    }
}


#pragma mark - privateAction -

- (void) tap:(UITapGestureRecognizer *)gesture
{
    
    //找到被点击的view
   NavView *selectView = (NavView *)[self viewOfTap:gesture];
    if (selectView == nil) {
        //点击的空白区域
        return;
    }
    
//点击显示效果
    for (NavView *view in self.navArray) {
        if (view == selectView) {
          [self animationWithView:view rect:[self cellRectWithCurrentStateOfIndex:0 state:NavViewState_Display] duration:0.5];
            view.userInteractionEnabled = YES;
        }
        else {
            [self animationWithView:view rect:CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, SCREENHEIGHT) duration:0.3];
            view.userInteractionEnabled = NO;
        }
    }
    self.state = NavViewState_Display;
    //another显示效果
//    CGPoint point = [gesture locationInView:self.view];
//    
//    NSEnumerator *rator = [self.navArray reverseObjectEnumerator];
//    NavView *view = nil;
//    while (view = [rator nextObject]) {
//        if (CGRectContainsPoint(view.frame, point)) {
//            [self animationWithView:view rect:CGRectMake(0, -10, SCREENWIDTH, SCREENHEIGHT) duration:0.5];
//        }
//        else {
//            [self animationWithView:view rect:CGRectMake(0, SCREENHEIGHT, SCREENWIDTH + 10, SCREENHEIGHT) duration:0.3];
//        }
//    }
}

- (void) longPress:(UIGestureRecognizer *)ges
{
    if (ges.state == UIGestureRecognizerStateBegan) {
        if (self.dataArray.count >= 5) {
            [GlobalConfig alert:ALERT_taskLimit];
            return;
        }
        
        UIAlertView *alect = [[UIAlertView alloc] initWithTitle:@"添加" message:@"是否添加新任务页？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alect show];
    }
    
}

- (void) pan:(UIPanGestureRecognizer *)gesture
{
    CGPoint offset = [gesture translationInView:self.view];
    static CGFloat preOffset;
    if (gesture.state == UIGestureRecognizerStateBegan) {
        preOffset = 0;
        
        //找到被点击的view
        NavView *selectView = (NavView *)[self viewOfTap:gesture];
        if (selectView == nil) {
            //点击的空白区域
            return;
        }
    }
    else  if (gesture.state == UIGestureRecognizerStateChanged) {
        
        //判断最后一个视图的frame如果超过了屏幕就不再滑动
        NavView *lastView = [self.navArray lastObject];
        if (lastView.frame.origin.y < 0) {
            return;
        }
        //视图随手势滑动
        for (NavView *view in self.navArray) {
            //改变frame
            CGRect rect = view.frame;
            rect.origin.y = rect.origin.y + (offset.y - preOffset) * Scale * ([self.navArray indexOfObject:view] + 0.5);
            view.frame = rect;
        }
        
        preOffset = offset.y;
    }
    else if (gesture.state == UIGestureRecognizerStateEnded) {
        
        //判断最后一个视图的frame选择伸张还是收缩状态
        NavView *lastView = [self.navArray lastObject];
        //最后一个视图收缩状态下的frame
        CGRect rect = [self cellRectWithCurrentStateOfIndex:(self.navArray.count - 1) state:NavViewState_close];
        
        self.state = NavViewState_close;
        if (lastView.frame.origin.y >= rect.origin.y + 100) {
            self.state = NavViewState_open;
        }
        [self changeNavViewRect];
    }
}


//被点击的view
- (UIView *) viewOfTap:(UIGestureRecognizer *)gesture
{
    CGPoint point = [gesture locationInView:self.view];
    
    NSEnumerator *rator = [self.navArray reverseObjectEnumerator];
    NavView *view = nil;
    while (view = [rator nextObject]) {
        if (CGRectContainsPoint(view.frame, point)) {
            return view;
        }
    }
    return nil;
}

//根据伸缩状态改变navView的frame
- (void) changeNavViewRect
{
    for (NavView *view in self.navArray) {
        
        CGRect rect = [self cellRectWithCurrentStateOfIndex:[self.navArray indexOfObject:view] state:self.state];
        //动画
        view.userInteractionEnabled = NO;
        [self animationWithView:view rect:rect duration:0.5];
    }
}

//cell当前的rect
- (CGRect) cellRectWithCurrentStateOfIndex:(NSInteger)i state:(NavViewState)state
{
    if (state == NavViewState_Display) {
        CGRect rect = CGRectMake(0,[GlobalConfig versionIsIOS7]?20:0, SCREENWIDTH, SCREENHEIGHT);
        return rect;
    }
    else {
        CGFloat cellwidth = LastCellWidth -  CellWidthSpace  * i;
        
        CGRect rect = CGRectMake( (SCREENWIDTH - cellwidth)/2, DistanceFromTop + [self cellHeightSpaceWithState:state] * i, cellwidth, SCREENHEIGHT);
        
        //    NSLog(@"%f,%f,%f,%f",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
        
        return rect;
    }
   
}

//不同状态各个cell之间的高度差
- (CGFloat) cellHeightSpaceWithState:(NavViewState)state
{
    if (state == NavViewState_open) {
        if (SCREENHEIGHT == 480) {
            return CellheightSpace_480;
        }
        return CellheightSpace;
    }
    else if (state == NavViewState_close){
        if (SCREENHEIGHT == 480) {
            return CellheightStrSpace_480;
        }
        return CellheightStrSpace;
    }
    else {
        return 0;
    }
}

//动画
- (void) animationWithView:(UIView *)view rect:(CGRect)rect duration:(CGFloat)duration
{
    
    [UIView animateWithDuration:duration animations:^{
        view.frame = rect;
    }];
//    [UIView commitAnimations];
}

#pragma mark buttonPress -

- (void) addNewTaskView:(UIButton *)button
{
    if (self.dataArray.count >= 5) {
        [GlobalConfig alert:ALERT_taskLimit];
        return;
    }
    
    TaskVIewModel *task1 = [[HTTPClient shareHTTPClient] addNewTask];
    
    [self.dataArray addObject:task1];
    [self createAnimationView:task1];
    self.state = NavViewState_close;
    [self changeNavViewRect];
}

#pragma mark - navViewDelegete -
- (void) longpressedWithView:(NavView *)view taskViewModel:(TaskVIewModel *)model
{
    if (([self.dataArray indexOfObject:model] != NSNotFound) && ([self.navArray indexOfObject:view] != NSNotFound)) {
        [self.dataArray removeObject:model];
        [self.navArray removeObject:view];
        [view removeFromSuperview];
        self.state = NavViewState_close;
        [self changeNavViewRect];
    }
}

- (void) tableViewScrollToTopLongerThanLimit:(NavView *)view
{
    self.state = NavViewState_close;
    [self changeNavViewRect];
}

 -(void) DetailButtonPress:(TaskNotificationModel *)sender
{
    [self.navigationController pushViewController:[ControllerFactory taskViewControllerWithTaskNotification:sender] animated:YES];
}

#pragma mark - alertDelegate -
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        TaskVIewModel *task1 = [[HTTPClient shareHTTPClient] addNewTask];
        
        [self.dataArray addObject:task1];
        [self createAnimationView:task1];
        self.state = NavViewState_close;
        [self changeNavViewRect];
    }
}

#pragma  mark - gesture delegate -
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gesture
//{
//    CGPoint point = [gesture locationInView:self.view.superview];
//    
//    return !CGRectContainsPoint(self.view.frame, point);
//}

//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gesture
//{
//    if (self.state == NavViewState_Display && [gesture isKindOfClass:[UITapGestureRecognizer class]]) {
//        return NO;
//    }
//    return YES;
//}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gesture
{
    if (self.state == NavViewState_Display) {
        return NO;
    }
    return YES;
}

@end
