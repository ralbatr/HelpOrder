//
//  SelectPeopleTableViewController.h
//  HelpOrder
//
//  Created by Ralbatr on 13-8-31.
//  Copyright (c) 2013年 Ralbatr. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectPeopleTableViewControllerDelegate <NSObject>

@optional

- (void)selectPeopleName:(NSString *)name;

@end

@interface SelectPeopleTableViewController : UITableViewController <UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *peopleArray ;
}

@property (nonatomic,retain) NSMutableArray *peopleArray ;
@property (nonatomic,assign) id <SelectPeopleTableViewControllerDelegate> delegate;

@end

