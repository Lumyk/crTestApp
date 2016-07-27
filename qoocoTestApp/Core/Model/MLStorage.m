//
//  MLStorage.m
//  qoocoTestApp
//
//  Created by Evgeny Kalashnikov on 25.07.16.
//  Copyright © 2016 Evgeny Kalashnikov. All rights reserved.
//

#import "MLStorage.h"

@implementation NSManagedObject (MLStorage)

+ (instancetype) createEntity {
    NSManagedObjectContext *context = [[MLStorage shared] managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
    return [[self alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
}

+ (NSArray *) findAllSortedBy:(NSString *)sortKey ascending:(BOOL)ascending {
    NSManagedObjectContext *context = [[MLStorage shared] managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
    [request setEntity:entity];

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortKey ascending:ascending];
    [request setSortDescriptors:@[sortDescriptor]];
    
    NSError *error = nil;
    NSArray *result = [[context executeFetchRequest:request error:&error] copy];
    
    if (result == nil || error){
        return nil;
    } else {
        return result;
    }
}

@end

static MLStorage *sharedVar = nil;

@interface MLStorage ()
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation MLStorage

+ (instancetype) shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedVar = [[[self class] alloc] initPrivate];
    });
    return sharedVar;
}

- (instancetype)initPrivate
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)init
{
    NSAssert(YES, @"you cant init, use + (instancetype)shared");
    return nil;
}

- (void) initDb {
    
    if (!self.allFields.count) {
        NSString *fileName = [[NSBundle mainBundle] pathForResource:@"fields" ofType:@"json"];
        NSData *fieldsData = [NSData dataWithContentsOfFile:fileName];
        
        NSArray *fields = [[NSJSONSerialization JSONObjectWithData:fieldsData options:NSJSONReadingAllowFragments error:nil] objectForKey:@"features"];
        
        for (NSDictionary *field in fields) {
            Fields *field_ = [Fields createEntity];
            NSDictionary *fieldP = field[@"properties"];
            field_.name = fieldP[@"name"];
            field_.crop = fieldP[@"crop"];
            field_.area = fieldP[@"till_area"];
            field_.coordinates = [NSKeyedArchiver archivedDataWithRootObject:field[@"geometry"][@"coordinates"]];
            field_.adm = fieldP[@"adm_name"];
            field_.subad = fieldP[@"subad_name"];
            field_.locality = fieldP[@"locality"];
        }
        [self saveContext];
    }
}

#pragma mark - Core Data

- (NSManagedObjectModel *)managedObjectModel {
    
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *documentsDirectory =  [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [documentsDirectory URLByAppendingPathComponent:@"Model.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (NSArray *) allFields {
    return [Fields findAllSortedBy:@"name" ascending:YES];
}


@end
