//
//  RootViewController.m
//  HelpOrder
//
//  Created by Ralbatr on 13-8-31.
//  Copyright (c) 2013年 Ralbatr. All rights reserved.
//

#import "RootViewController.h"
#import "OrderViewController.h"
#import "CheckTableViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"订餐首页";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    UIButton *orderButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    orderButton.frame = CGRectMake(20, 40, 280, 40);
    [orderButton setTitle:@"帮订餐" forState:UIControlStateNormal];
    [orderButton addTarget:self action:@selector(orderMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:orderButton];
    
    UIButton *checkButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    checkButton.frame = CGRectMake(20, 100, 280, 40);
    [checkButton setTitle:@"看订单" forState:UIControlStateNormal];
    checkButton.tag = 201;
    [checkButton addTarget:self action:@selector(checkMethod) forControlEvents:UIControlEventTouchUpInside];
    //初始时，不可以使用查“看订单”按钮
//    [checkButton setEnabled:NO];
    [self.view addSubview:checkButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//订餐按钮，实现push到订餐页面
- (void)orderMethod
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    [backItem release];
    OrderViewController *orderViewController = [[OrderViewController alloc] init];
//    orderViewController.delegate = self;
    [self.navigationController pushViewController:orderViewController animated:YES];
    [orderViewController release];
}

//查看按钮，实现push到查订单页面
- (void)checkMethod
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    [backItem release];
    CheckTableViewController *checkViewController = [[CheckTableViewController alloc] init];
    //    checkViewController.orderMutableArray = self.orderArray;
//    [checkViewController setOrderMutableArray:self.orderArray];
    [self.navigationController pushViewController:checkViewController animated:YES];
    
    [checkViewController release];
}

@end
