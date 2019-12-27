#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "YBTaskScheduler+Internal.h"
#import "YBTaskScheduler.h"
#import "YBTaskSchedulerStrategyProtocol.h"
#import "YBTaskSchedulerTypedef.h"
#import "YBTSPriorityQueue.h"
#import "YBTSQueue.h"
#import "YBTSStack.h"

FOUNDATION_EXPORT double YBTaskSchedulerVersionNumber;
FOUNDATION_EXPORT const unsigned char YBTaskSchedulerVersionString[];

