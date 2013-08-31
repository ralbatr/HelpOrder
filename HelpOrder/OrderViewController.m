//
//  OrderViewController.m
//  HelpOrder
//
//  Created by Ralbatr on 13-8-31.
//  Copyright (c) 2013年 Ralbatr. All rights reserved.
//

#import "OrderViewController.h"
#import "SelectPeopleTableViewController.h"
#import "SelectRestaurantViewController.h"
#import "SelectPackagesViewController.h"

@interface OrderViewController ()

@end

@implementation OrderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"订 餐";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	UIButton *resignKeyBoardButton = [[UIButton alloc] init];
    resignKeyBoardButton.frame = CGRectMake(0, 0, 320, 260);
    [resignKeyBoardButton addTarget:self action:@selector(resignKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resignKeyBoardButton];
    [resignKeyBoardButton release];
    
    UILabel *personLabel = [[UILabel alloc] init];
    personLabel.frame = CGRectMake(10, 0, 40, 40);
    personLabel.text = @"人：";
    [self.view addSubview:personLabel];
    [personLabel release];
    
    UITextField *personTextField = [[UITextField alloc] init];
    personTextField.frame = CGRectMake(10, 43, 300, 35);
    personTextField.borderStyle = UITextBorderStyleRoundedRect;
    personTextField.adjustsFontSizeToFitWidth = YES;
    personTextField.tag = 101;
    personTextField.delegate = self;
    [self.view addSubview:personTextField];
    [personTextField release];
    
    UIButton *personButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    personButton.frame = CGRectMake(10, 81, 300, 35);
    [personButton setTitle:@"选 人" forState:UIControlStateNormal];
    [personButton addTarget:self action:@selector(personMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:personButton];
    
    UILabel *restaurantLabel = [[UILabel alloc] init];
    restaurantLabel.frame = CGRectMake(10, 119, 80, 35);
    restaurantLabel.text = @"餐厅：";
    [self.view addSubview:restaurantLabel];
    [restaurantLabel release];
    
    UITextField *restauranTextField = [[UITextField alloc] init];
    restauranTextField.frame = CGRectMake(10, 157, 300, 35);
    restauranTextField.tag = 102;
    restauranTextField.borderStyle = UITextBorderStyleRoundedRect;
    restauranTextField.adjustsFontSizeToFitWidth = YES;
    restauranTextField.delegate = self;
    [self.view addSubview:restauranTextField];
    [restauranTextField release];
    
    UIButton *restauranButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    restauranButton.frame = CGRectMake(10, 195, 300, 35);
    [restauranButton setTitle:@"选餐厅" forState:UIControlStateNormal];
    [restauranButton addTarget:self action:@selector(rastauranMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:restauranButton];
    
    UILabel *suitLabel = [[UILabel alloc] init];
    suitLabel.frame = CGRectMake(10, 233, 80, 40);
    suitLabel.text = @"套餐：";
    [self.view addSubview:suitLabel];
    [suitLabel release];
    
    UITextField *suitTextField = [[UITextField alloc] init];
    suitTextField.frame = CGRectMake(10, 276, 300, 35);
    suitTextField.borderStyle = UITextBorderStyleRoundedRect;
    suitTextField.adjustsFontSizeToFitWidth = YES;
    suitTextField.tag = 103;
    suitTextField.delegate = self;
    [self.view addSubview:suitTextField];
    [suitTextField release];
    
    UIButton *packagesButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    packagesButton.frame = CGRectMake(10, 314, 300, 35);
    [packagesButton setTitle:@"选套餐" forState:UIControlStateNormal];
    [packagesButton addTarget:self action:@selector(packagesMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:packagesButton];
    
    UIButton *affirmButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    affirmButton.frame = CGRectMake(10, 352, 300, 35);
    [affirmButton setTitle:@"确认" forState:UIControlStateNormal];
    [affirmButton addTarget:self action:@selector(affirmMethod) forControlEvents:UIControlEventTouchUpInside];
    affirmButton.tag = 105;
    //初始后， 确认 按钮不可用
//    [affirmButton setEnabled:NO];
    [self.view addSubview:affirmButton];
    
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.tag = 104;
    [self.view addSubview:priceLabel];
    [priceLabel release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -自定义方法
- (void)personMethod
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    [backItem release];
    SelectPeopleTableViewController *selectPeopleView = [[SelectPeopleTableViewController alloc] init];
//    selectPeopleView.delegate = self;
    [self.navigationController pushViewController:selectPeopleView animated:YES];
    [selectPeopleView release];
    
    UITextField *suitTextField = (UITextField *)[self.view viewWithTag:103];
    if (suitTextField.text.length > 0) {
        UIButton *affirmButton = (UIButton *)[self.view viewWithTag:105];
        [affirmButton setEnabled:YES];
    }
}

- (void)rastauranMethod
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    [backItem release];
    SelectRestaurantViewController *selectRastaurant = [[SelectRestaurantViewController alloc] init];
//    selectRastaurant.delegate = self;
    [self.navigationController pushViewController:selectRastaurant animated:YES];
    [selectRastaurant release];
}

- (void)packagesMethod
{
    SelectPackagesViewController *selectPackagesViewController = [[SelectPackagesViewController alloc] init];
    selectPackagesViewController.title = @"选套餐";
    [self.navigationController pushViewController:selectPackagesViewController animated:YES];
    [selectPackagesViewController release];
}

//确认按钮
- (void)affirmMethod
{
}

@end
