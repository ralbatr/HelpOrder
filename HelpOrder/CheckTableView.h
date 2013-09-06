//
//  CheckTableView.h
//  HelpOrder
//
//  Created by Ralbatr on 13-9-4.
//  Copyright (c) 2013年 Ralbatr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckTableView : UIView

- (id)initWithFrame:(CGRect)frame andPeopleName:(NSString *)peopleName andRestaurantName:(NSString *)restaurantName andPackagesName:(NSString *)packagesName andPrice:(float)price andPriceColor:(UIColor *)priceColor andExceedPriceColor:(UIColor *)exceedPriceColor;

- (void)showCheckTableVieWithPeopleName:(NSString *)peopleName andRestaurantName:(NSString *)restaurantName andPackagesName:(NSString *)packagesName;

- (void)showStatusViewWithOrderPeopleLength:(int)orderPeopleLength andNoorderLength:(int)NoorderLength andTotalPrice:(float)totalPrice;
- (void)showPriceLableWithPrice:(float)price andPriceColor:(UIColor *)priceColor andExceedPriceColor:(UIColor *)exceedPriceColor;

@end
