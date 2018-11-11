//
//  Gapple.m
//  Gapple
//
//  Created by Kirill Zakharenko on 11/11/2018.
//  Copyright © 2018 earwin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gapple-Swift.h"

@interface Gapple : NSObject
@end

@interface Gapple (GNoImplementation)
+ (void)registerBundle;
@end

@implementation Gapple

+ (void) initialize {
    Class mvMailBundleClass = NSClassFromString(@"MVMailBundle");
    
    // If this class is not available that means Mail.app
    // doesn't allow bundles anymore. Fingers crossed that this never happens!
    if (!mvMailBundleClass) {
        NSLog(@"Mail.app doesn't support bundles anymore, So deadlock !");
        return;
    }
    
    // Registering plugin in Mail.app
    [mvMailBundleClass registerBundle];
    
    NSLog(@"Gapple initialized");
}

+ (void) load {
    [GappleMessageViewer onLoad];
    [GappleMailTableView onLoad];
    [GappleMessageViewController onLoad];
//    [GappleMessageListController onLoad];
    NSLog(@"Gapple loaded");
}

@end
