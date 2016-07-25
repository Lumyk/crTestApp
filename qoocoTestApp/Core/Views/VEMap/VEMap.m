//
//  VEMap.m
//  qoocoTestApp
//
//  Created by Evgeny Kalashnikov on 25.07.16.
//  Copyright © 2016 Evgeny Kalashnikov. All rights reserved.
//

#import "VEMap.h"

@interface VEMap () <GMSMapViewDelegate> {
    GMSMapView *mapView_;
}

@end

@implementation VEMap

- (instancetype)init
{
    self = [super init];
    if (self) {
        mapView_ = [[GMSMapView alloc] init];
        mapView_.myLocationEnabled = YES;
        mapView_.delegate = self;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    mapView_.frame = self.frame;
    [self addSubview:mapView_];
    
    [self loadFields];
}

- (void)loadFields {
    [mapView_ clear];
    NSMutableArray *coordinates = [NSMutableArray new];
    if (_field) {
        coordinates = [self renderShapes:_field.getCoordinates];
    } else if (_fields) {
        for (Fields *field in _fields) {
            [coordinates addObjectsFromArray:[self renderShapes:field.getCoordinates]];
        }
    }
    [self centerCameraFromCoordinates:coordinates];
}

- (void)setFields:(NSArray<Fields *> *)fields {
    _fields = fields;
    _field = nil;
}

- (void)setField:(Fields *)field {
    _field = field;
    _fields = nil;
}

- (NSMutableArray *) renderShapes:(NSArray *)shapes {
    GMSMutablePath *rect_ = [GMSMutablePath path];
    NSMutableArray *allCoordinates = [NSMutableArray new];
    
    for (NSArray *shape in shapes) {
        for (NSArray *polygons in shape) {
            for (NSArray *coordinates in polygons) {
                double latitude = [coordinates[1] doubleValue];
                double longtitude = [coordinates[0] doubleValue];
                [rect_ addCoordinate:CLLocationCoordinate2DMake(latitude, longtitude)];
                [allCoordinates addObject:@{@"latitude" : @(latitude), @"longtitude" : @(longtitude)}];
            }
        }
    }
    GMSPolygon *polygon = [GMSPolygon polygonWithPath:rect_];
    polygon.fillColor = [UIColor colorWithRed:0.25 green:0 blue:0 alpha:0.4];
    polygon.strokeColor = [UIColor blackColor];
    polygon.strokeWidth = 2;
    polygon.map = mapView_;
    return allCoordinates;
}

- (void) centerCameraFromCoordinates:(NSArray *)coordinates {
    NSNumber *maxLat = [coordinates valueForKeyPath:@"@max.latitude"];
    NSNumber *minLat = [coordinates valueForKeyPath:@"@min.latitude"];
    
    NSNumber *maxLon = [coordinates valueForKeyPath:@"@max.longtitude"];
    NSNumber *minLon = [coordinates valueForKeyPath:@"@min.longtitude"];
    
    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithCoordinate:CLLocationCoordinate2DMake(maxLat.doubleValue, maxLon.doubleValue) coordinate:CLLocationCoordinate2DMake(minLat.doubleValue, minLon.doubleValue)];
    
    [mapView_ animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:40.0f]];
}

@end
