//
//  MPDatePickerVC.m
//  MPaaSDemo_abc
//
//  Created by shifei.wkp on 2018/9/7.
//  Copyright © 2018年 Alibaba. All rights reserved.
//

#import "MPDatePickerVC.h"
#import "MPDatePickerDataController.h"

typedef NS_ENUM(NSUInteger, MPPickerTag) {
    MPPickerTagTime = 10020,
    MPPickerTagDate,
    MPPickerTagText,
    MPPickerTagCascade,
    MPPickerTagEmbed,
};

@interface MPDatePickerVC () <AUCustomDatePickerDelegate,AUDatePickerDelegate,AUCascadePickerDelegate,UIPickerViewDelegate, AUImplDatePickerDelegate>

@property (nonatomic, strong) MPDatePickerDataController* dataController;

@property(nonatomic, strong) AUCustomDatePicker* timePicker;
@property(nonatomic, strong) AUCustomDatePicker* datePicker;
@property(nonatomic, strong) AUDatePicker* textPicker;
@property(nonatomic, strong) AUCascadePicker *cascadePickerView;
@property(nonatomic, strong) AUImplDatePicker *embedDatePicker;

@property (nonatomic, strong) AUInputBox* dateInput;
@property (nonatomic, strong) AUInputBox* timeInput;
@property (nonatomic, strong) AUInputBox* textInput;
@property (nonatomic, strong) AUInputBox* cascadeInput;
@property (nonatomic, strong) AUInputBox* embedDateInput;

@end

@implementation MPDatePickerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(0xf5f5f5);
    
    [self.dataController prepareData];
    
    CGFloat yStart = 120;
    [self addFirstInput:self.dateInput location:&yStart];
    [self addInput:self.timeInput location:&yStart];
    [self addInput:self.textInput location:&yStart];
    [self addInput:self.cascadeInput location:&yStart];
    [self addLastInput:self.embedDateInput location:&yStart];
    
    
    [self.view addSubview:self.timePicker];
    [self initDatePicker];
    [self.view addSubview:self.datePicker];
    [self.view addSubview:self.textPicker];
    [self.view addSubview:self.cascadePickerView];
}

- (void)initDatePicker {
    // 底部按钮
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 30)];
    [button setTitle:@"底部按钮" forState:UIControlStateNormal];
    [button setTitleColor:AU_COLOR9 forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickBottmView:) forControlEvents:UIControlEventTouchUpInside];
    
    self.datePicker.bottomView = button;
    
    [self.datePicker setTimeDateminDate:self.dataController.datePickerData.startDate MaxDate:self.dataController.datePickerData.endDate];
}

- (MPDatePickerDataController *)dataController {
    if (!_dataController) {
        _dataController = [[MPDatePickerDataController alloc] init];
    }
    return _dataController;
}

- (AUCustomDatePicker *)timePicker {
    if (!_timePicker) {
        _timePicker = [AUCustomDatePicker pickerViewWithTitle:@"" pickerMode:AUDatePickerModeTime];
        _timePicker.tag = MPPickerTagTime;
        _timePicker.delegate = self;
    }
    return _timePicker;
}

- (AUCustomDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [AUCustomDatePicker pickerViewWithTitle:@"有效期" pickerMode:AUDatePickerModeDate];
        _datePicker.tag = MPPickerTagDate;
        _datePicker.delegate = self;
    }
    return _datePicker;
}

- (AUDatePicker *)textPicker {
    if (!_textPicker) {
        _textPicker = [AUDatePicker pickerViewWithTitle:nil];
        _textPicker.tag = MPPickerTagText;
        _textPicker.delegate = self;
    }
    return _textPicker;
}

- (AUCascadePicker *)cascadePickerView {
    if (!_cascadePickerView) {
        _cascadePickerView = [[AUCascadePicker alloc] initWithPickerModel:self.dataController.cascadPickerData];
        _cascadePickerView.tag = MPPickerTagCascade;
        _cascadePickerView.linkageDelegate = self;
    }
    return _cascadePickerView;
}

- (AUImplDatePicker *)embedDatePicker {
    if (!_embedDatePicker) {
        _embedDatePicker = [[AUImplDatePicker alloc] init];
        _embedDatePicker.datePickerMode = AUDatePickerModeDate;
        _embedDatePicker.pickerDelegate = self;
    }
    return _embedDatePicker;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addInput:(AUInputBox *)input location:(CGFloat *)yStart {
    [self addInput:input isFirst:NO isLast:NO location:yStart];
}

- (void)addFirstInput:(AUInputBox *)input location:(CGFloat *)yStart {
    [self addInput:input isFirst:YES isLast:NO location:yStart];
}

- (void)addLastInput:(AUInputBox *)input location:(CGFloat *)yStart {
    [self addInput:input isFirst:NO isLast:YES location:yStart];
}

- (void)addInput:(AUInputBox *)input isFirst:(BOOL)first isLast:(BOOL)last location:(CGFloat *)yStart {
    UIView *wrapView = [[UIView alloc] initWithFrame:CGRectMake(0, *yStart, AUCommonUIGetScreenWidth(), 44)];
    wrapView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:wrapView];
    
    CGFloat lineHeight = 1/[UIScreen mainScreen].scale;
    if (first) {
        UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AUCommonUIGetScreenWidth(), lineHeight)];
        topLine.backgroundColor = RGB(0xdddddd);
        [wrapView addSubview:topLine];
    }
    
    [wrapView addSubview:input];
    
    CGFloat left = last ? 0 : 15;
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(left, input.bottom, AUCommonUIGetScreenWidth() - left, lineHeight)];
    bottomLine.backgroundColor = RGB(0xdddddd);
    [wrapView addSubview:bottomLine];
    
    wrapView.height = bottomLine.bottom;
    *yStart = wrapView.bottom;
}

- (AUInputBox *)timeInput {
    if (!_timeInput) {
        _timeInput = [AUInputBox inputboxWithOriginY:0 buttonIcon:AUBundleImage(@"Tables_Arrow") inputboxType:AUInputBoxTypeNone];
        _timeInput.style = AUInputBoxStyleNone;
        _timeInput.titleLabel.text = @"时间";
        _timeInput.textField.text = @"选择时间";
        AULabel *label = [[AULabel alloc] initWithFrame:_timeInput.bounds];
        [_timeInput addSubview:label];
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openTimePicker:)]];
    }
    return _timeInput;
}

- (AUInputBox *)dateInput {
    if (!_dateInput) {
        _dateInput = [AUInputBox inputboxWithOriginY:0 buttonIcon:AUBundleImage(@"Tables_Arrow") inputboxType:AUInputBoxTypeNone];
        _dateInput.style = AUInputBoxStyleNone;
        _dateInput.titleLabel.text = @"日期";
        _dateInput.textField.text = @"选择日期";
        AULabel *label = [[AULabel alloc] initWithFrame:_dateInput.bounds];
        [_dateInput addSubview:label];
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openDatePicker:)]];
    }
    return _dateInput;
}

- (AUInputBox *)textInput {
    if (!_textInput) {
        _textInput = [AUInputBox inputboxWithOriginY:0 buttonIcon:AUBundleImage(@"Tables_Arrow") inputboxType:AUInputBoxTypeNone];
        _textInput.style = AUInputBoxStyleNone;
        _textInput.titleLabel.text = @"证件类型";
        _textInput.textField.text = @"选择证件类型";
        AULabel *label = [[AULabel alloc] initWithFrame:_textInput.bounds];
        [_textInput addSubview:label];
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openTextPicker:)]];
    }
    return _textInput;
}

- (AUInputBox *)cascadeInput {
    if (!_cascadeInput) {
        _cascadeInput = [AUInputBox inputboxWithOriginY:0 buttonIcon:AUBundleImage(@"Tables_Arrow") inputboxType:AUInputBoxTypeNone];
        _cascadeInput.style = AUInputBoxStyleNone;
        _cascadeInput.titleLabel.text = @"多级选择";
        _cascadeInput.textField.text = @"选择内容";
        AULabel *label = [[AULabel alloc] initWithFrame:_cascadeInput.bounds];
        [_cascadeInput addSubview:label];
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openCascadePicker:)]];
    }
    return _cascadeInput;
}

- (AUInputBox *)embedDateInput {
    if (!_embedDateInput) {
        _embedDateInput = [AUInputBox inputboxWithOriginY:0 buttonIcon:AUBundleImage(@"Tables_Arrow") inputboxType:AUInputBoxTypeNone];
        _embedDateInput.style = AUInputBoxStyleNone;
        _embedDateInput.titleLabel.text = @"内嵌日期";
        _embedDateInput.textField.text = @"选择日期";
        AULabel *label = [[AULabel alloc] initWithFrame:_embedDateInput.bounds];
        [_embedDateInput addSubview:label];
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openEmbedPicker:)]];
    }
    return _embedDateInput;
}

- (void)clickBottmView:(id)sender {
    [AUToast presentToastWithin:self.view withIcon:AUToastIconNone text:@"点击了底部按钮" duration:2.0 logTag:@"Demo"];
}

- (void)openTimePicker:(id)sender {
    [self.timePicker showOnSuperView:self.view];
}


- (void)openDatePicker:(id)sender {
    [self.datePicker showOnSuperView:self.view];
}

- (void)openTextPicker:(id)sender {
    [self.textPicker show];
}

- (void)openCascadePicker:(id)sender {
    [self.cascadePickerView showInView:self.view];
}

- (void)openEmbedPicker:(id)sender {
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    containerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [containerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeEmbedPicker:)]];
    
    [self.embedDatePicker reloadData];
    [self.embedDatePicker reloadAllComponents];
    self.embedDatePicker.frame = CGRectMake(0, 300, self.view.width, 300);
    self.embedDatePicker.backgroundColor = [UIColor whiteColor];
    [containerView addSubview:self.embedDatePicker];
    
    [self.view addSubview:containerView];
}

- (void)closeEmbedPicker:(UIGestureRecognizer *)sender {
    [self.embedDatePicker removeFromSuperview];
    [sender.view removeFromSuperview];
}


#pragma mark - AUImplDatePickerDelegate
-(void)didSelectDatePickerView:(AUImplDatePicker *)picker {
    NSDate *selectedDate = picker.selectedDate;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"HH:mm:ss";
    self.embedDateInput.textFieldText= [formatter stringFromDate:selectedDate];
}


#pragma mark - AUCustomDatePickerDelegate
- (void)selectedPickerView:(AUCustomDatePicker *)pickerView {
    MPPickerTag tag = pickerView.tag;
    switch (tag) {
        case MPPickerTagTime: {
            AUCustomDatePicker *picker = (AUCustomDatePicker*)pickerView;
            NSDate *selectedDate = picker.selectedDate;
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            formatter.dateFormat = @"HH:mm";
            self.timeInput.textFieldText = [formatter stringFromDate:selectedDate];
        }
            break;
        case MPPickerTagDate: {
            AUCustomDatePicker *picker = (AUCustomDatePicker*)pickerView;
            NSDate *selectedDate = picker.selectedDate;
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            formatter.dateFormat = @"YYYY-MM-dd";
            self.dateInput.textFieldText = [formatter stringFromDate:selectedDate];
        }
            break;
        case MPPickerTagText: {
            AUDatePicker *picker = (AUDatePicker*)pickerView;
            NSInteger index = [picker.pickerView selectedRowInComponent:0];
            NSString *result = [self.dataController.textPickerData objectAtIndex:index];
            self.textInput.textFieldText = result;
        }
            break;
        case MPPickerTagCascade: {
            AUCascadePicker *picker = (AUCascadePicker*)pickerView;
            NSString *text = [NSString stringWithFormat:@"%@-%@-%@", picker.dataModel.selectedItem.selectedLeftTitle, picker.dataModel.selectedItem.selectedMiddleTitle, picker.dataModel.selectedItem.selectedRightTitle];
            self.cascadeInput.textFieldText = text;
        }
            break;
            
        default:
            break;
    }
    [pickerView hide];
}

- (void)cancelPickerView:(AUDatePicker *)pickerView {
    if ([pickerView isKindOfClass:[AUDatePicker class]]) {
        AUDatePicker *picker = (AUDatePicker*)pickerView;
        [picker hide];
    } else {
        [pickerView hide];
    }
}


#pragma UIPickerView delegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.dataController.textPickerData objectAtIndex:row];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.dataController.textPickerData count];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
