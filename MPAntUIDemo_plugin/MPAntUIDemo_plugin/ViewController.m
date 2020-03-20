//
//  ViewController.m
//  MPAntUIDemo_plugin
//
//  Created by yangwei on 2019/3/28.
//  Copyright © 2019年 yangwei. All rights reserved.
//

#import "ViewController.h"
#import "MPAntUIDemoDef.h"
#import "MPBannerVC.h"
#import "MPPullRefreshVC.h"
#import "MPSearchBarVC.h"
#import "MPDatePickerVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"AntUIDemo";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(30, 150, [UIScreen mainScreen].bounds.size.width-60, 44);
    button.backgroundColor = [UIColor blueColor];
    [button setTitle:@"轮播图" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showBanner) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectOffset(button.frame, 0, 80);
    button1.backgroundColor = [UIColor blueColor];
    [button1 setTitle:@"上拉和下拉刷新" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(showPullRefresh) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectOffset(button1.frame, 0, 80);
    button2.backgroundColor = [UIColor blueColor];
    [button2 setTitle:@"搜索框" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(showSearchBar) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectOffset(button2.frame, 0, 80);
    button3.backgroundColor = [UIColor blueColor];
    [button3 setTitle:@"日期选择" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(showDatePicker) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
}

- (void)showBanner {
    MPBannerVC *vc = [MPBannerVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showPullRefresh {
    MPPullRefreshVC *vc = [MPPullRefreshVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showSearchBar {
    MPSearchBarVC *vc = [MPSearchBarVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showDatePicker {
    MPDatePickerVC *vc = [MPDatePickerVC new];
    [self.navigationController pushViewController:vc animated:YES];
}



@end
