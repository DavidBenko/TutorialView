//
//  PRNDLMainViewController.m
//  TutorialViewSample
//
//  Created by David Benko on 5/18/13.
//  Copyright (c) 2013 PRNDL Development Studios, LLC. All rights reserved.
//

#import "PRNDLMainViewController.h"
#import "TutorialView.h"
#import "Arrow.h"

@interface PRNDLMainViewController ()

@end

@implementation PRNDLMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    TutorialView *tut = [[TutorialView alloc]initWithFrame:self.view.bounds];
    Arrow *a = [[Arrow alloc]init];
    a.head = CGPointMake(200, 200);
    a.tail = CGPointMake(300, 350);
    a.curved = NO;
    a.animated = NO;
    [tut addArrow:a];
    
    a = [[Arrow alloc]init];
    a.head = CGPointMake(200, 200);
    a.tail = CGPointMake(300, 350);
    [tut addArrow:a];

    
    [self.view addSubview:tut];
    
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
    TutorialView *tut = [[TutorialView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:tut];
    
    Arrow *a = [[Arrow alloc]init];
    a.head = CGPointMake(200, 200);
    a.tail = CGPointMake(300, 350);
    [tut addArrow:a];
    
    /*PRNDLFlipsideViewController *controller = [[PRNDLFlipsideViewController alloc] initWithNibName:@"PRNDLFlipsideViewController" bundle:nil];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];*/
}

@end
