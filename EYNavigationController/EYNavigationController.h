//
//  EYNavigationController.h
//
//
//  Created by Evgeniy Yurtaev on 02/01/16.
//  Copyright © 2016 Evgeniy Yurtaev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RACSignal;

NS_ASSUME_NONNULL_BEGIN

@interface EYNavigationController : UINavigationController

// -> RACSignal ()
- (RACSignal *)signalForSetViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated;

// -> RACSignal ()
- (RACSignal *)signalForPushViewController:(UIViewController *)viewController animated:(BOOL)animated;

// -> RACSignal UIViewControllers
- (RACSignal *)signalForPopViewControllerAnimated:(BOOL)animated;

// -> RACSignal [UIViewControllers]
- (RACSignal *)signalForPopToViewController:(UIViewController *)viewController animated:(BOOL)animated;

// -> RACSignal [UIViewControllers]
- (RACSignal *)signalForPopToRootViewControllerAnimated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
