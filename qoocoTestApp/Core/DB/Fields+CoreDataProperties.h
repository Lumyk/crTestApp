//
//  Fields+CoreDataProperties.h
//  
//
//  Created by Evgeny Kalashnikov on 26.07.16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Fields.h"

NS_ASSUME_NONNULL_BEGIN

@interface Fields (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *crop;
@property (nullable, nonatomic, retain) NSNumber *area;
@property (nullable, nonatomic, retain) NSData *coordinates;
@property (nullable, nonatomic, retain) NSString *adm;
@property (nullable, nonatomic, retain) NSString *subad;
@property (nullable, nonatomic, retain) NSString *locality;

@end

NS_ASSUME_NONNULL_END
