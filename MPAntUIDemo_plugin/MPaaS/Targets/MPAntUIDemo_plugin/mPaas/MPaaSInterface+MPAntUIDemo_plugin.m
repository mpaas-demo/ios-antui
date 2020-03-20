//
//  MPaaSInterface+MPAntUIDemo_plugin.m
//  MPAntUIDemo_plugin
//
//  Created by vivi.yw on 2020/03/20.
//  Copyright © 2020 Alibaba. All rights reserved.
//

#import "MPaaSInterface+MPAntUIDemo_plugin.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

@implementation MPaaSInterface (MPAntUIDemo_plugin)

- (BOOL)enableSettingService
{
    return NO;
}

- (NSString *)userId
{
    return nil;
}

@end

#pragma clang diagnostic pop
