//
//  SelectPackagesViewController.m
//  HelpOrder
//
//  Created by Ralbatr on 13-8-31.
//  Copyright (c) 2013年 Ralbatr. All rights reserved.
//

#import "SelectPackagesViewController.h"
#import "SBJson.h"

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
    
    NSString *userPath = [[NSBundle mainBundle] pathForResource:@"foods" ofType:@"json"];
    NSString *jsonString = [NSString stringWithContentsOfFile:userPath encoding:NSUTF8StringEncoding error:NULL];
    
    self.packagesNameArray = [[NSMutableArray alloc] initWithCapacity:10];
    SBJsonParser * parser = [[SBJsonParser alloc] init];
    NSError * error = nil;
    NSMutableDictionary *suitMenuDic = [parser objectWithString:jsonString error:&error];
    NSArray *suitMenuArray1 =  [suitMenuDic objectForKey:self.title];
    
    for (NSDictionary *name in suitMenuArray1) {
        [self.packagesNameArray addObject:[name objectForKey:@"name"]];
        [self.packagesPriceArray addObject:[name objectForKey:@"price"]];
    }
    [self setExtraCellLineHidden:self.tableView];
}

- (void)didReceiveMemoryWarning
{
    [self.packagesPriceArray release];
    [self.packagesNameArray release];
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 子定义方法
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [view release];
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
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SuitMenuIdentifier] autorelease];
    }
    
    // Configure the cell...
    NSUInteger row = [indexPath row];
    CGRect nameLabelRect = CGRectMake(0, 8, 200, 25);
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:nameLabelRect];
    nameLabel.text = [self.packagesNameArray objectAtIndex:row];
    nameLabel.font = [UIFont boldSystemFontOfSize:20];
    [cell.contentView addSubview:nameLabel];
    [nameLabel release];
    
    CGRect priceLabelRect = CGRectMake(230, 5, 70, 15);
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:priceLabelRect];
    NSString *price = [NSString stringWithFormat:@"¥ %@",[self.packagesPriceArray objectAtIndex:row]];
    priceLabel.text = price;
    priceLabel.font = [UIFont boldSystemFontOfSize:14];
    [cell.contentView addSubview:priceLabel];
    [priceLabel release];
    
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    NSLog(@"%@",[self.packagesNameArray objectAtIndex:row]);
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(selectPackagesName:andPrice:)]) {
        NSUInteger row = [indexPath row];
        NSString *packagesName = [self.packagesNameArray objectAtIndex:row];
        NSString *price = [self.packagesPriceArray objectAtIndex:row];
        NSLog(@"suitMentViewController menuName %@ and price %@", packagesName,price);
        [self.delegate selectPackagesName:packagesName andPrice:price];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
