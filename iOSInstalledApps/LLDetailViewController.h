//
//  LLDetailViewController.h
//  iOSInstalledApps
//
//  Created by Aravind Krishnaswamy on 02/09/12.
//  Copyright (c) 2012 Aravind Krishnaswamy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
