//
//  CSAddressView.h
//  HanAddress
//
//  Created by 123 on 2018/2/28.
//  Copyright © 2018年 Han. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CSAddressView;
@protocol CSAddressViewDelegate <NSObject>

@optional
- (void)CSAddressView:(CSAddressView *)view withDidSelectIndex:(NSInteger)index withAddressProvince:(NSString *)province city:(NSString *)city district:(NSString *)district;

@end

@interface CSAddressView : UIView


@property (nonatomic, weak) id<CSAddressViewDelegate> delegate;

@end
