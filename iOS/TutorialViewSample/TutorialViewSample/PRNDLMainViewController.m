//
//  PRNDLMainViewController.m
//  TutorialViewSample
//
//  Created by David Benko on 5/18/13.
//  Copyright (c) 2013 PRNDL Development Studios, LLC. All rights reserved.
//

#import "PRNDLMainViewController.h"

@interface PRNDLMainViewController ()

@end

@implementation PRNDLMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(PRNDLFlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showInfo:(id)sender
{    
    PRNDLFlipsideViewController *controller = [[PRNDLFlipsideViewController alloc] initWithNibName:@"PRNDLFlipsideViewController" bundle:nil];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
}

@end
