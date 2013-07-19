

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreText/CoreText.h>

#define ARROW_HEAD_LENGTH(arrowLen) arrowLen / 8.5f

@interface Arrow : NSObject

@property (nonatomic, assign) CGPoint head;
@property (nonatomic, assign) CGPoint tail;
@property (nonatomic, assign) BOOL curved;
@property (nonatomic, assign) BOOL animated;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, assign) CGMutablePathRef path;

@end
