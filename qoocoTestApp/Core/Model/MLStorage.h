//
//  MLStorage.h
//  qoocoTestApp
//
//  Created by Evgeny Kalashnikov on 25.07.16.
//  Copyright © 2016 Evgeny Kalashnikov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSManagedObject (MLStorage)

+ (instancetype) createEntity;
+ (NSArray *) findAllSortedBy:(NSString *)sortKey ascending:(BOOL)ascending;

@end

@interface MLStorage : NSObject

+ (instancetype) shared;
- (void) initDb;
- (NSManagedObjectContext *)managedObjectContext;
- (NSArray *) allFields;
@end
