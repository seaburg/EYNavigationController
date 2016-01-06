//
//  EYNavigationController.m
// 
//
//  Created by Evgeniy Yurtaev on 02/01/16.
//  Copyright © 2016 Evgeniy Yurtaev. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "EYNavigationController.h"

@interface EYNavigationController () <UINavigationControllerDelegate>

@property (weak, nonatomic) id<UINavigationControllerDelegate> originDelegate;

@end

@implementation EYNavigationController

- (void)commonInit
{
    if ([super delegate] != self) {
        self.originDelegate = [super delegate];
        [super setDelegate:self];
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (RACSignal *)signalForSetViewControllers:(NSArray *)viewControllers animated:(BOOL)animated
{
    return [RACSignal defer:^RACSignal *{
        RACSignal *completeSignal = [[self completeTransitionSignal] replayLast];
        [self setViewControllers:viewControllers animated:animated];

        return completeSignal;
    }];
}

- (RACSignal *)signalForPushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    return [RACSignal defer:^RACSignal *{
        RACSignal *completeSignal = [[self completeTransitionSignal] replayLast];
        [self pushViewController:viewController animated:animated];

        return completeSignal;
    }];
}

- (RACSignal *)signalForPopViewControllerAnimated:(BOOL)animated
{
    return [RACSignal defer:^RACSignal *{
        RACSignal *completeSignal = [[self completeTransitionSignal] replayLast];
        UIViewController *viewController = [self popViewControllerAnimated:animated];

        return [completeSignal then:^RACSignal *{
            return [RACSignal return:viewController];
        }];
    }];
}

- (RACSignal *)signalForPopToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    return [RACSignal defer:^RACSignal *{
        RACSignal *completeSignal = [[self completeTransitionSignal] replayLast];
        NSArray *viewControllers = [self popToViewController:viewController animated:animated];

        return [completeSignal then:^RACSignal *{
            return [RACSignal return:viewControllers];
        }];
    }];
}

- (RACSignal *)signalForPopToRootViewControllerAnimated:(BOOL)animated
{
    return [RACSignal defer:^RACSignal *{
        RACSignal *completeSignal = [[self completeTransitionSignal] replayLast];
        NSArray *viewControllers = [self popToRootViewControllerAnimated:animated];

        return [completeSignal then:^RACSignal *{
            return [RACSignal return:viewControllers];
        }];
    }];
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    BOOL respondsToSelector = [super respondsToSelector:aSelector];
    if (!respondsToSelector) {
        __autoreleasing id delegate = self.originDelegate;
        respondsToSelector = [delegate respondsToSelector:aSelector];
    }
    return respondsToSelector;
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    if ([self.originDelegate respondsToSelector:aSelector]) {
        return self.originDelegate;
    } else {
        return [super forwardingTargetForSelector:aSelector];
    }
}

#pragma mark - Properties

- (void)setDelegate:(id<UINavigationControllerDelegate>)delegate
{
    self.originDelegate = delegate;
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.originDelegate != self && [self.originDelegate respondsToSelector:@selector(navigationController:didShowViewController:animated:)]) {
        [self.originDelegate navigationController:navigationController didShowViewController:viewController animated:animated];
    }
}

#pragma mark - Private methods

- (RACSignal *)completeTransitionSignal
{
    return [[[self rac_signalForSelector:@selector(navigationController:didShowViewController:animated:) fromProtocol:@protocol(UINavigationControllerDelegate)]
        take:1]
        ignoreValues];
}

@end
