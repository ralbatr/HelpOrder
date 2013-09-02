//
//  OrderViewController.m
//  HelpOrder
//
//  Created by Ralbatr on 13-8-31.
//  Copyright (c) 2013年 Ralbatr. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderDetail.h"

@interface OrderViewController ()

@end

@implementation OrderViewController

@synthesize delegate;
@synthesize orderArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"订 餐";
        self.orderArray = [[NSMutableArray alloc] initWithCapacity:10];
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
    
    UILabel *packagesLabel = [[UILabel alloc] init];
    packagesLabel.frame = CGRectMake(10, 233, 80, 40);
    packagesLabel.text = @"套餐：";
    [self.view addSubview:packagesLabel];
    [packagesLabel release];
    
    UITextField *packagesTextField = [[UITextField alloc] init];
    packagesTextField.frame = CGRectMake(10, 276, 300, 35);
    packagesTextField.borderStyle = UITextBorderStyleRoundedRect;
    packagesTextField.adjustsFontSizeToFitWidth = YES;
    packagesTextField.tag = 103;
    packagesTextField.delegate = self;
    [self.view addSubview:packagesTextField];
    [packagesTextField release];
    
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
    [affirmButton setEnabled:NO];
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

- (void)dealloc
{
    [orderArray release];
    [super dealloc];
}

#pragma mark -自定义方法
- (void)personMethod
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    [backItem release];
    SelectPeopleTableViewController *selectPeopleView = [[SelectPeopleTableViewController alloc] init];
    selectPeopleView.delegate = self;
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
    selectRastaurant.delegate = self;
    [self.navigationController pushViewController:selectRastaurant animated:YES];
    [selectRastaurant release];
}

- (void)packagesMethod
{
    UITextField *restaurantTextField = (UITextField *)[self.view viewWithTag:102];
    NSString *restaurantName = restaurantTextField.text;
    if (restaurantName != nil) {
        NSLog(@"%@",restaurantName);
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
        [self.navigationItem setBackBarButtonItem:backItem];
        [backItem release];
        SelectPackagesViewController *selectPackagesViewController = [[SelectPackagesViewController alloc] init];
        selectPackagesViewController.title = restaurantName;
        selectPackagesViewController.delegate = self;
        [self.navigationController pushViewController:selectPackagesViewController animated:YES];
        [selectPackagesViewController release];
        
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请先选择餐厅，再选择套餐！" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
        [alertView release];
    }
}

//处理键盘，在空白处 点击 释放键盘
- (void)resignKeyBoard
{
    [self.view endEditing:YES];
}
//textField处理返回健 ，需要设置代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

//确认按钮
- (void)affirmMethod
{
    UITextField *nameTextField = (UITextField *)[self.view viewWithTag:101];
    UITextField *restaurantTextField = (UITextField *)[self.view viewWithTag:102];
    UITextField *packagesNameTextField = (UITextField *)[self.view viewWithTag:103];
    UILabel *priceLabel = (UILabel *)[self.view viewWithTag:104];
    
    NSString *personNameString = nameTextField.text;
    NSString *packagesNameString = packagesNameTextField.text;
    NSString *restaurantNameString = restaurantTextField.text;
    NSString *priceString = priceLabel.text;
    
    // 查看 数组中 是否这个人 已经订餐
    int length = [self.orderArray count];
    for (int i = 0;i < length;i++) {
        OrderDetail *orderDtail = [[[OrderDetail alloc] init] autorelease];
        orderDtail = [self.orderArray objectAtIndex:i];
        //当这个人已经订餐，删除原来的
        if ([orderDtail.peopleName isEqualToString:personNameString]) {
            [self.orderArray removeObjectAtIndex:i];
            i = [self.orderArray count];
        }
    }
    //把这个人的信息，写到数组中
    OrderDetail *orderDetail = [[OrderDetail alloc] initWithPeopleName:personNameString andRestaurantName:restaurantNameString andPackagesName:packagesNameString andPrice:priceString];
    [orderArray addObject:orderDetail];
    [orderDetail release];
    
    //清空人名选择和套餐选择输入框
    nameTextField.text = @"";
    packagesNameTextField.text = @"";
    //重新置 确定按钮不可用
    UIButton *affirmButton = (UIButton *)[self.view viewWithTag:105];
    [affirmButton setEnabled:NO];
    
    //调用代理
    if ([self.delegate respondsToSelector:@selector(orderDetail:)]) {
        [self.delegate orderDetail:orderArray];
    }
}

#pragma mark - delegate
- (void)selectPeopleName:(NSString *)name
{
    UITextField *nameTextField = (UITextField *)[self.view viewWithTag:101];
    nameTextField.text = name;
}

- (void)selectRestaurantName:(NSString *)name
{
    UITextField *restaurantTextField = (UITextField *)[self.view viewWithTag:102];
    restaurantTextField.text = name;
}

- (void)selectPackagesName:(NSString *)menuName andPrice:(id)price
{
    UITextField *menuNameTextField = (UITextField *)[self.view viewWithTag:103];
    menuNameTextField.text = menuName;
    NSString *priceString = [NSString stringWithFormat:@"%@",price];
    UILabel *priceLabel = (UILabel *)[self.view viewWithTag:104];
    priceLabel.text = priceString;
    UITextField *nameTextField = (UITextField *)[self.view viewWithTag:101];;
    if (nameTextField.text.length > 0 && menuNameTextField.text.length > 0) {
        UIButton *affirmButton = (UIButton *)[self.view viewWithTag:105];
        [affirmButton setEnabled:YES];
    }
}

@end
