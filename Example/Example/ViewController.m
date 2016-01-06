//
//  ViewController.m
//  Example
//
//  Created by Evgeniy Yurtaev on 02/01/16.
//  Copyright © 2016 Evgeniy Yurtaev. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "ViewController.h"
#import "EYNavigationController.h"
#import "SecondViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *pushButton;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    __weak typeof(self) weakSelf = self;
    self.pushButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        EYNavigationController *navigationController = (EYNavigationController *)weakSelf.navigationController;
        UIViewController *viewController = [SecondViewController new];
        
        return [[[navigationController signalForPushViewController:viewController animated:YES]
            then:^RACSignal *{
                UIViewController *viewController = [SecondViewController new];
                return [navigationController signalForPushViewController:viewController animated:YES];
            }]
            then:^RACSignal *{
                return [navigationController signalForPopToRootViewControllerAnimated:YES];
            }];
    }];
}

@end
