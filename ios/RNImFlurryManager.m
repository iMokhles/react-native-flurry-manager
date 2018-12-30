
#import "RNImFlurryManager.h"
#import <React/RCTViewManager.h>
#import <React/RCTBridge.h>
#import <React/RCTUIManager.h>
#import <Flurry.h>
#import "RNImFlurryManagerNativeAdView.h"

static NSString * const originName = @"react-native-im-flurry-manager";
static NSString * const originVersion = @"1.0.0";


@implementation RNImFlurryManager {
                                      RNImFlurryManagerNativeAdView* _RNImFlurryManagerNativeAdView;
                                  }

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();

- (UIView *)view
{
    _RNImFlurryManagerNativeAdView = [[RNImFlurryManagerNativeAdView alloc] initWithEventDispatcher:self.bridge.eventDispatcher];
    return _RNImFlurryManagerNativeAdView;
}

RCT_EXPORT_VIEW_PROPERTY(onFetchSuccess, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onReceivedClick, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onFetchError, RCTBubblingEventBlock)
RCT_EXPORT_METHOD(refresh:(nonnull NSNumber *)reactTag) {
    [self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *,UIView *> *viewRegistry) {
        RNImFlurryManagerNativeAdView *view = viewRegistry[reactTag];
        if (![view isKindOfClass:[RNImFlurryManagerNativeAdView class]]) {
            RCTLogError(@"Invalid view returned from registry, expecting RNImFlurryManagerNativeAdView, got: %@", view);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [view refresh];
        });
    }];
}

RCT_CUSTOM_VIEW_PROPERTY(adSpaceName, NSString*, RNImFlurryManagerNativeAdView)
{
    [view setAdSpaceName:json];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.sessionBuilder = [FlurrySessionBuilder new];
        self.logLevel = FlurryLogLevelCriticalOnly; // default log level
        [Flurry addOrigin:originName withVersion:originVersion];
    }
    return self;
}

+ (BOOL)requiresMainQueueSetup {
    return YES;
}

- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}

RCT_EXPORT_METHOD(init:(nonnull NSString *)apiKey) {
    [Flurry startSession:apiKey withSessionBuilder:self.sessionBuilder];
}

RCT_EXPORT_METHOD(withCrashReporting:(BOOL)crashReporting) {
    [self.sessionBuilder withCrashReporting:crashReporting];
}

RCT_EXPORT_METHOD(withContinueSessionMillis:(NSInteger)value) {
    double seconds = (double) value / 1000.0;
    [self.sessionBuilder withSessionContinueSeconds:(NSInteger)(round(seconds))];
}

RCT_EXPORT_METHOD(withIncludeBackgroundSessionsInMetrics:(BOOL)value) {
    [self.sessionBuilder withIncludeBackgroundSessionsInMetrics:value];
}

RCT_EXPORT_METHOD(withLogEnabled:(BOOL)enabled) {
    if (enabled) {
        [self.sessionBuilder withLogLevel:self.logLevel];
    } else {
        [self.sessionBuilder withLogLevel:FlurryLogLevelNone];
    }
}

RCT_EXPORT_METHOD(withLogLevel:(NSInteger)value) {
    if (value >= 4) {
        NSLog(@"Flurry: Invalid log level %ld.", (long)value);
        return;
    }
    self.logLevel = (FlurryLogLevel)value;
    [self.sessionBuilder withLogLevel:self.logLevel];
}

RCT_EXPORT_METHOD(setAge:(int)age) {
    [Flurry setAge:age];
}

RCT_EXPORT_METHOD(setGender:(nonnull NSString *)gender) {
    [Flurry setGender:[gender lowercaseString]];
}

RCT_EXPORT_METHOD(setReportLocation:(BOOL)location) {
    [Flurry trackPreciseLocation:location];
}

RCT_EXPORT_METHOD(setSessionOrigin:(nonnull NSString *)sessionOrigin deepLink:(nonnull NSString *)deepLink) {
    [Flurry addSessionOrigin:sessionOrigin withDeepLink:deepLink];
}

RCT_EXPORT_METHOD(setUserId:(nullable NSString *)userId) {
    [Flurry setUserID:userId];
}

RCT_EXPORT_METHOD(setVersionName:(nonnull NSString *)version) {
    [Flurry setAppVersion:version];
}

RCT_EXPORT_METHOD(setIAPReportingEnabled:(BOOL)enableIAP) {
    [Flurry setIAPReportingEnabled:enableIAP];
}

RCT_EXPORT_METHOD(addOrigin:(nonnull NSString *)originName originVersion:(nonnull NSString *)originVersion) {
    [Flurry addOrigin:originName withVersion:originVersion];
}

RCT_EXPORT_METHOD(addOriginParams:(nonnull NSString *)originName originVersion:(nonnull NSString *)originVersion originParameters:(nullable NSDictionary *)originParameters) {
    [Flurry addOrigin:originName withVersion:originVersion withParameters:originParameters];
}

RCT_EXPORT_METHOD(addSessionProperty:(nonnull NSString *)name value:(nonnull NSString *)value) {
    NSDictionary *sessionProperties = @{name: value};
    [Flurry sessionProperties:sessionProperties];
}

RCT_EXPORT_METHOD(getVersions:(RCTResponseSenderBlock)errorCallback successCallback:(RCTResponseSenderBlock)successCallback) {
    NSString *agentVersion = [Flurry getFlurryAgentVersion];
    NSString *sessionId = [Flurry getSessionID];
    successCallback(@[agentVersion, [NSNull null], sessionId]);
}

RCT_EXPORT_METHOD(logEvent:(nonnull NSString *)eventId) {
    [Flurry logEvent:eventId];
}

RCT_EXPORT_METHOD(logEventTimed:(nonnull NSString *)eventId timed:(BOOL)timed) {
    [Flurry logEvent:eventId timed:timed];
}

RCT_EXPORT_METHOD(logEventParams:(nonnull NSString *)eventId parameters:(nullable NSDictionary *)params) {
    [Flurry logEvent:eventId withParameters:params];
}

RCT_EXPORT_METHOD(logEventParamsTimed:(nonnull NSString *)eventId parameters:(nullable NSDictionary *)params timed:(BOOL)timed) {
    [Flurry logEvent:eventId withParameters:params timed:timed];
}

RCT_EXPORT_METHOD(endTimedEvent:(nonnull NSString *)eventId) {
    [Flurry endTimedEvent:eventId withParameters:nil];
}

RCT_EXPORT_METHOD(endTimedEventParams:(nonnull NSString *)eventId params:(nullable NSDictionary *)params) {
    [Flurry endTimedEvent:eventId withParameters:params];
}

RCT_EXPORT_METHOD(logBreadcrumb:(nonnull NSString *)breadcrumb) {
    [Flurry leaveBreadcrumb:breadcrumb];
}

RCT_EXPORT_METHOD(logPayment:(NSString *)productName productId:(NSString *)productId quantity:(NSInteger)quantity price:(double)price currency:(NSString *)currency transactionId:(NSString *)transactionId parameters:(NSDictionary *)parameters) {
    NSLog(@"Flurry.logPayment is not supported on iOS. Please use Flurry.setIAPReportingEnabled instead.");
}

RCT_EXPORT_METHOD(onPageView) {
    [Flurry logPageView];
}

RCT_EXPORT_METHOD(onError:(nonnull NSString *)errorId message:(nullable NSString *)message errorClass:(nullable NSString *)errorClass) {
    NSError *error = nil;
    if (errorClass != nil) {
        error = [NSError errorWithDomain:errorClass code:0 userInfo:nil];
    }
    [Flurry logError:errorId message:message error:error];
}

RCT_EXPORT_METHOD(onErrorParams:(nonnull NSString *)errorId message:(nullable NSString *)message errorClass:(nullable NSString *)errorClass parameters:(nullable NSDictionary *)parameters) {
    NSError *error = nil;
    if (errorClass != nil) {
        error = [NSError errorWithDomain:errorClass code:0 userInfo:nil];
    }
    [Flurry logError:errorId message:message error:error withParameters:parameters];
}

@end
  