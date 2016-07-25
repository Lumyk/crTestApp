//
//  VEList.h
//  qoocoTestApp
//
//  Created by Evgeny Kalashnikov on 26.07.16.
//  Copyright © 2016 Evgeny Kalashnikov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VEList;

@protocol VEListDataSource <NSObject>
- (NSInteger) numberOfRows:(VEList *)listView;
- (Fields *) list:(VEList *)listView fieldsForIndexPath:(NSIndexPath *)indexPath;
@end

@protocol VEListDelegate <NSObject>
@optional
- (void) list:(VEList *)listView didSelectAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface VEList : UIView

@property (nonatomic, weak) id<VEListDataSource> dataSource;
@property (nonatomic, weak) id<VEListDelegate> delegate;

@end
