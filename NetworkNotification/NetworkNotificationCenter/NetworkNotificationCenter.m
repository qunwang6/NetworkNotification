//
//  NetworkNotificationCenter.m
//  NetworkNotification
//
//  Created by qun on 2021/6/30.
//

#import "NetworkNotificationCenter.h"

#if __has_include(<AFNetworking/AFNetworkReachabilityManager.h>)
#import <AFNetworking/AFNetworkReachabilityManager.h>
#else
#import "AFNetworkReachabilityManager.h"
#endif


NSNotificationName const NetworkConnectedNotification     = @"TIONetworkConnectedNotification";
NSNotificationName const NetworkDisconnectedNotification  = @"TIONetworkDisconnectedNotification";

@interface NetworkNotificationCenter ()
@property (strong, nonatomic) AFNetworkReachabilityManager *reachabilityManager;
@end

@implementation NetworkNotificationCenter

+ (instancetype)shareManager
{
    static NetworkNotificationCenter *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });

    return _sharedManager;
}

- (void)start
{
    [self.reachabilityManager startMonitoring];
}

- (void)stop
{
    [self.reachabilityManager stopMonitoring];
    self.reachabilityManager = nil;
}

- (AFNetworkReachabilityManager *)reachabilityManager
{
    if (!_reachabilityManager) {
        _reachabilityManager = [AFNetworkReachabilityManager sharedManager];
        [_reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            if (status == AFNetworkReachabilityStatusNotReachable) {
                // 断网
                self->_isConnected = NO;
                [NSNotificationCenter.defaultCenter postNotificationName:NetworkDisconnectedNotification object:nil];
            } else if (status == AFNetworkReachabilityStatusReachableViaWiFi || status == AFNetworkReachabilityStatusReachableViaWWAN) {
                // 联网
                self->_isConnected = YES;
                [NSNotificationCenter.defaultCenter postNotificationName:NetworkConnectedNotification object:nil];
            } else {
                // 未知状态 暂不处理
            }
        }];
    }
    return _reachabilityManager;
}

@end
