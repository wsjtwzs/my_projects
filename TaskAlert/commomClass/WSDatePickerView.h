//
//  WSDatePickerView.h
//  TaskAlert
//
//  Created by 魔时网 on 14-3-4.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import "WSKit.h"

//frame为固定值（x,x,320,216+30）;

@protocol WSDatePickerViewDelegate;

@interface WSDatePickerView : WSView
@property (nonatomic, strong) UIDatePicker              *datePicker;
@property (nonatomic, strong) NSDate                    *startDate;//选择器开始时候的日期
@property (nonatomic, assign) id<WSDatePickerViewDelegate>  delegate;


- (void) setDate:(NSDate *)date animated:(BOOL)animated;

- (void) showPickerViewWithDate:(NSDate *)date animated:(BOOL)animated;

- (void) hiddenPickerView;

@end

@protocol WSDatePickerViewDelegate <NSObject>

- (void) selectDate:(NSDate *)date startDate:(NSDate *)startDate;

@end


