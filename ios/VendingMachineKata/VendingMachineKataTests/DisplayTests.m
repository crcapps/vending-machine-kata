//
//  DisplayTests.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/17/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "Display.h"

@interface DisplayTests : XCTestCase

@end

@implementation DisplayTests

Display *display;

- (void)setUp {
    [super setUp];
    display = [Display new];
}

@end
