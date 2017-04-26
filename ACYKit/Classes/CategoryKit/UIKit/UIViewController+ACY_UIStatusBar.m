//
//  UIViewController+ACY_UIStatusBar.m
//  Pods
//
//  Created by Arthur Liu on 26/04/2017.
//
//

#import "UIViewController+ACY_UIStatusBar.h"
#import <Aspects/Aspects.h>
#import <objc/runtime.h>

@implementation UIViewController (ACY_UIStatusBar)

#pragma mark - Public Interface

- (void)acy_setPrefersStatusBarHidden:(BOOL)hidden {
    
    UIApplication *app = [UIApplication sharedApplication];
    
    [self acy_setPrefersStatusBarHidden:hidden
                                  style:app.statusBarStyle
                              animation:UIStatusBarAnimationFade];

    
    
}


- (void)acy_setPreferredStatusBarStyle:(UIStatusBarStyle)style {
    
    UIApplication *app = [UIApplication sharedApplication];
    
    [self acy_setPrefersStatusBarHidden:app.isStatusBarHidden
                                  style:style
                              animation:UIStatusBarAnimationFade];
    
}

- (void)acy_setPreferredStatusBarUpdateAnimation:(UIStatusBarAnimation)animation {
    
    UIApplication *app = [UIApplication sharedApplication];
    
    [self acy_setPrefersStatusBarHidden:app.statusBarHidden
                                  style:app.statusBarStyle
                              animation:animation];
    
}


#pragma mark - Private Interface

- (void)acy_setPrefersStatusBarHidden:(BOOL)hidden
                                style:(UIStatusBarStyle)style
                            animation:(UIStatusBarAnimation)animation {
    __kindof UIViewController * vc =
    [UIApplication sharedApplication].keyWindow.rootViewController;
    
    
    NSMutableArray<id<AspectToken>> *aspectList = [NSMutableArray array];
    
    NSArray<NSString *> *selectorNames =
    @[NSStringFromSelector(@selector(prefersStatusBarHidden)),
      NSStringFromSelector(@selector(preferredStatusBarStyle)),
      NSStringFromSelector(@selector(preferredStatusBarUpdateAnimation))];
    
    NSArray<NSNumber *> *params = @[@(hidden), @(style), @(animation)];
    
   
    [selectorNames enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        id<AspectToken> aspectObj =
        
        [vc aspect_hookSelector:NSSelectorFromString(obj)
                    withOptions:AspectPositionInstead
                     usingBlock:^(id<AspectInfo> info){
            
            
            NSInvocation *invocation = info.originalInvocation;
            
            [invocation invoke];
            
            NSInteger value = [params[idx] integerValue];
            
            [invocation setReturnValue:&value];
            
            
        }
                          error:nil];
        
        [aspectList addObject:aspectObj];
        
    }];
    
    
    
//    id<AspectToken> aspectHidden =
//    [vc aspect_hookSelector:@selector(prefersStatusBarHidden) withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> info){
//        
//        
//        BOOL prefersHidden = hidden;
//        
//        NSInvocation *invocation = info.originalInvocation;
//        
//        [invocation invoke];
//        [invocation setReturnValue:&prefersHidden];
//        
//        
//    } error:nil];
//    
//    
//    
//    
//    id<AspectToken> aspectStyle =
//    [vc aspect_hookSelector:@selector(preferredStatusBarStyle) withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> info){
//        
//        UIStatusBarStyle preferredStyle = style;
//        
//        NSInvocation *invocation = info.originalInvocation;
//        
//        [invocation invoke];
//        [invocation setReturnValue:&preferredStyle];
//        
//    } error:nil];
//    
//    
//    id<AspectToken> aspectAnimation =
//    [vc aspect_hookSelector:@selector(preferredStatusBarUpdateAnimation) withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> info){
//        
//        UIStatusBarAnimation preferredAnimation = animation;
//        
//        NSInvocation *invocation = info.originalInvocation;
//        
//        [invocation invoke];
//        
//        [invocation setReturnValue:&preferredAnimation];
//        
//    } error:nil];
    
    
    
    
    [vc setNeedsStatusBarAppearanceUpdate];
    
    
    [aspectList enumerateObjectsUsingBlock:^(id<AspectToken>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj remove];
    }];
    
//    [aspectHidden remove];
//    [aspectStyle remove];
//    [aspectAnimation remove];
    
}





@end
