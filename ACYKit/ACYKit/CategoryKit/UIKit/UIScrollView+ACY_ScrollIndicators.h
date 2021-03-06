//
//  UIScrollView+ACY_ScrollIndicators.h
//  Pods
//
//  Created by Arthur Liu on 18/04/2017.
//
//

#import <UIKit/UIKit.h>

@interface UIScrollView (ACY_ScrollIndicators)


/**
 Make the horizontal scroll indicator always show. Must invoke this after finishing setting the content size.

 @param always always YES, means always show, NO, otherwise.
 */
- (void)acy_alwaysShowHorizontalScrollIndicator:(BOOL)always;


/**
 Make the vertical scroll indicator always show. Must invoke this after finishing setting the content size.

 @param always YES, means always show, NO, otherwise.
 */
- (void)acy_alwaysShowVerticalScrollIndicator:(BOOL)always;


@end
