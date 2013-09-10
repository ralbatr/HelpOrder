//
//  CheckTableView.h
//  HelpOrder
//
//  Created by Ralbatr on 13-9-4.
//  Copyright (c) 2013年 Ralbatr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetail.h"

@interface CheckTableView : UIView

- (id)initWithFrame:(CGRect)frame andOrderDetail:(OrderDetail *)orderDetail andPriceColor:(UIColor *)priceColor andExceedPriceColor:(UIColor *)exceedPriceColor;

- (void)showCheckTableVieWithPeopleName:(NSString *)peopleName andRestaurantName:(NSString *)restaurantName andPackagesName:(NSString *)packagesName;

- (void)showStatusViewWithOrderPeopleLength:(int)orderPeopleLength andNoorderLength:(int)NoorderLength andTotalPrice:(float)totalPrice;

- (void)showPriceLableWithPrice:(float)price andPriceColor:(UIColor *)priceColor andExceedPriceColor:(UIColor *)exceedPriceColor;

@end
