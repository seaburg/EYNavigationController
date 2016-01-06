# EYNavigationController
UINavigationController with support signals.

Installation
------------
```
pod 'EYNavigationController', '~> 0.0.1'
```
Usage
-----
    #import <EYNavigationController/EYNavigationController.h>
    ...
    - (RACSignal *)showAnimalsOfUser:(User *)user
    {
        return [[self.dataProvider getAnimalsOfUser:user]
            flattenMap:^RACStream *(NSArray<Animal *> *animals) {
                AnimalsViewController *viewController = [[AnimalsViewController alloc] initWithAnimals:animals];
                EYNavigationController *navigationController = (EYNavigationController *)self.navigationController;

                return [navigationController signalForPushViewController:viewController animated:YES];
            }];
    }
    ...
