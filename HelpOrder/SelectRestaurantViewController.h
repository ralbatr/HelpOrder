//
//  SelectRestaurantViewController.h
//  HelpOrder
//
//  Created by Ralbatr on 13-8-31.
//  Copyright (c) 2013年 Ralbatr. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectRestaurantTableViewControllerDelegate <NSObject>

@optional

- (void)selectRestaurantName:(NSString *)name;

@end

@interface SelectRestaurantViewController : UITableViewController <UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *restaurantArray;
}

@property (nonatomic,retain) NSMutableArray *restaurantArray;
@property (nonatomic,assign) id <SelectRestaurantTableViewControllerDelegate> delegate;

@end
