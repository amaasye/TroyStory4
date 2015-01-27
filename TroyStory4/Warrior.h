//
//  Warrior.h
//  TroyStory4
//
//  Created by Syed Amaanullah on 1/27/15.
//  Copyright (c) 2015 Syed Amaanullah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Warrior : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber *prowess;

@end
