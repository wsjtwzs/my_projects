//
//  NavView.m
//  VUtest
//
//  Created by mosh on 13-7-30.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import "NavView.h"


@implementation NavView

#pragma mark - systemAction -

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    
    }
    return self;
}


- (void) drawRect:(CGRect)rect
{
    self.clipsToBounds = YES;
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.titleTextField resignFirstResponder];
    [self.subtitleTextField resignFirstResponder];
}

#pragma  mark - privateAction -

- (id) initWithFrame:(CGRect)frame taskViewModel:(TaskVIewModel *)model displayViewController:(UIViewController *)ctl
{
    if (self = [super init]) {
        self.model = model;
        self.displayCtl = ctl;
    }
    return self;
}
- (void) initTableView
{
    self.taskTableView.dataSource = self;
    self.taskTableView.delegate = self;
    self.taskTableView.autoresizesSubviews = YES;
    //    self.taskTableView.editing = YES;
    self.taskTableView.tableHeaderView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.autoresizesSubviews = YES;
    self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    
}

- (void) createGesture
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectHeadImage)];
    tap.delegate = self;
    self.headImageView.userInteractionEnabled = YES;
    [self.headImageView addGestureRecognizer:tap];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    longPress.delegate = self;
    [self addGestureRecognizer:longPress];
}

- (void) longPress:(UIGestureRecognizer *)ges
{
    if (ges.state == UIGestureRecognizerStateBegan) {
        
        UIAlertView *alect = [[UIAlertView alloc] initWithTitle:@"添加" message:@"是否消灭该死的任务页？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alect show];

    }
}

- (void) changeEditingStyle
{
    if (_editingStyle == UITableViewCellEditingStyleInsert) {
        _editingStyle = UITableViewCellEditingStyleDelete;
    }
    else {
        _editingStyle = UITableViewCellEditingStyleInsert;
    }
    
}

#pragma mark - buttonPress -
- (void) selectHeadImage
{
    //    检查照片库是否可用
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        [GlobalConfig alert:ALERT_IMAGEPICKER];
        return;
    }
    //    创建图片选取器
    UIImagePickerController *pickerCtl = [[UIImagePickerController alloc] init];
    pickerCtl.delegate = self;
    [self.displayCtl presentViewController:pickerCtl animated:YES completion:^{}];
}

- (void) editTask
{
    [self.taskTableView setEditing:!self.taskTableView.editing animated:YES];
}

- (void) addNewTask
{
    [self changeEditingStyle];
     [self.taskTableView setEditing:!self.taskTableView.editing animated:YES];
}


#pragma  mark - publicAction -
- (void) startWithFrame:(CGRect)frame taskViewModel:(TaskVIewModel *)model displayViewController:(UIViewController *)ctl
{
    self.frame = frame;
    self.model = model;
    self.displayCtl = ctl;
    _editingStyle = UITableViewCellEditingStyleDelete;
    self.titleTextField.text = self.model.title;
    self.subtitleTextField.text = self.model.subtitle;
    self.headImageView.image = model.headImage;
    
    [self createGesture];
    [self initTableView];
    
//    //添加观察者
//    [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
}


#pragma  mark _textFieldDelegate_
- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    textField.text = nil;
}

- (void) textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

#pragma mark ImagePickerDelegate -
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    self.headImageView.image = image;
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
}


#pragma  mark - tableViewDelegate
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.taskArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.backgroundColor = CLEARCOLOR;
        cell.editing = YES;
    }
    
    TaskNotificationModel *model = self.model.taskArray[indexPath.row];
    cell.textLabel.text = model.title;
    
    return cell;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [GlobalConfig createViewWithFrame:CGRectMake(0, 0, tableView.frame.size.width, [self tableView:tableView heightForHeaderInSection:section])];
    
    UIButton *add = [UIButton buttonWithType:UIButtonTypeContactAdd];
    add.frame = CGRectMake(10, 0,view.frame.size.height, view.frame.size.height);
    [add addTarget:self action:@selector(addNewTask) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:add];

    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.contentOffset.y < -50) {
        if ([self.delegate respondsToSelector:@selector(tableViewScrollToTopLongerThanLimit:)]) {
            [self.delegate tableViewScrollToTopLongerThanLimit:self];
        }
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath: (NSIndexPath *)indexPath
{
    return  _editingStyle;
}

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (indexPath.row < self.model.taskArray.count) {
            [self.model.taskArray removeObjectAtIndex:indexPath.row];
            [self.taskTableView reloadData];
        }
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        //插入操作
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(DetailButtonPress:)]) {
        [self.delegate  DetailButtonPress:self.model.taskArray[indexPath.row]];
    }
}

#pragma  mark alertDelegate -
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        if ([self.delegate respondsToSelector:@selector(longpressedWithView:taskViewModel:)]) {
            [self.delegate longpressedWithView:self taskViewModel:self.model];
        }
    }
}

////观察者
//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    [self.taskTableView reloadData];
//}



@end
