//
//  MPBannerVC.m
//  MPaaSDemo_abc
//
//  Created by shifei.wkp on 2018/9/7.
//  Copyright © 2018年 Alibaba. All rights reserved.
//

#import "MPBannerVC.h"
#import <AntUI/AUBannerCollectionView.h>

@interface MPBannerVC () <AUBannerViewDelegate, AUBannerContentDelegate>

@end

@implementation MPBannerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGB(0xf5f5f5);
    
    CGFloat topMargin = 120;
    NSInteger spaceY = 10;
    NSInteger height = 200;
    
    // 普通banner （深色）
    for (NSInteger i = 0; i < 1; i ++) {
        CGRect rect = CGRectMake(10, topMargin + (height + spaceY) * i, self.view.width - 20, height);
        AUBannerView *bannerView = [[AUBannerView alloc] initWithFrame:rect bizType:@"demo" makeConfig:^(AUBannerViewConfig *config) {
            config.duration = 2;
            config.style = AUBannerStyleDeepColor;
            config.autoTurn = YES;
            config.autoStartTurn = YES;
        }];
        
        bannerView.delegate = self;
        bannerView.tag = 1;
        bannerView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
        [self.view addSubview:bannerView];
    }
    
    // 普通banner （浅色）
    for (NSInteger i = 1; i < 2; i ++) {
        CGRect rect = CGRectMake(10, topMargin + (height + spaceY) * i, self.view.width - 20, height);
        AUBannerView *bannerView = [[AUBannerView alloc] initWithFrame:rect bizType:@"demo" makeConfig:^(AUBannerViewConfig *config) {
            config.duration = 2;
            config.style = AUBannerStyleLightColor;
            config.autoTurn = NO;
            config.pageControlDotTapEnabled = YES;
        }];
        
        bannerView.delegate = self;
        bannerView.tag = 2;
        bannerView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
        [self.view addSubview:bannerView];
    }
}

- (NSInteger)numberOfItems {
    return 10;
}

- (UIView *)itemAtPos:(NSInteger)pos {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.backgroundColor = [UIColor orangeColor];
    return view;
}

- (void)didScrollToPage:(NSInteger)pos {
    
}

- (void)didBeginDrag {
    
}

- (void)didEndDrag {
    
}

- (void)didTapedAtPos:(NSInteger)pos {
    
}

#pragma mark - AUBannerViewDelegate

- (NSInteger)numberOfItemsInBannerView:(AUBannerView *)bannerView {
    return bannerView.tag == 1 ? 3 : 4;
}

- (UIView *)bannerView:(AUBannerView *)bannerView itemViewAtPos:(NSInteger)pos {
    NSArray *array = nil;
    // 深色
    if (bannerView.tag == 1) {
        array = @[RGB(0x108EE9), RGB_A(0x108EE9, 0.5), [UIColor blueColor]];
    }
    // 浅色
    else {
        array = @[RGB(0xfFFFFF),RGB_A(0xeFFFFF, 0.8),RGB(0xcFFFFF),RGB_A(0xeFFFFF, 0.5),RGB_A(0xeFFFFF, 0.9)];
    }
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = array[pos];
    return view;
}

- (void)bannerView:(AUBannerView *)bannerView didTapedItemAtPos:(NSInteger)pos {
    NSString *msg = [NSString stringWithFormat:@"点击第%@张图片", @(pos + 1)];
    AUNoticeDialog *alert = [[AUNoticeDialog alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    NSLog(@"didTapedItemAtPos %@", @(pos));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
