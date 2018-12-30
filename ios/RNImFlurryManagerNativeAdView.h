
#import <React/RCTComponent.h>
#import <UIKit/UIKit.h>
#import <Flurry.h>

@class RCTEventDispatcher;

@interface RNImFlurryManagerNativeAdView: UIView <FlurryAdNativeDelegate>
{
    NSString* adSpaceName;
}

@property (nonatomic, copy) RCTBubblingEventBlock onFetchSuccess;
@property (nonatomic, copy) RCTBubblingEventBlock onReceivedClick;
@property (nonatomic, copy) RCTBubblingEventBlock onFetchError;
@property (nonatomic, copy) NSString* adSpaceName;
@property (nonatomic, retain) FlurryAdNative* nativeAd;

- (instancetype)initWithEventDispatcher:(RCTEventDispatcher *)eventDispatcher NS_DESIGNATED_INITIALIZER;
+ (UIViewController *) currentViewController;
- (void) refresh;
@end