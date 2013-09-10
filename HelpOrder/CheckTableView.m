//
//  CheckTableView.m
//  HelpOrder
//
//  Created by Ralbatr on 13-9-4.
//  Copyright (c) 2013年 Ralbatr. All rights reserved.
//

#import "CheckTableView.h"

@implementation CheckTableView

- (id)initWithFrame:(CGRect)frame andOrderDetail:(OrderDetail *)orderDetail andPriceColor:(UIColor *)priceColor andExceedPriceColor:(UIColor *)exceedPriceColor
{
    self = [super initWithFrame:frame];
    if (self) {
        OrderDetail *_orderDetail = orderDetail;
        [self showCheckTableVieWithPeopleName:_orderDetail.peopleName andRestaurantName:_orderDetail.restaurantName andPackagesName:_orderDetail.packagesName];
        [self showPriceLableWithPrice:[_orderDetail.price floatValue] andPriceColor:priceColor andExceedPriceColor:exceedPriceColor];
    }
    return self;
}

- (void)showCheckTableVieWithPeopleName:(NSString *)peopleName andRestaurantName:(NSString *)restaurantName andPackagesName:(NSString *)packagesName
{
    // 人名的显示 label
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 5, 150, 18)];
    nameLabel.text = peopleName;
    nameLabel.font = [UIFont boldSystemFontOfSize:20];
    [self addSubview:nameLabel];
    // 餐厅 和 套餐 的显示 label
    UILabel *restaurantLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 25, 250, 14)];
    restaurantLabel.text = [NSString stringWithFormat:@"%@ %@",restaurantName,packagesName];
    restaurantLabel.font = [UIFont boldSystemFontOfSize:14];
    [self addSubview:restaurantLabel];    
}

- (void)showPriceLableWithPrice:(float)price andPriceColor:(UIColor *)priceColor andExceedPriceColor:(UIColor *)exceedPriceColor
{
    // 价格显示 label
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(230, 5, 70, 15)];
    priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",price];
    priceLabel.textColor = priceColor;
    priceLabel.font = [UIFont boldSystemFontOfSize:14];
    [self addSubview:priceLabel];
    // 超出12元显示
    UILabel *exceedPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(230, 25, 70, 15)];
    exceedPriceLabel.text = [NSString stringWithFormat:@"¥ %.2f",price - 12];
    exceedPriceLabel.textColor = exceedPriceColor;
    exceedPriceLabel.font = [UIFont boldSystemFontOfSize:14];
    [self addSubview:exceedPriceLabel];
}

- (void)showStatusViewWithOrderPeopleLength:(int)orderPeopleLength andNoorderLength:(int)unorderLength andTotalPrice:(float)totalPrice
{
    // 状态框
    UIToolbar *statusView = [[UIToolbar alloc] initWithFrame:CGRectMake(0,380,320,44)];
    statusView.backgroundColor = [UIColor blackColor];
    statusView.barStyle = UIBarStyleBlack;
    [self addSubview:statusView];
    // 显示 订单 统计
    UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 380, 320, 45)];
    statusLabel.textAlignment = NSTextAlignmentCenter;
    statusLabel.textColor = [UIColor whiteColor];
    statusLabel.backgroundColor = [UIColor clearColor];
    statusLabel.font = [UIFont boldSystemFontOfSize:18];
    NSString *statusString = [NSString stringWithFormat:@"%d人已定,%d人未定,总计%.2f元",orderPeopleLength,unorderLength,totalPrice];
    statusLabel.text = statusString;
    statusLabel.tag = 301;
    [self addSubview:statusLabel];
}

@end
