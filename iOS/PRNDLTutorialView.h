//The MIT License (MIT)
//
//Copyright (c) 2013 PRNDL Development Studios, LLC
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

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreText/CoreText.h>

#define VIEW_ALPHA 0.8f
#define VIEW_COLOR [UIColor blackColor]
#define LINE_WIDTH 3.0f
#define ARROW_HEAD_LENGTH(arrowLen) arrowLen / 8.5f
#define ARROW_COLOR [[UIColor whiteColor] CGColor]
#define DRAW_ANIMATION_SPEED 0.4f
#define DISMISS_ANIMATION_SPEED 0.5f
#define TIP_FRAME_PADDING 15.0f

@interface PRNDLTutorialView : UIView

-(void)drawArrowWithHead:(CGPoint)head andTail:(CGPoint)tail;
-(void)drawArrowWithHead:(CGPoint)head andTail:(CGPoint)tail curved:(BOOL)curve;
-(void)drawArrowWithHead:(CGPoint)head andTail:(CGPoint)tail animated:(BOOL)animated;
-(void)drawArrowWithHead:(CGPoint)head andTail:(CGPoint)tail curved:(BOOL)curve animated:(BOOL)animated;
-(void)dismissViewAnimated:(BOOL)animated;

@end
