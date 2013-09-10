//
//  OrderViewController.h
//  HelpOrder
//
//  Created by Ralbatr on 13-8-31.
//  Copyright (c) 2013年 Ralbatr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectPeopleTableViewController.h"
#import "SelectRestaurantViewController.h"
#import "SelectPackagesViewController.h"

@protocol OrderViewControllerDelegate <NSObject>

@optional

- (void)orderDetail:(NSInteger)orderDetailCount;

@end

@interface OrderViewController : UIViewController <SelectPeopleTableViewControllerDelegate,SelectRestaurantTableViewControllerDelegate,SelectPackagesViewControllerDelegate>

{
    NSMutableArray *orderArray;//完整的订单
}

@property (nonatomic,retain) NSMutableArray *orderArray;
@property (nonatomic,assign) id <OrderViewControllerDelegate> delegate;

- (void)resetArrayWithFileName:(NSString *)fileName andPeopleName:(NSString *)personNameString;

@end

