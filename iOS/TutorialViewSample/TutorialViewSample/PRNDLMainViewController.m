//The MIT License (MIT)
//
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.
//
//Created By David Benko on 5/15/2013

#import "PRNDLMainViewController.h"

@interface PRNDLMainViewController ()
@property (nonatomic, strong) TutorialView *tutorialView;
- (void)setupTutorialView;
- (void)setupDrawButton;
@end

@implementation PRNDLMainViewController
@synthesize tutorialView = _tutorialView;

#pragma mark - View Setup

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTutorialView];
}
- (void)setupTutorialView {
    self.tutorialView = [[TutorialView alloc]initWithFrame:self.view.bounds];
    self.tutorialView.delegate = self;
    [self.view addSubview:self.tutorialView];
    [self setupDrawButton];
}
- (void)setupDrawButton {
    UIButton *drawButton = [[UIButton alloc]initWithFrame:CGRectMake(110 , 420, 100, 30)];
    [drawButton setBackgroundColor:[UIColor whiteColor]];
    [drawButton setTitle:@"Draw" forState:UIControlStateNormal];
    [drawButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [drawButton addTarget:self action:@selector(drawArrow) forControlEvents:UIControlEventTouchUpInside];
    [self.tutorialView addSubview:drawButton];
}

#pragma mark - Arrow

- (IBAction)drawArrow
{
    if(!self.tutorialView)[self setupTutorialView];
    
    Arrow *a = [[Arrow alloc]init];
    a.head = CGPointMake(arc4random() % 300, arc4random() % 300);
    a.tail = CGPointMake(arc4random() % 300, arc4random() % 300);
    a.curved = floorf((arc4random() % 2));
    a.direction = floorf((arc4random() % 2));
    [self.tutorialView addArrow:a];
}

#pragma mark - TutorialViewDelegate

- (BOOL)tutorialView:(TutorialView *)tutorialView shouldDismissAnimated:(bool *)animated{
    //Override TutorialView Dismiss
    NSLog(@"TutorialView should dismiss");
    return true;
}
- (void)tutorialView:(TutorialView *)tutorialView didDismissAnimated:(BOOL)animated{
    NSLog(@"TutorialView did dismiss");
}
- (BOOL)tutorialView:(TutorialView *)tutorialView shouldDrawPath:(CGPathRef)path animated:(BOOL)animated{
    //Override Path Drawing
    NSLog(@"TutorialView shouldDrawPath animated=%@", animated ? @"YES" : @"NO");
    return true;
}
- (void)tutorialView:(TutorialView *)tutorialView didDrawPath:(CGPathRef)path {
    NSLog(@"TutorialView didDrawPath");
}

@end
