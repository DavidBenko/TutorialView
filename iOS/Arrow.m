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

#import "Arrow.h"

@implementation Arrow

@synthesize head,tail;
@synthesize curved,animated;
@synthesize description;
@synthesize path;


- (id) init
{
    self = [super init];
    if (self)
    {
        self.head = CGPointZero;
        self.tail = CGPointZero;
        self.curved = true;
        self.animated = true;
        self.description = @"";
        self.path = CGPathCreateMutable();
    }
    return self;
}
- (void)setHead:(CGPoint)point{
    head = point;
    [self generatePath];
}
- (void)setHeadWithX:(CGFloat)x andY:(CGFloat)y {
    self.head = CGPointMake(x, y);
}
- (void)setTail:(CGPoint)point{
    tail = point;
    [self generatePath];
}
- (void)setTailWithX:(CGFloat)x andY:(CGFloat)y {
    self.tail = CGPointMake(x, y);
}
- (void)setCurved:(BOOL)shouldCurve {
    curved = shouldCurve;
    [self generatePath];
}
- (void)generatePath {
    
    //Early out if invalid path
    if(CGPointEqualToPoint(head,tail))return;
    
    CGMutablePathRef arrowPath = CGPathCreateMutable();

    BOOL shouldCurve = (self.head.x == self.tail.x || self.head.y == self.tail.y) ? NO : self.curved;
    
    CGPathMoveToPoint(arrowPath, nil, self.head.x, self.head.y);
    if(shouldCurve)CGPathAddQuadCurveToPoint(arrowPath, nil, self.head.x, self.tail.y, self.tail.x, self.tail.y);
    else CGPathAddLineToPoint(arrowPath, nil, self.tail.x, self.tail.y);
    
    //Calculate Arrow Head
    CGPoint A = shouldCurve ? CGPointMake(self.head.x, self.tail.y) : self.tail;
    CGPoint B = self.head;
    
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

    CGPathMoveToPoint(arrowPath, nil, self.head.x, self.head.y);
    CGPathAddLineToPoint(arrowPath, nil, P.x, P.y);
    
    CGPathMoveToPoint(arrowPath, nil, self.head.x, self.head.y);
    CGPathAddLineToPoint(arrowPath, nil, Q.x, Q.y);
    
    CGPathRelease(self.path);
    self.path = arrowPath;
}

#pragma mark - Dealloc
-(void)dealloc {
    CGPathRelease(self.path);
}
@end
