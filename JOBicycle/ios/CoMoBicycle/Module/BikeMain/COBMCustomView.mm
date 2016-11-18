//
//  COBMView.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/11/2.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "COBMCustomView.h"
#import "COSearchView.h"
#import "COResultInfo.h"
#import "COResultListView.h"

#define MIN_DISTANCE  5.0

@interface COBMCustomView() <BMKLocationServiceDelegate, BMKMapViewDelegate, BMKPoiSearchDelegate>
{
    CLLocation *preLocation;
    BMKPolyline *polyLine;
    NSMutableArray *resultInfoArray;
    NSString *strkeyword;
    UITapGestureRecognizer *tapGesture;
    COResultListView *listView;
}

@property (nonatomic, strong)COSearchView *searchView;
@property (nonatomic, strong)BMKMapView *mapView;
@property (nonatomic, strong)BMKLocationService *locationService;
@property (nonatomic, strong)CLLocationManager *locationManager;
@property (nonatomic, strong)NSMutableArray *locationPointArray; //记录用户经过的点

@property (nonatomic, strong)BMKPoiSearch *poiSearch; //poi 搜索


@end

@implementation COBMCustomView

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.backgroundColor = backGroundColor;
        [self addSubview:self.mapView];
        [self addSubview:self.searchView];
        [self addUIConstraints];
        [self startlocationService];
        [self addTapGesture];
    }
    
    return self;
}

#pragma mark ui layout

- (void)addUIConstraints
{
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.bottom.equalTo(self);
        
    }];
    
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.bottom.right.equalTo(self).insets(UIEdgeInsetsMake(0, 20, 10, 20));
        make.height.mas_equalTo(50);
    }];
}

- (void)addTapGesture
{
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchViewAction:)];
    
    [self addGestureRecognizer:tapGesture];
}

- (void)touchViewAction:(UITapGestureRecognizer *)gesture
{
    [self.searchView.inputSearch resignFirstResponder];
}

#pragma mark init service
- (void)startlocationService
{
    if(ISIOS8)
    {
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    [self.locationService startUserLocationService];
  
}

#pragma mark lazy load

- (COSearchView *)searchView
{
    if(_searchView == nil)
    {
        _searchView = [[COSearchView alloc] init];
        
        WEAK_SELF(weakself)
        _searchView.inputSearchKeywordBlock = ^{
        
            if(weakself.startSearchBlock)
            {
                weakself.startSearchBlock();
            }
        };
    }
    
    return _searchView;
}

- (BMKMapView *)mapView
{
    if(_mapView == nil)
    {
        CGRect rect = CGRectMake(0, 0, MAX_WIDTH, MAX_HEIGHT-NavBarHeight);
        _mapView = [[BMKMapView alloc] initWithFrame:rect];
        
        _mapView.delegate = self;
        _mapView.showsUserLocation = YES;
        _mapView.userTrackingMode = BMKUserTrackingModeFollow;
        _mapView.rotateEnabled = YES;
        
        [_mapView setZoomEnabled:YES];
        
        _mapView.zoomLevel = 13;
    }
    
    return _mapView;
}

- (BMKLocationService *)locationService
{
    if(_locationService == nil)
    {
        _locationService = [[BMKLocationService alloc] init];
        _locationService.delegate = self;
        
        [BMKLocationService setLocationDistanceFilter:6.0];
        [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyBest];
    }
    
    return _locationService;
}

- (CLLocationManager *)locationManager
{
    if(_locationManager == nil)
    {
        _locationManager = [[CLLocationManager alloc] init];
    }
    
    return _locationManager;
}

- (NSMutableArray *)locationPointArray
{
    if(_locationPointArray == nil)
    {
        _locationPointArray = [[NSMutableArray alloc] init];
    }
    
    return _locationPointArray;
}

#pragma mark custom function

- (void)startPoiSearchWithKeyword:(NSString *)strKeyWord
{
    
    [self removeGestureRecognizer:tapGesture];
    
    _poiSearch = [[BMKPoiSearch alloc] init];
    
    _poiSearch.delegate = self;
    
    BMKCitySearchOption *searchOption = [[BMKCitySearchOption alloc] init];
    
    searchOption.city = @"南京市";
    searchOption.keyword = strKeyWord;
    
    strkeyword = strKeyWord;
    
    BOOL blflag = [_poiSearch poiSearchInCity:searchOption];
    if(blflag)
    {
        [self.locationService stopUserLocationService];
    }
    else
    {
        
    }
}


- (void)drawUserRoutes
{
    NSInteger pointCount = [self.locationPointArray count];
    
    BMKMapPoint *mapPoints = new BMKMapPoint[pointCount];
    
    [self.locationPointArray enumerateObjectsUsingBlock:^(CLLocation *UserLocation, NSUInteger idx, BOOL * _Nonnull stop) {
        
        BMKMapPoint locationPoint = BMKMapPointForCoordinate(UserLocation.coordinate);
        
        mapPoints[idx] = locationPoint;
    }];
    
    if(polyLine)
    {
        [self.mapView removeOverlay:polyLine];
    }
    
    polyLine = [BMKPolyline polylineWithPoints:mapPoints count:pointCount];
    
    if(polyLine)
    {
        [self.mapView addOverlay:polyLine];
    }
    
    if(mapPoints)
    {
        free(mapPoints);
        mapPoints = NULL;
    }
}


#pragma mark BMKLocationService Delegate

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [self.mapView updateLocationData:userLocation];
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    if(preLocation)
    {
        CGFloat distance = [userLocation.location distanceFromLocation:preLocation];
        if(distance < MIN_DISTANCE)
        {
            return ;
        }
    }
    
    [self.locationPointArray addObject:userLocation.location];
    
    preLocation = userLocation.location;
    
    [self.mapView updateLocationData:userLocation];
    
    [self drawUserRoutes];
}

/**
 *定位失败后，会调用此函数
 *@param error 错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    
}


#pragma mark BMKViewDelegate


/**
 *点中底图标注后会回调此接口
 *@param mapview 地图View
 *@param mapPoi 标注点信息
 */
- (void)mapView:(BMKMapView *)mapView onClickedMapPoi:(BMKMapPoi*)mapPoi
{
    NSLog(@"on clicked map poi");
}


/**
 *当选中一个annotation views时，调用此接口
 *@param mapView 地图View
 *@param views 选中的annotation views
 */
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    [mapView bringSubviewToFront:view];
    [mapView setNeedsDisplay];
    
    NSLog(@"did select annotionView");
    
    [self showDetailInfoWithAnnotion:view.annotation];
}

/**
 *根据overlay生成对应的View
 *@param mapView 地图View
 *@param overlay 指定的overlay
 *@return 生成的覆盖物View
 */
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay
{
    if([overlay isKindOfClass:[BMKPolyline class]])
    {
        BMKPolylineView *polyLineView = [[BMKPolylineView alloc] initWithPolyline:overlay];
        polyLineView.strokeColor = [orangeViewColor colorWithAlphaComponent:0.5];
        polyLineView.fillColor = [orangeViewColor colorWithAlphaComponent:0.8];
        polyLineView.lineWidth = 5.0;
        
        return polyLineView;
    }
    else
    {
        return nil;
    }
}

/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    static NSString *annotationViewStr = @"keywordMark";
    
    BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:annotationViewStr];
    
    if(annotationView == nil)
    {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationViewStr];
        annotationView.pinColor = BMKPinAnnotationColorRed;
        annotationView.animatesDrop = YES;
    }
    
    annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    annotationView.annotation = annotation;
    annotationView.canShowCallout = YES;
    annotationView.draggable = YES;
    
    return annotationView;
}

#pragma mark poisearch delegate

/**
 *返回POI搜索结果
 *@param searcher 搜索对象
 *@param poiResult 搜索结果列表
 *@param errorCode 错误号，@see BMKSearchErrorCode
 */
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResult errorCode:(BMKSearchErrorCode)errorCode
{
    if(errorCode == BMK_SEARCH_NO_ERROR)
    {
        
        NSArray *array = [NSArray arrayWithArray:[self.mapView annotations]];
        [self.mapView removeAnnotations:array];
        
        NSLog(@"BMKPOI Result is %@", poiResult.poiInfoList);
        
        NSMutableArray *annotationArray = [NSMutableArray array];
        
        if(resultInfoArray == nil)
            resultInfoArray = [NSMutableArray array];
        
        for (BMKPoiInfo *poiInfo in poiResult.poiInfoList) {
            
            BMKPointAnnotation *pointAnnotation = [[BMKPointAnnotation alloc] init];
            pointAnnotation.title = poiInfo.name;
            pointAnnotation.coordinate = poiInfo.pt;
            [annotationArray addObject:pointAnnotation];
            
            COResultInfo *resultInfo = [[COResultInfo alloc] init];
            resultInfo.name = poiInfo.name;
            resultInfo.detail = poiInfo.address;
            resultInfo.uid = poiInfo.uid;
            [resultInfoArray addObject:resultInfo];
        }
        
        [self.mapView addAnnotations:annotationArray];
        [self.mapView showAnnotations:annotationArray animated:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self showSearchResultListView];
        });
        
    }
}

/**
 *返回POI详情搜索结果
 *@param searcher 搜索对象
 *@param poiDetailResult 详情搜索结果
 *@param errorCode 错误号，@see BMKSearchErrorCode
 */
- (void)onGetPoiDetailResult:(BMKPoiSearch*)searcher result:(BMKPoiDetailResult*)poiDetailResult errorCode:(BMKSearchErrorCode)errorCode
{
    if(errorCode == BMK_SEARCH_NO_ERROR)
    {
        NSString *strName = poiDetailResult.name;
        NSString *strUrl = poiDetailResult.detailUrl;
        
        NSLog(@"result name is %@ url is %@", strName, strUrl);
        
        
    }
}

#pragma mark show ResultList

- (void)showSearchResultListView
{
    listView = [[COResultListView alloc] initWithKeyWord:strkeyword InfoData:resultInfoArray];
    
    [listView showView];
    
    WEAK_SELF(weakself)
    listView.DidSelectResultInfoBlock = ^(NSInteger index){
    
        NSMutableArray *annotionArray = [NSMutableArray arrayWithArray:[weakself.mapView annotations]];
        
        BMKPointAnnotation *pointAnnotation = [annotionArray objectAtIndex:index];
        
        [weakself.mapView selectAnnotation:pointAnnotation animated:YES];
        
        CLLocationCoordinate2D location2D = pointAnnotation.coordinate;
        
        [weakself.mapView setCenterCoordinate:location2D animated:YES];
        
        [weakself.mapView zoomIn];
    };
}

- (void)hideResultListView
{
    if(listView)
    {
        [listView hideView];
    }
}


- (void)showDetailInfoWithAnnotion:(BMKPointAnnotation *)pointAnnotation
{
    if([pointAnnotation conformsToProtocol:@protocol(BMKAnnotation)])
    {
        NSInteger index = [[self.mapView annotations] indexOfObject:pointAnnotation];
        
        BMKPoiDetailSearchOption *detailSearchOption = [[BMKPoiDetailSearchOption alloc] init];
        
        COResultInfo *resultInfo = [resultInfoArray objectAtIndex:index];
        
        detailSearchOption.poiUid = resultInfo.uid;
        
        BOOL blFlag = [self.poiSearch poiDetailSearch:detailSearchOption];
        if(blFlag)
        {
            
        }
        else
        {
            
        }
    }
}


@end
