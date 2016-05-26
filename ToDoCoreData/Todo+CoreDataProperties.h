//
//  Todo+CoreDataProperties.h
//  ToDoCoreData
//
//  Created by Jayesh Wadhwani on 2016-05-25.
//  Copyright © 2016 Jayesh Wadhwani. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Todo.h"

NS_ASSUME_NONNULL_BEGIN

@interface Todo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *descript;

@end

NS_ASSUME_NONNULL_END
