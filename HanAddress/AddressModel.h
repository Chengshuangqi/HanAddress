//
//  AddressModel.h
//  MOFSPickerManager
//
//  Created by 123 on 2018/2/28.
//  Copyright © 2018年 Han. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CityModel,DistrictModel,GDataXMLElement;
@interface AddressModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *zipcode;
@property (nonatomic, strong) NSString *index;
@property (nonatomic, strong) NSMutableArray<CityModel *> *list;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

@interface CityModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *zipcode;
@property (nonatomic, strong) NSString *index;
@property (nonatomic, strong) NSMutableArray<DistrictModel *> *list;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

@interface DistrictModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *zipcode;
@property (nonatomic, strong) NSString *index;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end
