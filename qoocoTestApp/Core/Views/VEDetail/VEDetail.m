//
//  VEDetail.m
//  qoocoTestApp
//
//  Created by Evgeny Kalashnikov on 26.07.16.
//  Copyright © 2016 Evgeny Kalashnikov. All rights reserved.
//

#import "VEDetail.h"

@interface VEDetail () <UITableViewDataSource> {
    NSMutableArray *data;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView_;
@end

@implementation VEDetail

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        data = [NSMutableArray new];
    }
    return self;
}

- (void)setField:(Fields *)field {
    _field = field;
    [data setArray:@[@{@"Название" : field.name},@{@"Описание" : field.crop},@{@"Площадь" : [NSString stringWithFormat:@"%@ ha.",field.area]},@{@"Область" : field.adm},@{@"Район" : field.subad},@{@"Нселенный пункт" : field.locality}]];
    [self.tableView_ reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"Cell"];
    }
    NSDictionary *val = data[indexPath.row];
    cell.textLabel.text = [[val allKeys] firstObject];
    cell.detailTextLabel.text = [[val allValues] firstObject];
    return cell;
}

@end
