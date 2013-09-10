//
//  RootViewController.m
//  HelpOrder
//
//  Created by Ralbatr on 13-8-31.
//  Copyright (c) 2013年 Ralbatr. All rights reserved.
//

#import "RootViewController.h"
#import "RootView.h"
#import "OrderViewController.h"
#import "ReadJson.h"
#import "CheckTableViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

//@synthesize orderArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        self.orderArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"订餐首页";
    //设置 navigation风格
	self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    RootView *rootView = [[RootView alloc] initWithButtonTarget:self andSEL:@selector(orderMethod) andOtherTarget:self andOtherSEL:@selector(checkMethod) withFrame:CGRectMake(0, 0, 320, 480)];
    [self.view addSubview:rootView];
    UIButton *checkButton = (UIButton *)[self.view viewWithTag:201];
    //如果，没有订单，把之前的点菜列表删除
    if (checkButton.isEnabled == NO) {
        ReadJson *writeJson = [[ReadJson alloc] init];
        [writeJson writeJsonWithJsonName:@"orderDetail.json" andValue:@""];
    }
//    //如果，没有订单，把之前的点菜列表删除
//    if ([self.orderArray count] == 0) {
//        ReadJson *writeJson = [[ReadJson alloc] init];
//        [writeJson writeJsonWithJsonName:@"orderDetail.json" andValue:@""];
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//订餐按钮，实现push到订餐页面
- (void)orderMethod
{
    [self BackItemButton];
    OrderViewController *orderViewController = [[OrderViewController alloc] init];
    orderViewController.delegate = self;
    [self.navigationController pushViewController:orderViewController animated:YES];
}

//查看按钮，实现push到查订单页面
- (void)checkMethod
{
    [self BackItemButton];
    CheckTableViewController *checkViewController = [[CheckTableViewController alloc] init];
//    [checkViewController setOrderMutableArray:self.orderArray];
    [self.navigationController pushViewController:checkViewController animated:YES];
}

- (void)BackItemButton
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
}

#pragma mark - delegate
- (void)orderDetail:(NSInteger)orderDetailCount
{
    // 如果 清单 存在 设置 看清单 按钮 可用
    if (orderDetailCount > 0) {
        UIButton *checkButton = (UIButton *)[self.view viewWithTag:201];
        [checkButton setEnabled:YES];
    }
}

@end
