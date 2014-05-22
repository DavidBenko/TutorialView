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

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreText/CoreText.h>

#define ARROW_HEAD_LENGTH(arrowLen) arrowLen / 8.5f

enum ArrowDirection {
    ArrowDirectionHT,   // Draw arrow head to tail (default)
    ArrowDirectionTH    // Draw arrow tail to head
};
typedef enum ArrowDirection ArrowDirection;

@interface Arrow : NSObject

@property (nonatomic, assign) CGPoint head;
@property (nonatomic, assign) CGPoint tail;
@property (nonatomic, assign) BOOL curved;
@property (nonatomic, assign) BOOL animated;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, assign) CGMutablePathRef path;
@property (nonatomic, assign) ArrowDirection direction;

@end
