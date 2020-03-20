//
//  MPDatePickerDataController.m
//  MPaaSDemo_abc
//
//  Created by shifei.wkp on 2018/9/7.
//  Copyright © 2018年 Alibaba. All rights reserved.
//

#import "MPDatePickerDataController.h"

@implementation MPDatePickerModel
@end

@interface MPDatePickerDataController ()

@property (nonatomic, strong) MPDatePickerModel *datePickerData;
@property (nonatomic, strong) AUCascadePickerModel *cascadPickerData;
@property (nonatomic, strong) NSArray *textPickerData;


@end

@implementation MPDatePickerDataController

- (void)prepareData {
    [self initDatePickerData];
    [self initCascadePickerData];
    [self initTextPickerData];
}

- (void)initDatePickerData {
    self.datePickerData = [MPDatePickerModel new];
    //自定义日期时间选择器
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *components = [[NSDateComponents alloc]init];
    [components setYear:2014];
    [components setMonth:1];
    [components setDay:1];
    [components setHour:1];
    [components setMinute:01];
    self.datePickerData.startDate = [calendar dateFromComponents:components];
    
    NSDateComponents *endComponents = [[NSDateComponents alloc]init];
    [endComponents setYear:2019];
    [endComponents setMonth:12];
    [endComponents setDay:30];
    [endComponents setHour:23];
    [endComponents setMinute:59];
    [endComponents setSecond:59];
    self.datePickerData.endDate = [calendar dateFromComponents:endComponents];
}

- (void)initCascadePickerData {
    self.cascadPickerData = [[AUCascadePickerModel alloc] init];
    
    NSMutableArray *modelList = [[NSMutableArray alloc] init];
    for (int i=0; i<6; i++)
    {
        AUCascadePickerRowItemModel *item = [[AUCascadePickerRowItemModel alloc] init];
        item.rowTitle = [NSString stringWithFormat:@"第一层的%d", i];
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int j=0; j<7; j++)
        {
            if (i == 0)
            {
                break;
            }
            AUCascadePickerRowItemModel *item1 = [[AUCascadePickerRowItemModel alloc] init];
            item1.rowTitle = [NSString stringWithFormat:@"第二层的%d", j];
            NSMutableArray *array1 = [[NSMutableArray alloc] init];
            for (int k=0; k<5; k++) {
                AUCascadePickerRowItemModel *item2 = [[AUCascadePickerRowItemModel alloc] init];
                item2.rowTitle = [NSString stringWithFormat:@"第三层的%d", k];
                [array1 addObject:item2];
                if (j == 1 || j== 2) {
                    break;
                }
            }
            item1.rowSubList = array1;
            [array addObject:item1];
            if (i == 3 || i== 5) {
                break;
            }
        }
        item.rowSubList = array;
        [modelList addObject:item];
    }
    
    self.cascadPickerData.dataList = modelList;
    
    
    AUCascadePickerSelectedRowItem *item = [[AUCascadePickerSelectedRowItem alloc] init];
    item.selectedLeftTitle = @"第一层的0";
    item.selectedMiddleTitle = @"第二层的0";
    item.selectedRightTitle = @"第三层的0";
    
    self.cascadPickerData.selectedItem = item;
}

- (void)initTextPickerData {
    self.textPickerData = @[@"居民户口簿",@"身份证",@"临时居住证",@"军官证"];
}

@end
