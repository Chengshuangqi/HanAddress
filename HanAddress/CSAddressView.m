//
//  CSAddressView.m
//  HanAddress
//
//  Created by 123 on 2018/2/28.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "CSAddressView.h"
#import "AddressModel.h"


@interface CSAddressView()<NSXMLParserDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, strong) NSMutableArray<AddressModel *> *dataArray;
@property (nonatomic, assign) NSInteger selectedIndex_province;
@property (nonatomic, assign) NSInteger selectedIndex_city;
@property (nonatomic, assign) NSInteger selectedIndex_district;


@end


@implementation CSAddressView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
        _selectedIndex_province = 0;
        _selectedIndex_city = 0;
        _selectedIndex_district = 0;
        
        
        NSString *xmlFilePath = [[NSBundle mainBundle] pathForResource:@"province_data.xml" ofType:nil];
        NSData *xmlData = [NSData dataWithContentsOfFile:xmlFilePath];
        NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:xmlData];
        xmlParser.delegate = self;
        [xmlParser parse];
    }
    return self;
}
# pragma mark - 协议方法

// 开始
- (void)parserDidStartDocument:(NSXMLParser *)parser {
    
    self.dataArray = [NSMutableArray array];
    
}

// 获取节点头
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    
    if ([elementName isEqualToString:@"province"]) {
        AddressModel *model = [[AddressModel alloc] initWithDictionary:attributeDict];
        model.index = [NSString stringWithFormat:@"%zd", self.dataArray.count];
        [self.dataArray addObject:model];
    } else if ([elementName isEqualToString:@"city"]) {
        CityModel *model = [[CityModel alloc] initWithDictionary:attributeDict];
        model.index = [NSString stringWithFormat:@"%zd", self.dataArray.lastObject.list.count];
        [self.dataArray.lastObject.list addObject:model];
    } else if ([elementName isEqualToString:@"district"]) {
        DistrictModel *model = [[DistrictModel alloc] initWithDictionary:attributeDict];
        model.index = [NSString stringWithFormat:@"%zd", self.dataArray.lastObject.list.lastObject.list.count];
        [self.dataArray.lastObject.list.lastObject.list addObject: model];
    }
    
}



// 结束
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    [self creatPickViewWithFrame:self.frame];
}

- (void)creatPickViewWithFrame:(CGRect)frame
{
    UIView *bgView = [[UIView alloc] initWithFrame:frame];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.3;
    [self addSubview:bgView];
    
    CGFloat viewHeight = frame.size.height;
    CGFloat viewWidth  = frame.size.width;
    
    UIPickerView *pick = [[UIPickerView alloc] initWithFrame:CGRectMake(0, viewHeight * 0.65, viewWidth, viewHeight * 0.35)];
    pick.delegate = self;
    pick.dataSource = self;
    pick.tag = 100;
    pick.backgroundColor = [UIColor whiteColor];
    [self addSubview:pick];
    
    
    [self creatBtnViewWithFrame:pick.frame];
}
- (void)creatBtnViewWithFrame:(CGRect)frame
{
    UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(frame) - 44, frame.size.width, 44)];
    btnView.backgroundColor = [UIColor blackColor];
    [self addSubview:btnView];
    
    for (NSInteger i = 0; i < 2; i++)
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i == 0 ? 5 : (frame.size.width - 50), 0, 44, 44)];
        [btn setTitle:i == 0 ?@"取消":@"确定" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [btnView addSubview:btn];
    }
    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component)
    {
        case 0:
        {
            return self.dataArray.count;
        }
            break;
        case 1:
        {
            AddressModel *address = self.dataArray[self.selectedIndex_province];
            NSArray *citys = address.list;
            return citys.count;
        }
            break;
        case 2:
        {
            AddressModel *address = self.dataArray[self.selectedIndex_province];
            NSArray *citys = address.list;

            CityModel *cityM = citys[self.selectedIndex_city];
            return cityM.list.count;
        }
            break;
        default:
            break;
    }
    

    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case 0:
        {
            AddressModel *address = self.dataArray[row];
            return address.name;
        }
            break;
            
        case 1:
        {
            AddressModel *address = self.dataArray[self.selectedIndex_province];
            CityModel *city = address.list[row];
            return city.name;
        }
            break;
        case 2:
        {
            AddressModel *address = self.dataArray[self.selectedIndex_province];
            CityModel *city = address.list[self.selectedIndex_city];
            DistrictModel *district = city.list[row];
            return district.name;
        }
            break;
        default:
            break;
    }
    return nil;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0:
            self.selectedIndex_province = row;
            self.selectedIndex_city = 0;
            self.selectedIndex_district = 0;
                [pickerView reloadComponent:1];
                [pickerView selectRow:0 inComponent:1 animated:NO];
                [pickerView reloadComponent:2];
                [pickerView selectRow:0 inComponent:2 animated:NO];

            break;
        case 1:
            self.selectedIndex_city = row;
            self.selectedIndex_district = 0;
                [pickerView reloadComponent:2];
                [pickerView selectRow:0 inComponent:2 animated:NO];
            break;
        case 2:
            self.selectedIndex_district = row;
            break;
        default:
            break;
    }
}


- (void)btnClicked:(UIButton *)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(CSAddressView:withDidSelectIndex:withAddressProvince:city:district:)])
    {
        AddressModel *province = self.dataArray[self.selectedIndex_province];
        CityModel *city = province.list[self.selectedIndex_city];
        DistrictModel *district = city.list[self.selectedIndex_district];
        [self.delegate CSAddressView:self withDidSelectIndex:btn.tag withAddressProvince:province.name city:city.name district:district.name];
    }
}

@end
