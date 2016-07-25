//
//  MVDetail.m
//  qoocoTestApp
//
//  Created by Evgeny Kalashnikov on 26.07.16.
//  Copyright © 2016 Evgeny Kalashnikov. All rights reserved.
//

#import "MVDetail.h"
#import "VEMap.h"
#import "VEDetail.h"

@interface MVDetail () {
    
}

@end

@implementation MVDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.field.name;
    
    CGFloat h = (self.view.bounds.size.height)/2;
    
    VEMap *mapView = [[VEMap alloc] init];
    mapView.frame = CGRectMake(0, 0, self.view.bounds.size.width, h);
    mapView.field = self.field;
    
    [self.view addSubview:mapView];
    
    VEDetail *detailView = [[NSBundle mainBundle] loadNibNamed:@"VEDetail" owner:self options:nil][0];
    detailView.frame = CGRectMake(0, h, self.view.bounds.size.width, h);
    detailView.field = self.field;
 
    [self.view addSubview:detailView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
