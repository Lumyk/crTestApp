//
//  VEMap.h
//  qoocoTestApp
//
//  Created by Evgeny Kalashnikov on 25.07.16.
//  Copyright © 2016 Evgeny Kalashnikov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VEMap : UIView

@property (nonatomic, strong) Fields *field;
@property (nonatomic, strong) NSArray<Fields *> *fields;

- (void)loadFields;

@end
