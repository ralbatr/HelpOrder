//
//  SelectPackagesViewController.h
//  HelpOrder
//
//  Created by Ralbatr on 13-8-31.
//  Copyright (c) 2013年 Ralbatr. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectPackagesViewControllerDelegate <NSObject>

@optional

- (void)selectPackagesName:(NSString *)menuName andPrice:(id)price;

@end

@interface SelectPackagesViewController : UITableViewController <UITableViewDataSource,UITableViewDelegate>

{
    NSMutableArray *packagesNameArray;
    NSMutableArray *packagesPriceArray;
}

@property (nonatomic,retain) NSMutableArray *packagesNameArray;
@property (nonatomic,retain) NSMutableArray *packagesPriceArray;
@property (nonatomic,assign) id <SelectPackagesViewControllerDelegate> delegate;

@end
