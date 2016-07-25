//
//  VEList.m
//  qoocoTestApp
//
//  Created by Evgeny Kalashnikov on 26.07.16.
//  Copyright © 2016 Evgeny Kalashnikov. All rights reserved.
//

#import "VEList.h"
#import "VEListCell.h"

@interface VEList () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation VEList

- (void)drawRect:(CGRect)rect {
    // Drawing code
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource numberOfRows:self];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VEListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"VEListCell" owner:self options:nil][0];
    }
    
    cell.field = [self.dataSource list:self fieldsForIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(list:didSelectAtIndexPath:)]) {
        [self.delegate list:self didSelectAtIndexPath:indexPath];
    }
}

@end
