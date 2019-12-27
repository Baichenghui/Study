 
#import <Foundation/Foundation.h>

@interface HHTimer : NSObject

+ (instancetype)timerWithInterval:(NSTimeInterval)seconds handler:(dispatch_block_t)handler;
+ (instancetype)timerWithInterval:(NSTimeInterval)seconds queue:(dispatch_queue_t)queue handler:(dispatch_block_t)handler;

- (void)start;
- (void)startImediately;
- (void)stop;

@property (nonatomic, readonly) BOOL started;

@end
