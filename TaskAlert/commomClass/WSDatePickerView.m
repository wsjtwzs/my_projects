//
//  WSDatePickerView.m
//  TaskAlert
//
//  Created by 魔时网 on 14-3-4.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import "WSDatePickerView.h"

static CGFloat  toolBarHeight = 30.0f;
static CGFloat  animationTime = 0.5f;
@implementation WSDatePickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = WHITECOLOR;
    }
    return self;
}

- (void) drawRect:(CGRect)rect
{
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(POINT_X,0, SCREENWIDTH, toolBarHeight)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    toolBar.items = [NSArray arrayWithObjects:space,done, nil];
    [self addSubview:toolBar];
    
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(POINT_X, toolBarHeight, SCREENWIDTH, self.frame.size.height - toolBarHeight)];
    self.datePicker.backgroundColor = WHITECOLOR;
    self.datePicker.minimumDate = [NSDate date];
    self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    [self addSubview:self.datePicker];
}

- (void) done
{
    if([self.delegate respondsToSelector:@selector(selectDate:startDate:)]) {
        [self.delegate selectDate:self.datePicker.date startDate:self.startDate];
    }
    [self hiddenPickerView];
}

#pragma  mark publicAction -

- (void) setDate:(NSDate *)date animated:(BOOL)animated
{
    self.startDate = date;
    [self.datePicker setDate:date animated:animated];
}

- (void) showPickerViewWithDate:(NSDate *)date animated:(BOOL)animated
{
    self.hidden = NO;
    [UIView animateWithDuration:animationTime
                     animations:^{
                        self.frame = CGRectOffset(self.frame, 0, -self.frame.size.height);
    }
                     completion:^(BOOL finish) {
                         if (date) {
                             [self setDate:date animated:animated];
                         }
    }];
}

- (void) hiddenPickerView
{
    
    [UIView animateWithDuration:animationTime animations:^{
        self.frame = CGRectOffset(self.frame, 0, self.frame.size.height);
    } completion:^(BOOL finish) {
            self.hidden = YES;
    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
