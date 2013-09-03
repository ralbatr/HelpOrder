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

@synthesize orderArray;

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
    [checkButton setEnabled:NO];
    [self.view addSubview:checkButton];
    //如果，没有订单，把之前的点菜列表删除
    if ([self.orderArray count] == 0) {
        //要往沙盒中写数据获取的沙盒目录
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *plistPath=[paths objectAtIndex:0];
        
        //取得完整的文件名
        NSString *fileName=[plistPath stringByAppendingPathComponent:@"orderDetail.json"];
        NSLog(@"fileName is : %@",fileName);
        //删除这个文件
        NSString *value = @"";
        //创建并写入文件
        [value writeToFile:fileName atomically:YES encoding:NSUTF8StringEncoding error:nil];
        //检查是否写入
        //    NSString *writeData=[[NSString alloc]initWithContentsOfFile:fileName];
        NSString *writeData = [[NSString alloc] initWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"write data is :%@",writeData);
    }
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
    orderViewController.delegate = self;
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
    [checkViewController setOrderMutableArray:self.orderArray];
    [self.navigationController pushViewController:checkViewController animated:YES];
    
    [checkViewController release];
}

- (void)dealloc
{
    [orderArray release];
    [super dealloc];
}

#pragma mark - delegate
- (void)orderDetail:(NSMutableArray *)orderDetail
{
    self.orderArray = orderDetail;
    if ([self.orderArray count] > 0) {
        UIButton *checkButton = (UIButton *)[self.view viewWithTag:201];
        [checkButton setEnabled:YES];
    }
}

@end
