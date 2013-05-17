//
//  APTutorialView.h
//  MSPatient
//
//  Created by David Benko on 5/15/13.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreText/CoreText.h>

#define VIEW_ALPHA 0.8f
#define VIEW_COLOR [UIColor blackColor]
#define LINE_WIDTH 3.0f
#define ARROW_HEAD_LENGTH(arrowLen) arrowLen / 8.5f
#define ARROW_COLOR [[UIColor whiteColor] CGColor]
#define CIRCLE_RADIUS 100.0f
#define DRAW_ANIMATION_SPEED 0.4f
#define DISMISS_ANIMATION_SPEED 0.5f
#define TIP_FRAME_PADDING 15.0f

@interface APTutorialView : UIView

-(void)drawArrowWithHead:(CGPoint)head andTail:(CGPoint)tail;
-(void)drawArrowWithHead:(CGPoint)head andTail:(CGPoint)tail curved:(BOOL)curve;
-(void)drawArrowWithHead:(CGPoint)head andTail:(CGPoint)tail animated:(BOOL)animated;
-(void)drawArrowWithHead:(CGPoint)head andTail:(CGPoint)tail curved:(BOOL)curve animated:(BOOL)animated;
-(void)dismissViewAnimated:(BOOL)animated;

@end
