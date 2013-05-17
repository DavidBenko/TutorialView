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

#import "PRNDLTutorialView.h"

@implementation PRNDLTutorialView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:VIEW_COLOR];
        [self setAlpha:VIEW_ALPHA];
        
        UITapGestureRecognizer *singleFingerTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(dismissView)];
        [self addGestureRecognizer:singleFingerTap];
    }
    
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
/*- (void)drawRect:(CGRect)rect
{

}*/

-(void)layoutSubviews{
    [super layoutSubviews];
}

-(void)createTipForRect:(CGRect)rect withMessage:(NSString *)message atPoint:(CGPoint)center{
    [self drawText:message atPoint:center];
    //CGPoint tipCenter = CGPointMake(rect.origin.x + (rect.size.width / 2), rect.origin.y + (rect.size.height / 2))
    [self drawArrowWithHead:[self getClosestPointInRect:rect toPoint:center] andTail:center];
}

-(CGPoint)getClosestPointInRect:(CGRect)rect toPoint:(CGPoint)point {
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

-(void)drawText:(NSString *)text atPoint:(CGPoint)point{
    // Create path from text
    // See: http://www.codeproject.com/KB/iPhone/Glyph.aspx
    // License: The Code Project Open License (CPOL) 1.02 http://www.codeproject.com/info/cpol10.aspx
    CGMutablePathRef letters = CGPathCreateMutable();
    
    CTFontRef font = CTFontCreateWithName(CFSTR("MarkerFelt-Wide"), 14.0f, NULL);
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                           (__bridge id)font, kCTFontAttributeName,
                           nil];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:text
                                                                     attributes:attrs];
    CTLineRef line = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef)attrString);
	CFArrayRef runArray = CTLineGetGlyphRuns(line);
    
    // for each RUN
    for (CFIndex runIndex = 0; runIndex < CFArrayGetCount(runArray); runIndex++)
    {
        // Get FONT for this run
        CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);
        CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);
        
        // for each GLYPH in run
        for (CFIndex runGlyphIndex = 0; runGlyphIndex < CTRunGetGlyphCount(run); runGlyphIndex++)
        {
            // get Glyph & Glyph-data
            CFRange thisGlyphRange = CFRangeMake(runGlyphIndex, 1);
            CGGlyph glyph;
            CGPoint position;
            CTRunGetGlyphs(run, thisGlyphRange, &glyph);
            CTRunGetPositions(run, thisGlyphRange, &position);
            
            // Get PATH of outline
            {
                CGPathRef letter = CTFontCreatePathForGlyph(runFont, glyph, NULL);
                CGAffineTransform t = CGAffineTransformMakeTranslation(position.x, position.y);
                CGPathAddPath(letters, &t, letter);
                CGPathRelease(letter);
            }
        }
    }
    CFRelease(line);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    //[path moveToPoint:rect.origin];
    [path appendPath:[UIBezierPath bezierPathWithCGPath:letters]];
    
    CGPathRelease(letters);
    CFRelease(font);
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    CGRect frame = CGPathGetBoundingBox(path.CGPath);
    frame.size.width += TIP_FRAME_PADDING * 2;
    frame.size.height += TIP_FRAME_PADDING * 2;
    frame.origin.x = point.x - (frame.size.width / 2);
    frame.origin.y = point.y - (frame.size.height / 2);
    pathLayer.frame = frame;
    //pathLayer.bounds = CGPathGetBoundingBox(path.CGPath);
    pathLayer.geometryFlipped = YES;
    pathLayer.path = path.CGPath;
    pathLayer.strokeColor = nil;
    pathLayer.fillColor = ARROW_COLOR;
    pathLayer.shouldRasterize = YES;
    pathLayer.lineWidth = LINE_WIDTH;
    pathLayer.lineJoin = kCALineJoinBevel;
    pathLayer.drawsAsynchronously = YES;
    
    [self.layer addSublayer:pathLayer];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.duration = DRAW_ANIMATION_SPEED;
    pathAnimation.fromValue = @0.0f;
    pathAnimation.toValue = @1.0f;
    pathAnimation.fillMode = kCAFillModeForwards;
    [pathLayer addAnimation:pathAnimation forKey:@"fillColorAnimation"];
    
}

-(void)drawArrowWithHead:(CGPoint)head andTail:(CGPoint)tail animated:(BOOL)animated{
    [self drawArrowWithHead:head andTail:tail curved:YES animated:animated];
}
-(void)drawArrowWithHead:(CGPoint)head andTail:(CGPoint)tail curved:(BOOL)curve{
    [self drawArrowWithHead:head andTail:tail curved:curve animated:YES];
}
-(void)drawArrowWithHead:(CGPoint)head andTail:(CGPoint)tail{
    [self drawArrowWithHead:head andTail:tail curved:YES animated:YES];
}
-(void)drawArrowWithHead:(CGPoint)head andTail:(CGPoint)tail curved:(BOOL)curve animated:(BOOL)animated{
    
    //If the x or y coords are the same, it is not a curve
    BOOL shouldCurve = (head.x == tail.x || head.y == tail.y) ? NO : curve;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, head.x, head.y);
    if(shouldCurve)
        CGPathAddQuadCurveToPoint(path, nil, head.x, tail.y, tail.x, tail.y);
        //CGPathAddArcToPoint(path, nil, head.x, tail.y, tail.x, tail.y, CIRCLE_RADIUS);
    else CGPathAddLineToPoint(path, nil, tail.x, tail.y);
    //CGPathMoveToPoint(path, nil, tail.x, tail.y);
    //CGPathAddArcToPoint(path, nil, head.x, tail.y, head.x, head.y, CIRCLE_RADIUS);
    
    //Calculate Arrow Head
    CGPoint A = shouldCurve ? CGPointMake(head.x, tail.y) : tail;
    CGPoint B = head;
    
    // Vector from A to B:
    CGPoint AB = CGPointMake(B.x - A.x, B.y - A.y);
    
    // Length of AB == distance from A to B:
    CGFloat d = hypotf(AB.x, AB.y);
    
    // Arrow size == distance from C to B.
    CGFloat arrowSize = ARROW_HEAD_LENGTH(d);
    
    // Vector from C to B:
    CGPoint CB = CGPointMake(AB.x * arrowSize/d, AB.y * arrowSize/d);
    
    // Compute P and Q:
    CGPoint P = CGPointMake(B.x - CB.x - CB.y, B.y - CB.y + CB.x);
    CGPoint Q = CGPointMake(B.x - CB.x + CB.y, B.y - CB.y - CB.x);
    
    CGPathMoveToPoint(path, nil, head.x, head.y);
    CGPathAddLineToPoint(path, nil, P.x, P.y);
    
    CGPathMoveToPoint(path, nil, head.x, head.y);
    CGPathAddLineToPoint(path, nil, Q.x, Q.y);
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.frame = self.bounds;
    pathLayer.path = path;
    pathLayer.strokeColor = ARROW_COLOR;
    pathLayer.drawsAsynchronously = YES;
    pathLayer.fillColor = nil;
    pathLayer.lineWidth = LINE_WIDTH;
    pathLayer.lineJoin = kCALineJoinBevel;
    
    [self.layer addSublayer:pathLayer];
    
    if(animated){
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = DRAW_ANIMATION_SPEED;
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        [pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    }
    else {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextAddPath(context, path);
        CGContextStrokePath(context);
    }
}
-(void)dismissView{
    [self dismissViewAnimated:YES];
}
-(void)dismissViewAnimated:(BOOL)animated{
    if(animated){
        [UIView animateWithDuration:DISMISS_ANIMATION_SPEED
                              delay:0
                            options:UIViewAnimationOptionLayoutSubviews
                         animations:^{
                             self.alpha = 0.0f;
                         }
                         completion:^(BOOL success){
                             [self removeFromSuperview];
                         }
         ];
    }
    else{
        [self removeFromSuperview];
    }
}

@end
