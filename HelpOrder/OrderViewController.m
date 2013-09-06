//
//  OrderViewController.m
//  HelpOrder
//
//  Created by Ralbatr on 13-8-31.
//  Copyright (c) 2013年 Ralbatr. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderView.h"
#import "OrderDetail.h"
#import "SBJson.h"

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
    //加载 view 显示
    OrderView *orderView = [[OrderView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) andTarget:self andPersonSEL:@selector(personMethod) andRastauranSEL:@selector(rastauranMethod) andPackagesSEL:@selector(packagesMethod) andAffirmSEL:@selector(affirmMethod)];
    [self.view addSubview:orderView];
    //价格
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.tag = 104;
    [self.view addSubview:priceLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -自定义方法
- (void)personMethod
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    SelectPeopleTableViewController *selectPeopleView = [[SelectPeopleTableViewController alloc] init];
    selectPeopleView.delegate = self;
    [self.navigationController pushViewController:selectPeopleView animated:YES];
    //如果 套餐 不为空 确认 按钮 可用
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
    SelectRestaurantViewController *selectRastaurant = [[SelectRestaurantViewController alloc] init];
    selectRastaurant.delegate = self;
    [self.navigationController pushViewController:selectRastaurant animated:YES];
}

- (void)packagesMethod
{
    UITextField *restaurantTextField = (UITextField *)[self.view viewWithTag:102];
    NSString *restaurantName = restaurantTextField.text;
    if (restaurantName != nil) {
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
        [self.navigationItem setBackBarButtonItem:backItem];
        SelectPackagesViewController *selectPackagesViewController = [[SelectPackagesViewController alloc] init];
        selectPackagesViewController.title = restaurantName;
        selectPackagesViewController.delegate = self;
        [self.navigationController pushViewController:selectPackagesViewController animated:YES];
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请先选择餐厅，再选择套餐！" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
    }
}

//确认按钮
- (void)affirmMethod
{
    UITextField *nameTextField = (UITextField *)[self.view viewWithTag:101];
    UITextField *restaurantTextField = (UITextField *)[self.view viewWithTag:102];
    UITextField *packagesNameTextField = (UITextField *)[self.view viewWithTag:103];
    UILabel *priceLabel = (UILabel *)[self.view viewWithTag:104];
    NSString *personNameString = nameTextField.text;    
    //要往沙盒中写数据获取的沙盒目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath=[paths objectAtIndex:0];
    //取得完整的文件名
    NSString *fileName=[plistPath stringByAppendingPathComponent:@"orderDetail.json"];
    //把 再次订餐的人 删除原来的
    [self resetArrayWithFileName:fileName andPeopleName:personNameString];
    //把这个人的信息，写到数组中
    OrderDetail *orderDetail = [[OrderDetail alloc] initWithPeopleName:personNameString andRestaurantName:restaurantTextField.text andPackagesName:packagesNameTextField.text andPrice:priceLabel.text];
    [orderArray addObject:orderDetail];
    //写到json文件中
    [self writeJsonWithFileName:fileName];
    //重置
    [self reset];
    //调用代理
    if ([self.delegate respondsToSelector:@selector(orderDetail:)]) {
        [self.delegate orderDetail:orderArray];
    }
}

- (void)writeJsonWithFileName:(NSString *)fileName
{
    //把数组重新写到 orderDetail.json
    NSMutableArray *array = [[NSMutableArray alloc] init];
    int orderLength = [orderArray count];
    for (int i = 0 ; i < orderLength ; i++) {
        OrderDetail *orderDetailWrite = [[OrderDetail alloc] init];
        orderDetailWrite = [orderArray objectAtIndex:i];
        NSDictionary *dictonary = [[NSMutableDictionary alloc] init];
        [dictonary setValue:orderDetailWrite.peopleName forKey:@"PeopleName"];
        [dictonary setValue:orderDetailWrite.restaurantName forKey:@"RestaurantName"];
        [dictonary setValue:orderDetailWrite.packagesName forKey:@"PackagesName"];
        [dictonary setValue:orderDetailWrite.price forKey:@"price"];
        [array addObject:dictonary];
    }
    //转换json格式
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    NSString *value = [writer stringWithObject:array];
    //创建并写入文件
    [value writeToFile:fileName atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

- (void)resetArrayWithFileName:(NSString *)fileName andPeopleName:(NSString *)personNameString
{
    NSString *writeData = [[NSString alloc] initWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
    if (![writeData isEqual: @""]) {
        SBJsonParser * parser = [[SBJsonParser alloc] init];
        NSMutableArray *orderDetailArray = [parser objectWithString:writeData error:nil];
        //先清空之前 数据， 防止连续两次添加
        [orderArray removeAllObjects];
        //获取 订单的数组 orderArray
        [self getOrderPeople:orderDetailArray];
        //移出 订单的人
        [self removeOrderPeople:personNameString];
    }
}

- (void)getOrderPeople:(NSMutableArray *)orderDetailArray
{
    int orderlength = [orderDetailArray count];
    for (int i = 0; i < orderlength; i++) {
        OrderDetail *orderDetailAdd = [[OrderDetail alloc] init];
        orderDetailAdd.peopleName = [[orderDetailArray objectAtIndex:i] objectForKey:@"PeopleName"];
        orderDetailAdd.packagesName = [[orderDetailArray objectAtIndex:i] objectForKey:@"PackagesName"];
        orderDetailAdd.restaurantName = [[orderDetailArray objectAtIndex:i] objectForKey:@"RestaurantName"];
        orderDetailAdd.price = [[orderDetailArray objectAtIndex:i] objectForKey:@"price"];
        [self.orderArray addObject:orderDetailAdd];
    }

}

- (void)removeOrderPeople:(NSString *)personNameString
{
    // 查看 数组中 是否这个人 已经订餐
    int length = [self.orderArray count];
    for (int i = 0;i < length;i++) {
        OrderDetail *orderDtail = [[OrderDetail alloc] init];
        orderDtail = [self.orderArray objectAtIndex:i];
        //当这个人已经订餐，删除原来的
        if ([orderDtail.peopleName isEqualToString:personNameString]) {
            [self.orderArray removeObjectAtIndex:i];
            i = [self.orderArray count];
        }
    }
}

- (void)reset
{
    //清空人名选择和套餐选择输入框
    UITextField *nameTextField = (UITextField *)[self.view viewWithTag:101];
    UITextField *packagesNameTextField = (UITextField *)[self.view viewWithTag:103];
    nameTextField.text = @"";
    packagesNameTextField.text = @"";
    //重新置 确定按钮不可用
    UIButton *affirmButton = (UIButton *)[self.view viewWithTag:105];
    [affirmButton setEnabled:NO];
}
//关闭软键盘
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.view endEditing:YES];
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
