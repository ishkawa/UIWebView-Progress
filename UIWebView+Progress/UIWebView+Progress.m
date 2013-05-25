#import "UIWebView+Progress.h"
#import <ISMethodSwizzling/ISMethodSwizzling.h>
#import <objc/runtime.h>

static const char NJKProgressProxyKey;
static const char NJKWebViewProxyDelegateKey;

@interface UIWebView () <UIWebViewDelegate>

@property (nonatomic, strong) NJKWebViewProgress *progressProxy;
@property (nonatomic, njk_weak) id <UIWebViewDelegate> webViewProxyDelegate;

@end

@implementation UIWebView (Progress)

+ (void)load
{
    @autoreleasepool {
        ISSwizzleInstanceMethod([self class], @selector(initWithFrame:), @selector(_initWithFrame:));
        ISSwizzleInstanceMethod([self class], @selector(initWithCoder:), @selector(_initWithCoder:));
        ISSwizzleInstanceMethod([self class], @selector(delegate),       @selector(_delegate));
        ISSwizzleInstanceMethod([self class], @selector(setDelegate:),   @selector(_setDelegate:));
    }
}

- (id)_initWithFrame:(CGRect)frame
{
    self = [self _initWithFrame:frame];
    if (self) {
        self.progressProxy = [[NJKWebViewProgress alloc] init];
        self.delegate = self.progressProxy;
    }
    return self;
}

- (id)_initWithCoder:(NSCoder *)coder
{
    self = [self _initWithCoder:coder];
    if (self) {
        self.progressProxy = [[NJKWebViewProgress alloc] init];
        self.delegate = self.progressProxy;
    }
    return self;
}

#pragma mark - accessors

- (NJKWebViewProgress *)progressProxy
{
    return objc_getAssociatedObject(self, &NJKProgressProxyKey);
}

- (void)setProgressProxy:(NJKWebViewProgress *)progressProxy
{
    objc_setAssociatedObject(self, &NJKProgressProxyKey, progressProxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id <NJKWebViewProgressDelegate>)progressDelegate
{
    return self.progressProxy.progressDelegate;
}

- (void)setProgressDelegate:(id<NJKWebViewProgressDelegate>)progressDelegate
{
    self.progressProxy.progressDelegate = progressDelegate;
}

- (id <UIWebViewDelegate>)webViewProxyDelegate
{
    return objc_getAssociatedObject(self, &NJKWebViewProxyDelegateKey);
}

- (void)setWebViewProxyDelegate:(id<UIWebViewDelegate>)webViewProxyDelegate
{
    objc_setAssociatedObject(self, &NJKWebViewProxyDelegateKey, webViewProxyDelegate, OBJC_ASSOCIATION_ASSIGN);
}

- (float)progress
{
    return self.progressProxy.progress;
}

- (id <UIWebViewDelegate>)_delegate
{
    return self.webViewProxyDelegate;
}

- (void)_setDelegate:(id<UIWebViewDelegate>)delegate
{
    if ([self _delegate] && delegate != self.progressProxy) {
        self.webViewProxyDelegate = delegate;
        return;
    }
    [self _setDelegate:delegate];
}

@end
