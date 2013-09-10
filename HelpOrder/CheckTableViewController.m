//
//  CheckTableViewController.m
//  HelpOrder
//
//  Created by Ralbatr on 13-8-31.
//  Copyright (c) 2013年 Ralbatr. All rights reserved.
//

#import "CheckTableViewController.h"
#import "SBJson.h"
#import "OrderDetail.h"
#import "CheckTableView.h"
#import "ReadJson.h"

@interface CheckTableViewController ()

@end

@implementation CheckTableViewController

@synthesize orderMutableArray;
@synthesize peopleNoOrderArray;
@synthesize sectionArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.orderMutableArray = [[NSMutableArray alloc] init];
        self.sectionArray = [[NSArray alloc] init];
        self.peopleNoOrderArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"订单显示";
    //获取 详细订单 
    [self getOrderMutableArray];
    
    int allPeopleLength = [self readJson];
    int orderPeopleLength = [self.orderMutableArray count];
    // 找出 没有 点餐的人
    [self findNoOrderPeople];
    //view
    CheckTableView *checkTableView = [[CheckTableView alloc] init];
    [checkTableView showStatusViewWithOrderPeopleLength:orderPeopleLength andNoorderLength:(allPeopleLength - orderPeopleLength) andTotalPrice:[self totalPrice]];    
    [self.view addSubview:checkTableView];
    //隐藏 TableView的多余的 白线
    [self setExtraCellLineHidden:self.tableView];    
}
//获取所有人名的个数
- (int)readJson
{
    //读取 users.json
    ReadJson *readJson = [[ReadJson alloc] init];
    NSMutableArray *AllPeopleNameArray = [readJson readJosonwithFileName:@"users"];
    
    self.peopleNoOrderArray = AllPeopleNameArray;
    return [AllPeopleNameArray count];
}

- (void)findNoOrderPeople
{
    for (int i = 0; i < [self.orderMutableArray count]; i++) {
        OrderDetail *orderDetail = [[OrderDetail alloc] init];
        orderDetail = [self.orderMutableArray objectAtIndex:i];
        NSDictionary *dic = [NSDictionary dictionaryWithObject:orderDetail.peopleName forKey:@"name"];
        [peopleNoOrderArray removeObject:dic];
    }
}

- (void)getOrderMutableArray
{
    ReadJson *readJsonFilePath = [[ReadJson alloc] init];
    NSString *filePath = [readJsonFilePath jsonFilePath:@"orderDetail.json"];
    NSString *fileString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    SBJsonParser * parser = [[SBJsonParser alloc] init];
    NSArray *array = [parser objectWithString:fileString error:nil];
    for (int i = 0; i < [array count]; i++) {
        OrderDetail *order = [[OrderDetail alloc] init];
        [orderMutableArray addObject:[order DicToObject:[array objectAtIndex:i]]];
    }
}

- (float)totalPrice
{
    //计算 总价
    float totalPrice =  0;
    int orderPeopleLength = [self.orderMutableArray count];
    for (int j= 0; j < orderPeopleLength; j++) {
        OrderDetail *orderDetail = [[OrderDetail alloc] init];
        orderDetail = [self.orderMutableArray objectAtIndex:j];
        totalPrice += [orderDetail.price floatValue];
    }
    return totalPrice;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - 自定义方法
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

#pragma mark - Table view data source
//section个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

//分区内的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [self.orderMutableArray count];
    }
    else
        return [self.peopleNoOrderArray count];
}

//具体的tableview数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    static NSString *CheckCellIdentifier = @"CheckCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CheckCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CheckCellIdentifier];
    }
    //section为0 为订餐
    if (section == 0) {
        CheckTableView *checkTableView;
        [cell.contentView addSubview:[self exceedView:checkTableView andRow:row]];
    }
    //没有订餐的人 
    if (section == 1) {
        cell.textLabel.text = [[self.peopleNoOrderArray objectAtIndex:row] objectForKey:@"name"];
    }
    return cell;
}

- (UIView *)exceedView:(UIView *)checkTableView andRow:(int)row
{
    OrderDetail *orderDatil = [[OrderDetail alloc] init];
    orderDatil = [self.orderMutableArray objectAtIndex:row];
    float price = [orderDatil.price floatValue];
    if (price <= 12) {
        checkTableView = [[CheckTableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) andOrderDetail:orderDatil andPriceColor:[UIColor blackColor] andExceedPriceColor:[UIColor clearColor]];
    }
    else
    {
        checkTableView = [[CheckTableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) andOrderDetail:orderDatil andPriceColor:[UIColor redColor] andExceedPriceColor:[UIColor redColor]];
    }
    return checkTableView;
}
//section的题目
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    NSString *titleString = [[NSString alloc] init];
    if (section == 0) {
        titleString = [NSString stringWithFormat:@"%d人已经订餐",[self.orderMutableArray count]];
    }
    else
        titleString = [NSString stringWithFormat:@"%d人尚未订餐",[self.peopleNoOrderArray count]];
    return titleString;
}

#pragma mark - Table view delegate
//更改表的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return LineHight;
}

@end