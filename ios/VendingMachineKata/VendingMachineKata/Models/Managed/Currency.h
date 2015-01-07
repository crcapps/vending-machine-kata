//
//  Currency.h
//  VendingMachineKata
//
//  Created by the Heatherness on 1/7/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Currency : NSManagedObject

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDecimalNumber * value;
@property (nonatomic, retain) NSNumber * diameter;
@property (nonatomic, retain) NSNumber * mass;
@property (nonatomic, retain) NSNumber * thickness;
@property (nonatomic, retain) NSNumber * isAccepted;

@end
