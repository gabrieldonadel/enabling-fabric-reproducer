#import "EXDevLauncherBridgeDelegate.h" 

#import <React/RCTBundleURLProvider.h>
#import "React/RCTAppSetupUtils.h"

#if RCT_NEW_ARCH_ENABLED
#import <memory>

#import <React/CoreModulesPlugins.h>
#import <React/RCTFabricSurfaceHostingProxyRootView.h>
#import <React/RCTSurfacePresenter.h>
#import <React/RCTSurfacePresenterBridgeAdapter.h>
#import <ReactCommon/RCTTurboModuleManager.h>
#import <react/config/ReactNativeConfig.h>
#import <React/RCTCxxBridgeDelegate.h>

#import <react/renderer/runtimescheduler/RuntimeScheduler.h>
#import <react/renderer/runtimescheduler/RuntimeSchedulerCallInvoker.h>
#import <React-RCTAppDelegate/RCTAppDelegate.h>

static NSString *const kRNConcurrentRoot = @"concurrentRoot";

#endif

@interface EXDevLauncherBridgeDelegate () <RCTTurboModuleManagerDelegate, RCTCxxBridgeDelegate>
{
  std::shared_ptr<const facebook::react::ReactNativeConfig> _reactNativeConfig;
  facebook::react::ContextContainer::Shared _contextContainer;
}
@end

@implementation EXDevLauncherBridgeDelegate

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index"];
#else
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}

- (RCTRootView *)createRootViewWithModuleName:(NSString *)moduleName launchOptions:(NSDictionary *_Nullable)launchOptions application:(UIApplication *)application
{
  BOOL enableTM = NO;
#if RCT_NEW_ARCH_ENABLED
  enableTM = YES;
#endif

  RCTAppSetupPrepareApp(application, enableTM);

  if (!self.bridge)
  {
    self.bridge = [self createBridgeWithDelegate:self launchOptions:launchOptions];
  }

#if RCT_NEW_ARCH_ENABLED
  _contextContainer = std::make_shared<facebook::react::ContextContainer const>();
  _reactNativeConfig = std::make_shared<facebook::react::EmptyReactNativeConfig const>();
  _contextContainer->insert("ReactNativeConfig", _reactNativeConfig);
  self.bridgeAdapter = [[RCTSurfacePresenterBridgeAdapter alloc] initWithBridge:self.bridge
                                                               contextContainer:_contextContainer];
  self.bridge.surfacePresenter = self.bridgeAdapter.surfacePresenter;
#endif

  NSMutableDictionary *initProps = [NSMutableDictionary new];
#ifdef RCT_NEW_ARCH_ENABLED
  initProps[kRNConcurrentRoot] = @YES;
#endif

  return [super createRootViewWithBridge:self.bridge moduleName:moduleName initProps:initProps];
}

- (BOOL)concurrentRootEnabled
{
  return true;
}

@end
