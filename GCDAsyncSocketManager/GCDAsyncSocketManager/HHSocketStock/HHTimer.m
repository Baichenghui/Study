 
#import "HHTimer.h"

@interface HHTimer ()
@property (nonatomic) dispatch_source_t source;
@property (nonatomic, copy) dispatch_block_t handler;
@property (nonatomic) dispatch_queue_t queue;
@property (nonatomic) NSTimeInterval interval;
@property (nonatomic, readonly) void *keyContext;
@end

@implementation HHTimer

+ (instancetype)timerWithInterval:(NSTimeInterval)seconds handler:(dispatch_block_t)handler
{
    return [self timerWithInterval:seconds queue:nil handler:handler];
}

+ (instancetype)timerWithInterval:(NSTimeInterval)seconds queue:(dispatch_queue_t)queue handler:(dispatch_block_t)handler
{
    return [[HHTimer alloc] initWithInterval:seconds queue:queue handler:handler];
}

- (instancetype)initWithInterval:(NSTimeInterval)seconds queue:(dispatch_queue_t)queue handler:(dispatch_block_t)handler
{
    self = [super init];
    if (self) {
        _interval = seconds;
        _handler = [handler copy];
        _keyContext = &_keyContext;
        _queue = queue;
        if (!_queue) {
            _queue = dispatch_queue_create(NSStringFromClass([self class]).UTF8String, DISPATCH_QUEUE_SERIAL);
        }
        dispatch_queue_set_specific(_queue, _keyContext, _keyContext, NULL);
    }
    return self;
}

- (void)dealloc
{
    if (dispatch_get_specific(self.keyContext)) {
        [self doStop];
    } else {
        dispatch_sync(self.queue, ^{
            [self doStop];
        });
    }
    self.handler = nil;
    self.queue = nil;
}

- (void)start
{
    [self startImediately:NO];
}

- (void)startImediately
{
    [self startImediately:YES];
}

- (void)startImediately:(BOOL)imediately
{
    if (dispatch_get_specific(self.keyContext)) {
        [self doStartImediately:imediately];
    } else {
        __weak __typeof(self) weakSelf = self;
        dispatch_async(self.queue, ^{
            __typeof(weakSelf) strongSelf = weakSelf;
            if (strongSelf) {
                [strongSelf doStartImediately:imediately];
            }
        });
    }
}

- (void)doStartImediately:(BOOL)imediately
{
    if (!self.source) {
        self.source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, self.queue);
        const uint64_t nsec = self.interval * NSEC_PER_SEC;
        dispatch_source_set_event_handler(self.source, self.handler);
        dispatch_time_t startTime = imediately ? DISPATCH_TIME_NOW : dispatch_time(DISPATCH_TIME_NOW, nsec);
        dispatch_source_set_timer(self.source, startTime, nsec, 0);
        dispatch_resume(self.source);
    }
}

- (void)stop
{
    __weak __typeof(self) weakSelf = self;
    dispatch_block_t blk = ^{
        __typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf doStop];
        }
    };
    
    if (dispatch_get_specific(self.keyContext)) {
        blk();
    } else {
        dispatch_async(self.queue, blk);
    }
}

- (void)doStop
{
    if (self.source) {
        dispatch_source_cancel(self.source);
        self.source = nil;
    }
}

#pragma mark - property

- (BOOL)started
{
    if (dispatch_get_specific(self.keyContext)) {
        return self.source != nil;
    } else {
        __block BOOL ret;
        dispatch_sync(self.queue, ^{
            ret = self.source != nil;
        });
        return ret;
    }
}

@end
