#import <RCTAppDelegate.h>
#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property(nonatomic, strong) UIWindow *window;
@property(nonatomic, readonly) RCTBridge *bridge;

@end
