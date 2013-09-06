//
//  SelectRestaurantViewController.m
//  HelpOrder
//
//  Created by Ralbatr on 13-8-31.
//  Copyright (c) 2013年 Ralbatr. All rights reserved.
//

#import "SelectRestaurantViewController.h"
#import "SBJson.h"
#import "ReadJson.h"

@interface SelectRestaurantViewController ()

@end

@implementation SelectRestaurantViewController
@synthesize restaurantArray;
@synthesize delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.restaurantArray = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //读取 restaurants.json
    ReadJson *readJson = [[ReadJson alloc] init];
    NSMutableArray *restaurantArray1 = [readJson readJosonwithFileName:@"restaurants"];
    
    int length = [restaurantArray1 count];
    for (int i = 0; i < length; i++) {
        [self.restaurantArray addObject:[[restaurantArray1 objectAtIndex:i] objectForKey:@"name"]];
    }
    [self setExtraCellLineHidden:self.tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 自定义的方法
//隐藏ViewTable的白线
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.restaurantArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *RestaurantCell = @"RestaurantCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RestaurantCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RestaurantCell];
    }
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [self.restaurantArray objectAtIndex:row];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(selectRestaurantName:)]) {
        NSUInteger row = [indexPath row];
        NSString *restaurantName = [self.restaurantArray objectAtIndex:row];
        [self.delegate selectRestaurantName:restaurantName];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end