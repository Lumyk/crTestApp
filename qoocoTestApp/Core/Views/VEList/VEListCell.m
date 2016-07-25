//
//  VEListCell.m
//  qoocoTestApp
//
//  Created by Evgeny Kalashnikov on 26.07.16.
//  Copyright © 2016 Evgeny Kalashnikov. All rights reserved.
//

#import "VEListCell.h"

@interface VEListCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cropLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@end

@implementation VEListCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setField:(Fields *)field {
    _field = field;
    self.nameLabel.text = field.name;
    self.cropLabel.text = field.crop;
    self.areaLabel.text = [NSString stringWithFormat:@"%@ ha.",field.area];
    
    [self setNeedsDisplay];
}


@end
