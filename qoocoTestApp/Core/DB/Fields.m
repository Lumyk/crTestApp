//
//  Fields.m
//  
//
//  Created by Evgeny Kalashnikov on 25.07.16.
//
//

#import "Fields.h"

@implementation Fields

- (NSArray *) getCoordinates {
    return [NSKeyedUnarchiver unarchiveObjectWithData:self.coordinates];
}

@end
