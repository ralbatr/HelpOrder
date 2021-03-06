//
//  SelectPeopleTableViewController.m
//  HelpOrder
//
//  Created by Ralbatr on 13-8-31.
//  Copyright (c) 2013年 Ralbatr. All rights reserved.
//

#import "SelectPeopleTableViewController.h"
#import "SBJson.h"
#import "ReadJson.h"

@interface SelectPeopleTableViewController ()

@end

@implementation SelectPeopleTableViewController
@synthesize peopleArray;
@synthesize delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.peopleArray = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"选 人";    
    ReadJson *readJson = [[ReadJson alloc] init];
    NSMutableArray *peopleArray1 = [readJson readJosonwithFileName:@"users"];
    
    for (int i = 0; i < [peopleArray1 count]; i++) {
        [self.peopleArray addObject:[[peopleArray1 objectAtIndex:i] objectForKey:@"name"]];
    }
    //隐藏ViewTable的白线
    [self setExtraCellLineHidden:self.tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    return [self.peopleArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *PeopleCell = @"PeopleCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PeopleCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PeopleCell];
    }

    NSUInteger row = [indexPath row];
    cell.textLabel.text = [self.peopleArray objectAtIndex:row];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(selectPeopleName:)]) {
        NSUInteger row = [indexPath row];
        NSString *name = [self.peopleArray objectAtIndex:row];
        [self.delegate selectPeopleName:name];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
