//
//  ViewController.m
//  NetworkNotification
//
//  Created by qun on 2021/6/30.
//

#import "ViewController.h"
#import "NetworkNotificationCenter.h"
#import "MBProgressHUD+NJ.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [NetworkNotificationCenter.shareManager start];
    [self addListen];
}

- (void)dealloc
{
    [self removeListen];
}

- (void)addListen
{
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(networkChangedConnected:)
                                               name:NetworkConnectedNotification
                                             object:nil];

    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(networkChangedDisconnected:) name:NetworkDisconnectedNotification object:nil];
}
- (void)removeListen
{
    [NSNotificationCenter.defaultCenter removeObserver:self name:NetworkConnectedNotification object:nil];
    [NSNotificationCenter.defaultCenter removeObserver:self name:NetworkDisconnectedNotification object:nil];
}

- (void)networkChangedConnected:(NSNotification *)notification
{
    [MBProgressHUD showInfo:@"网络已连接" toView:self.view];

}

- (void)networkChangedDisconnected:(NSNotification *)notification
{
    [MBProgressHUD showInfo:@"当前无网络" toView:self.view];
}

@end
