//
//  MPDatePickerDataController.h
//  MPaaSDemo_abc
//
//  Created by shifei.wkp on 2018/9/7.
//  Copyright © 2018年 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPDatePickerModel : NSObject

@property (nonatomic, strong) NSDate* startDate;
@property (nonatomic, strong) NSDate* endDate;

@end

@interface MPDatePickerDataController : NSObject

- (void)prepareData;

- (MPDatePickerModel *)datePickerData;

- (AUCascadePickerModel *)cascadPickerData;

- (NSArray *)textPickerData;

@end
