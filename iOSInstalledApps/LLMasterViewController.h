//
//  LLMasterViewController.h
//  iOSInstalledApps
//
//  Created by Aravind Krishnaswamy on 02/09/12.
//  Copyright (c) 2012 Aravind Krishnaswamy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LLDetailViewController;

@interface LLMasterViewController : UITableViewController

@property (strong, nonatomic) LLDetailViewController *detailViewController;

@end
