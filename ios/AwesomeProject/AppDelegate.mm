#import "AppDelegate.h"
#import "EXDevLauncherBridgeDelegate.h"

#import <React/RCTBundleURLProvider.h>

@interface AppDelegate ()

@property (nonatomic, strong) EXDevLauncherBridgeDelegate *bridgeDelegate;

@end

@implementation AppDelegate

- (instancetype)init {
  if (self = [super init]) {
    self.bridgeDelegate = [EXDevLauncherBridgeDelegate new];
  }
  return self;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  UIView *rootView = [_bridgeDelegate createRootViewWithModuleName:@"AwesomeProject" launchOptions:launchOptions application:application];

  if (@available(iOS 13.0, *)) {
      rootView.backgroundColor = [UIColor systemBackgroundColor];
    } else {
      rootView.backgroundColor = [UIColor whiteColor];
    }

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    UIViewController *rootViewController = [UIViewController new];
    rootViewController.view = rootView;
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];

  return YES;
}

@end
