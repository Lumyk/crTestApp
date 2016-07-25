//
//  MVMain.m
//  qoocoTestApp
//
//  Created by Evgeny Kalashnikov on 25.07.16.
//  Copyright © 2016 Evgeny Kalashnikov. All rights reserved.
//

#import "MVMain.h"
#import "VEMap.h"
#import "VEList.h"
#import "MVDetail.h"

const int topPading = 64;

@interface MVMain () <VEListDataSource,VEListDelegate> {
    VEMap *mapView_;
    VEList *listView_;
    NSArray *fields;
}

- (IBAction)listTypaChangeAction:(UISegmentedControl *)sender;
@end

@implementation MVMain

- (void)viewDidLoad {
    [super viewDidLoad];
    fields = [MLStorage shared].allFields.copy;
    
    mapView_ = [[VEMap alloc] init];
    mapView_.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-topPading);
    
    listView_ = [[NSBundle mainBundle] loadNibNamed:@"VEList" owner:self options:nil][0];
    listView_.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-topPading);
    listView_.dataSource = self;
    listView_.delegate = self;
    
    [self.view addSubview:listView_];
}

- (NSInteger)numberOfRows:(VEList *)listView {
    return fields.count;
}

- (Fields *)list:(VEList *)listView fieldsForIndexPath:(NSIndexPath *)indexPath {
    return fields[indexPath.row];
}

- (void)list:(VEList *)listView didSelectAtIndexPath:(NSIndexPath *)indexPath {
    MVDetail *vc = [[MVDetail alloc] init];
    vc.field = fields[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)listTypaChangeAction:(UISegmentedControl *)sender {
    UIView *oldView = (sender.selectedSegmentIndex == 0)?mapView_:listView_;
    UIView *newView = (sender.selectedSegmentIndex != 0)?mapView_:listView_;
    [self.view addSubview:newView];
    [oldView removeFromSuperview];
    
    if (sender.selectedSegmentIndex == 1) {
        if (!mapView_.fields) {
            mapView_.fields = fields;
        }
        [mapView_ loadFields];

    }
}
@end
