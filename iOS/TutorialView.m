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

#import "TutorialView.h"

@interface TutorialView ()
@property (nonatomic,strong) NSMutableArray *arrows;
@property (nonatomic, assign) CGMutablePathRef pathNoAnimation;
@property (nonatomic, assign) CGMutablePathRef pathAnimated;
@end

@implementation TutorialView

@synthesize arrows;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:VIEW_COLOR];
        [self setAlpha:VIEW_ALPHA];
        [self setDelegate:nil];
        arrows = [[NSMutableArray alloc]init];
        UITapGestureRecognizer *singleFingerTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(dismissView)];
        [self addGestureRecognizer:singleFingerTap];
    }
    
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [self drawPath];
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (CGPoint)getClosestPointInRect:(CGRect)rect toPoint:(CGPoint)point {
    CGFloat x_min = rect.origin.x;
    CGFloat y_min = rect.origin.y;
    CGFloat x_max = rect.origin.x + rect.size.width;
    CGFloat y_max = rect.origin.y + rect.size.height;
    
    CGFloat close_x;
    CGFloat close_y;
    
    if (point.x < x_min) close_x = x_min;
    else if (point.x > x_max) close_x = x_max;
    else close_x = point.x;
    
    if (point.y < y_min) close_y = y_min;
    else if (point.y > y_max) close_y = y_max;
    else close_y = point.y;
    
    return CGPointMake(close_x,close_y);
}

- (void)addArrow:(Arrow *)arrow{
    //NSLog(@"Arrow Head: %@",NSStringFromCGPoint(arrow.head));
    //NSLog(@"Arrow Tail: %@",NSStringFromCGPoint(arrow.tail));
    [self.arrows addObject:arrow];
    [self generatePath];
    [self setNeedsDisplay];
}

- (void)drawPath{
    if (self.arrows.count < 1){
        NSLog(@"TutorialView No Arrows to Draw!");
        return;
    };
    
    //Remove old layers
    for(CALayer *layer in self.layer.sublayers)
        if([layer isMemberOfClass:[CAShapeLayer class]])
            [layer removeFromSuperlayer];
    
    bool drawAnimatedPath = true;
    bool drawNonAnimatedPath = true;
    
    if(!CGPathIsEmpty(self.pathAnimated)){
        if([self.delegate respondsToSelector:@selector(tutorialView:shouldDrawPath:animated:)])
            drawAnimatedPath = [self.delegate tutorialView:self shouldDrawPath:(CGPathRef)self.pathAnimated animated:true];
    }
    else drawAnimatedPath = false;
            
    if(!CGPathIsEmpty(self.pathNoAnimation)){
        if([self.delegate respondsToSelector:@selector(tutorialView:shouldDrawPath:animated:)])
            drawNonAnimatedPath = [self.delegate tutorialView:self shouldDrawPath:(CGPathRef)self.pathNoAnimation animated:false];
    }
    else drawNonAnimatedPath = false;
    
    if (drawAnimatedPath) {
        
        /*
         * Animated Arrows
         */
        
        CAShapeLayer *pathLayer = [CAShapeLayer layer];
        pathLayer.frame = self.bounds;
        pathLayer.path = self.pathAnimated;
        pathLayer.strokeColor = ARROW_COLOR;
        pathLayer.fillColor = nil;
        if (IOS_VERSION >= 6.0f) pathLayer.drawsAsynchronously = DRAWS_ASYNC;
        pathLayer.lineWidth = LINE_WIDTH;
        pathLayer.lineJoin = kCALineJoinBevel;
        [self.layer addSublayer:pathLayer];
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = DRAW_ANIMATION_SPEED;
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        [pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
        
        if([self.delegate respondsToSelector:@selector(tutorialView:didDrawPath:)])
            [self.delegate tutorialView:self didDrawPath:(CGPathRef)self.pathAnimated];
    }
    
    if(drawNonAnimatedPath){
        /*
         * Non-Animated Arrows
         */
        
        CAShapeLayer *pathLayer = [CAShapeLayer layer];
        pathLayer.frame = self.bounds;
        pathLayer.path = self.pathNoAnimation;
        pathLayer.strokeColor = ARROW_COLOR;
        if (IOS_VERSION >= 6.0f) pathLayer.drawsAsynchronously = DRAWS_ASYNC;
        pathLayer.fillColor = nil;
        pathLayer.lineWidth = LINE_WIDTH;
        pathLayer.lineJoin = kCALineJoinBevel;
        [self.layer addSublayer:pathLayer];
        
        if([self.delegate respondsToSelector:@selector(tutorialView:didDrawPath:)])
            [self.delegate tutorialView:self didDrawPath:(CGPathRef)self.pathNoAnimation];
    }
    
}

- (void)generatePath{
    CGMutablePathRef pAnimated = CGPathCreateMutable();
    CGMutablePathRef pNoAnimated = CGPathCreateMutable();
    for(Arrow *a in self.arrows)
        CGPathAddPath(a.animated ? pAnimated : pNoAnimated, nil, a.path);
    CGPathRelease(self.pathAnimated);
    CGPathRelease(self.pathNoAnimation);
    self.pathAnimated = pAnimated;
    self.pathNoAnimation = pNoAnimated;
}

- (void)dismissView{
    [self dismissViewAnimated:YES completion:nil];
}

- (void)dismissViewAnimated:(BOOL)animated completion:(void(^)(void))callback{
    bool shouldAnimate = animated;
    bool shouldDismiss = true;
    if ([self.delegate respondsToSelector:@selector(tutorialView:shouldDismissAnimated:)])
        shouldDismiss = [self.delegate tutorialView:self shouldDismissAnimated:&shouldAnimate];
    if (!shouldDismiss) return;
    
    if(shouldAnimate){
        [UIView animateWithDuration:DISMISS_ANIMATION_SPEED
                              delay:0
                            options:UIViewAnimationOptionLayoutSubviews
                         animations:^{
                            self.alpha = 0.0f;
                         }
                         completion:^(BOOL success){
                            [self removeFromSuperview];
                            if(callback) callback();
                            if([self.delegate respondsToSelector:@selector(tutorialView:didDismissAnimated:)])
                                [self.delegate tutorialView:self didDismissAnimated:animated];
                         }
         ];
    }
    else{
        [self removeFromSuperview];
        if(callback) callback();
        if([self.delegate respondsToSelector:@selector(tutorialView:didDismissAnimated:)])
            [self.delegate tutorialView:self didDismissAnimated:animated];
    }
}

#pragma mark - Dealloc

-(void)dealloc {
    CGPathRelease(self.pathAnimated);
    CGPathRelease(self.pathNoAnimation);
}

@end
