//
//  PRNDLFlipsideViewController.h
//  TutorialViewSample
//
//  Created by David Benko on 5/18/13.
//  Copyright (c) 2013 PRNDL Development Studios, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PRNDLFlipsideViewController;

@protocol PRNDLFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(PRNDLFlipsideViewController *)controller;
@end

@interface PRNDLFlipsideViewController : UIViewController

@property (weak, nonatomic) id <PRNDLFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
