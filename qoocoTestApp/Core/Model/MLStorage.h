//
//  MLStorage.h
//  qoocoTestApp
//
//  Created by Evgeny Kalashnikov on 25.07.16.
//  Copyright © 2016 Evgeny Kalashnikov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLStorage : NSObject

+ (instancetype) shared;
- (void) initDb;
- (NSArray *) allFields;
@end
