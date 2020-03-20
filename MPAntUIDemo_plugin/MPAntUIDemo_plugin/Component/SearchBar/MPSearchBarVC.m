//
//  MPSearchBarVC.m
//  MPaaSDemo_abc
//
//  Created by shifei.wkp on 2018/9/7.
//  Copyright © 2018年 Alibaba. All rights reserved.
//

#import "MPSearchBarVC.h"
#import "MPAntUIDemoDef.h"

@interface MPSearchBarVC () <AUSearchBarDelegate>

@property (nonatomic, assign) NSInteger code;

@end

@implementation MPSearchBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGB(0xf5f5f5);
    
    if (self.code == 0) {
        CGFloat yStart = 120;
        
        [self addSearchBar:AUSearchBarStyleNormal placeholder:@"AUSearchBarStyleNormal" location:&yStart];
        [self addSearchBar:AUSearchBarStyleDetail placeholder:@"AUSearchBarStyleDetail" location:&yStart];
        [self addSearchBar:AUSearchBarStyleNone placeholder:@"AUSearchBarStyleNone" location:&yStart];
        CREATE_UI({
            vPadding = yStart;
            BUTTON_WITH_ACTION(@"实例(AUSearchBarStyleNormal)", showSearchBarNormal:)
            BUTTON_WITH_ACTION(@"实例(AUSearchBarStyleDetail)", showSearchBarDetail:)
        })
    } else if (self.code == 1)  {
        AUSearchBar *searchBar = [[AUSearchBar alloc] initWithStyle:AUSearchBarStyleNormal];
        searchBar.searchTextField.placeholder = @"搜索栏样式(AUSearchBarStyleNormal)";
        searchBar.delegate = self;
        searchBar.shouldShowVoiceButton = YES;
        self.navigationItem.titleView = searchBar;
        
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = nil;
        self.navigationItem.hidesBackButton = YES;
    } else if (self.code == 2)  {
        AUSearchBar *searchBar = [[AUSearchBar alloc] initWithStyle:AUSearchBarStyleDetail];
        searchBar.searchTextField.placeholder = @"搜索栏样式(AUSearchBarStyleDetail)";
        searchBar.delegate = self;
        searchBar.shouldShowVoiceButton = YES;
        self.navigationItem.titleView = searchBar;
        
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = nil;
        self.navigationItem.hidesBackButton = YES;
    }
}

- (void)addSearchBar:(AUSearchBarStyle)style placeholder:(NSString *)placeholder location:(CGFloat *)yStart {
    AUSearchBar *searchBar = [[AUSearchBar alloc] initWithStyle:style];
    searchBar.searchTextField.placeholder = placeholder;
    searchBar.delegate = self;
    searchBar.top = *yStart;
    searchBar.shouldShowVoiceButton = YES;
    [self.view addSubview:searchBar];
    *yStart += searchBar.height + 20;
}

- (void)showSearchBarNormal:(id)sender {
    MPSearchBarVC *vc = [[MPSearchBarVC alloc] init];
    vc.code = 1;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showSearchBarDetail:(id)sender {
    MPSearchBarVC *vc = [[MPSearchBarVC alloc] init];
    vc.code = 2;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - AUSearchBarDelegate

- (BOOL)searchBarTextShouldBeginEditing:(AUSearchBar *)searchBar
{
    NSLog(@"searchBarTextShouldBeginEditing");
    return YES;
}

- (BOOL)searchBarTextShouldEndEditing:(AUSearchBar *)searchBar
{
    NSLog(@"searchBarTextShouldEndEditing");
    return YES;
}

// called when text starts editing
- (void)searchBarTextDidBeginEditing:(AUSearchBar *)searchBar
{
    NSLog(@"searchBarTextDidBeginEditing");
}

// called when text ends editing
- (void)searchBarTextDidEndEditing:(AUSearchBar *)searchBar
{
    NSLog(@"searchBarTextDidEndEditing");
}

// called when text changes (including clear)
- (void)searchBar:(AUSearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"textDidChange");
}

// called before text changes
- (BOOL)searchBar:(AUSearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSLog(@"shouldChangeTextInRange");
    return YES;
}

// called when keyboard search button pressed
- (void)searchBarSearchButtonClicked:(AUSearchBar *)searchBar
{
    NSLog(@"searchBarSearchButtonClicked");
}

- (void)searchBarCancelButtonClicked:(AUSearchBar *) searchBar
{
    NSLog(@"searchBarCancelButtonClicked");
    if (self.code == 1 || self.code == 2) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)searchBarBackButtonClicked:(AUSearchBar *)searchBar
{
    NSLog(@"searchBarBackButtonClicked");
    if (self.code == 1 || self.code == 2) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (BOOL)searchBarShouldClear:(AUSearchBar *)searchBar
{
    NSLog(@"searchBarShouldClear");
    return YES;
}

- (void)searchBarOpenVoiceAssister:(AUSearchBar *)searchBar
{
    NSLog(@"searchBarOpenVoiceAssister");
    AUNoticeDialog *alert = [[AUNoticeDialog alloc] initWithTitle:@"点击了voiceButton" message:nil];
    [alert addButton:@"确定" actionBlock:nil];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
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
