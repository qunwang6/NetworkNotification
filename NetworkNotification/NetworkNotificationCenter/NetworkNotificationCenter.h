//
//  NetworkNotificationCenter.h
//  NetworkNotification
//
//  Created by qun on 2021/6/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkNotificationCenter : NSObject

+ (instancetype)shareManager;
@property (assign, nonatomic) BOOL isConnected;

- (void)start;
- (void)stop;

FOUNDATION_EXPORT NSNotificationName const NetworkConnectedNotification;
FOUNDATION_EXPORT NSNotificationName const NetworkDisconnectedNotification;

@end

NS_ASSUME_NONNULL_END
