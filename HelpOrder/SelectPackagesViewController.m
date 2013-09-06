//
//  SelectPackagesViewController.m
//  HelpOrder
//
//  Created by Ralbatr on 13-8-31.
//  Copyright (c) 2013年 Ralbatr. All rights reserved.
//

#import "SelectPackagesViewController.h"
#import "SBJson.h"
#import "ReadJson.h"
#import "SelectPackages.h"

@interface SelectPackagesViewController ()

@end

@implementation SelectPackagesViewController

@synthesize packagesNameArray;
@synthesize packagesPriceArray;
@synthesize delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.packagesNameArray = [[NSMutableArray alloc] initWithCapacity:10];
        self.packagesPriceArray = [[NSMutableArray alloc] initWithCapacity:10];
        self.title = @"选套餐";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //读取 users.json
    ReadJson *readJson = [[ReadJson alloc] init];
    NSMutableDictionary *suitMenuDic = [readJson readJosonwithFileName:@"foods"];
    
    NSArray *suitMenuArray1 =  [suitMenuDic objectForKey:self.title];
    for (NSDictionary *name in suitMenuArray1) {
        [self.packagesNameArray addObject:[name objectForKey:@"name"]];
        [self.packagesPriceArray addObject:[name objectForKey:@"price"]];
    }
    [self setExtraCellLineHidden:self.tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 子定义方法
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.packagesNameArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SuitMenuIdentifier = @"SuitMenuIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SuitMenuIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SuitMenuIdentifier];
    }
    
    NSUInteger row = [indexPath row];
    NSString *name = [self.packagesNameArray objectAtIndex:row];
    NSString *price = [self.packagesPriceArray objectAtIndex:row];
    SelectPackages *selectView = [[SelectPackages alloc] initWithFrame:CGRectMake(0, 0, 320, 100) andName:name andPrice:price];
    [cell.contentView addSubview:selectView];
    
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(selectPackagesName:andPrice:)]) {
        NSUInteger row = [indexPath row];
        NSString *packagesName = [self.packagesNameArray objectAtIndex:row];
        NSString *price = [self.packagesPriceArray objectAtIndex:row];
        [self.delegate selectPackagesName:packagesName andPrice:price];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
