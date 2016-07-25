//
//  Fields.h
//  
//
//  Created by Evgeny Kalashnikov on 25.07.16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Fields : NSManagedObject

- (NSArray *) getCoordinates;
@end

NS_ASSUME_NONNULL_END

#import "Fields+CoreDataProperties.h"
