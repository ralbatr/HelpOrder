//
//  SelectPeopleTableViewController.m
//  HelpOrder
//
//  Created by Ralbatr on 13-8-31.
//  Copyright (c) 2013年 Ralbatr. All rights reserved.
//

#import "SelectPeopleTableViewController.h"
#import "SBJson.h"

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
        self.title = @"选 人";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString *userPath = [[NSBundle mainBundle] pathForResource:@"users" ofType:@"json"];
    NSString *jsonString = [NSString stringWithContentsOfFile:userPath encoding:NSUTF8StringEncoding error:NULL];
    
    SBJsonParser * parser = [[SBJsonParser alloc] init];
    NSError * error = nil;
    NSMutableArray *peopleArray1 = [parser objectWithString:jsonString error:&error];
    
    int length = [peopleArray1 count];
    for (int i = 0; i < length; i++) {
        [self.peopleArray addObject:[[peopleArray1 objectAtIndex:i] objectForKey:@"name"]];
    }
    //隐藏ViewTable的白线
    [self setExtraCellLineHidden:self.tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [peopleArray release];
    [super dealloc];
}

#pragma mark - 自定义的方法
//隐藏ViewTable的白线
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
    // Return the number of rows in the section.
    return [self.peopleArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *PeopleCell = @"PeopleCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PeopleCell];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PeopleCell] autorelease];
    }
    
    // Configure the cell...
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [self.peopleArray objectAtIndex:row];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    NSLog(@"%@",[self.peopleArray objectAtIndex:row]);
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
