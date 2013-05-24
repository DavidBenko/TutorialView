//
//  PRNDLFlipsideViewController.m
//  TutorialViewSample
//
//  Created by David Benko on 5/18/13.
//  Copyright (c) 2013 PRNDL Development Studios, LLC. All rights reserved.
//

#import "PRNDLFlipsideViewController.h"

@interface PRNDLFlipsideViewController ()

@end

@implementation PRNDLFlipsideViewController

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

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end
