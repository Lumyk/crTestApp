//
//  MLStorage.m
//  qoocoTestApp
//
//  Created by Evgeny Kalashnikov on 25.07.16.
//  Copyright © 2016 Evgeny Kalashnikov. All rights reserved.
//

#import "MLStorage.h"

static MLStorage *sharedVar = nil;

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
    NSString *fileName = [[NSBundle mainBundle] pathForResource:@"fields" ofType:@"json"];
    NSData *fieldsData = [NSData dataWithContentsOfFile:fileName];
    
    NSArray *fields = [[NSJSONSerialization JSONObjectWithData:fieldsData options:NSJSONReadingAllowFragments error:nil] objectForKey:@"features"];
    
    for (NSDictionary *field in fields) {
        Fields *field_ = [Fields MR_createEntity];
        NSDictionary *fieldP = field[@"properties"];
        field_.name = fieldP[@"name"];
        field_.crop = fieldP[@"crop"];
        field_.area = fieldP[@"till_area"];
        field_.coordinates = [NSKeyedArchiver archivedDataWithRootObject:field[@"geometry"][@"coordinates"]];
        field_.adm = fieldP[@"adm_name"];
        field_.subad = fieldP[@"subad_name"];
        field_.locality = fieldP[@"locality"];
        
    }
}

- (NSArray *) allFields {
    return [Fields MR_findAllSortedBy:@"name" ascending:NO withPredicate:nil];
}

@end
