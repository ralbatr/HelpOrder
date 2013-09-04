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
        self.title = @"订单显示";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //读取 users.json
    
    NSString *userPath = [[NSBundle mainBundle] pathForResource:@"users" ofType:@"json"];
    NSString *jsonString = [NSString stringWithContentsOfFile:userPath encoding:NSUTF8StringEncoding error:NULL];
    
    SBJsonParser * parser = [[SBJsonParser alloc] init];
    NSError * error = nil;
    NSMutableArray *AllPeopleNameArray = [parser objectWithString:jsonString error:&error];
    self.peopleNoOrderArray = AllPeopleNameArray;
    int allPeopleLength = [AllPeopleNameArray count];
    int orderPeopleLength = [self.orderMutableArray count];

    for (int i = 0; i < orderPeopleLength; i++) {
        OrderDetail *orderDetail = [[OrderDetail alloc] autorelease];
        orderDetail = [self.orderMutableArray objectAtIndex:i];
        NSDictionary *dic = [NSDictionary dictionaryWithObject:orderDetail.peopleName forKey:@"name"];
        [peopleNoOrderArray removeObject:dic];
        NSLog(@"%@",orderDetail.peopleName);
    }    
    
    float totalPrice =  0;
    for (int j= 0; j < orderPeopleLength; j++) {
        OrderDetail *orderDetail = [[OrderDetail alloc] autorelease];
        orderDetail = [self.orderMutableArray objectAtIndex:j];
        totalPrice += [orderDetail.price floatValue];
    }
    
    //    [self.navigationController setToolbarHidden:NO];
    UIToolbar *statusView = [[UIToolbar alloc] init];
    statusView.frame = CGRectMake(0,380,320,44);
    statusView.backgroundColor = [UIColor blackColor];
    statusView.barStyle = UIBarStyleBlack;
    [self.view addSubview:statusView];
    [statusView release];
    
    UILabel *statusLabel = [[UILabel alloc] init];
    statusLabel.frame = CGRectMake(10, 380, 320, 45);
    statusLabel.textAlignment = NSTextAlignmentCenter;
    statusLabel.textColor = [UIColor whiteColor];
    statusLabel.backgroundColor = [UIColor clearColor];
    statusLabel.font = [UIFont boldSystemFontOfSize:18];
    //    NSString *statusString = [[NSString stringWithFormat:@"%d人已定，%d人未定",orderPeopleLength,allPeopleLength - orderPeopleLength];
    NSString *statusString = [NSString stringWithFormat:@"%d人已定,%d人未定,总计%.2f元",orderPeopleLength,allPeopleLength - orderPeopleLength,totalPrice];
    statusLabel.text = statusString;
    statusLabel.tag = 301;
    [self.view addSubview:statusLabel];
    //    [self.navigationController set]
    [statusLabel release];
    [self setExtraCellLineHidden:self.tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [orderMutableArray release];
    [peopleNoOrderArray release];
    [sectionArray release];
    [super dealloc];
}

#pragma mark - 自定义方法
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [view release];
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

//

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    static NSString *CheckCellIdentifier = @"CheckCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CheckCellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CheckCellIdentifier] autorelease];
    }
    
    // Configure the cell...
    if (section == 0) {
        OrderDetail *orderDatil = [[OrderDetail alloc] autorelease];
        orderDatil = [self.orderMutableArray objectAtIndex:row];
        
        CGRect nameLabelRect = CGRectMake(3, 5, 150, 18);
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:nameLabelRect];
        nameLabel.text = orderDatil.peopleName;
        nameLabel.font = [UIFont boldSystemFontOfSize:20];
        [cell.contentView addSubview:nameLabel];
        [nameLabel release];
        
        CGRect restaurantLabelRect = CGRectMake(3, 25, 150, 14);
        UILabel *restaurantLabel = [[UILabel alloc] initWithFrame:restaurantLabelRect];
        NSString *restaurantAndFoodString = [NSString stringWithFormat:@"%@ %@",orderDatil.restaurantName,orderDatil.packagesName];
        restaurantLabel.text = restaurantAndFoodString;
        restaurantLabel.font = [UIFont boldSystemFontOfSize:14];
        [cell.contentView addSubview:restaurantLabel];
        [restaurantLabel release];
        
        CGRect priceLabelRect = CGRectMake(230, 5, 70, 15);
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:priceLabelRect];
        NSString *price = [NSString stringWithFormat:@"¥ %.2f",[orderDatil.price floatValue]];
        priceLabel.text = price;
        if ( [orderDatil.price intValue] > 12 ) {
            priceLabel.textColor = [UIColor redColor];
            CGRect exceedPriceLabelRect = CGRectMake(230, 25, 70, 15);
            UILabel *exceedPriceLabel = [[UILabel alloc] initWithFrame:exceedPriceLabelRect];
            NSString *exceedPrice = [NSString stringWithFormat:@"¥ %.2f",[orderDatil.price floatValue] - 12];
            exceedPriceLabel.text = exceedPrice;
            exceedPriceLabel.textColor = [UIColor redColor];
            exceedPriceLabel.font = [UIFont boldSystemFontOfSize:14];
            [cell.contentView addSubview:exceedPriceLabel];
        }
        priceLabel.font = [UIFont boldSystemFontOfSize:14];
        [cell.contentView addSubview:priceLabel];
        [priceLabel release];
    }
    //没有订餐的人 
    if (section == 1) {
        NSLog(@"%@",[[self.peopleNoOrderArray objectAtIndex:row] objectForKey:@"name"]);
        cell.textLabel.text = [[self.peopleNoOrderArray objectAtIndex:row] objectForKey:@"name"];
    }
    
    return cell;
}

//section的题目
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    NSString *titleString = [[[NSString alloc] init] autorelease];
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
    return 50;
}

@end