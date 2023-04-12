---
sidebar_position: 2
sidebar_label: JavaScript SDK
---

# JavaScript SDK

## Một số trường hợp sử dụng
### Khởi tạo bản đồ với cấu hình bản đồ nền cơ bản
1. Khởi tạo thẻ `div` với id trong html
```html
        <div id="map"></div>
```
2. Khai báo thông tin css cho thẻ `div`
```css
        #map {
            height: 600px;
            width: 600px;
        }
```
3. Sử dụng hàm `createMap` để khởi tạo bản đồ cơ bản với bản đồ nền `Google`
```javascript
        var map = BCG.BecaGIS.createMap("map", {}, {
            baseLayer: "Google"
        })
```
4. Mã nguồn hoàn chỉnh
```html
        <html>
            
        </html>
```
### Khởi tạo bản đồ với đầy đủ các thông số
1. Sử dụng hàm `createMap` để khởi tạo bản đồ với đầy đủ các thông số
```javascript
        var map = BCG.BecaGIS.createMap("map", {}, {
            geoPortal: {
                geoPortalUrl: "<geoportal_url>",
                loginInfo: {
                    clientId: "<geoportal_clientid>",
                    clientSecret: "<geoportal_clientsecret>",
                    username: "<geoportal_username>",
                    password: "<geoportal_password>"
                },
                layers: [{
                    layers: "<geoportal_layer_typename>",
                    options: {
                        featureInfo: true,
                        featureInfoOptions: {
                            showFeatureHandler: (feature) => {
                                // TODO: Hàm callback để hiển thị feature
                            }
                        }
                    }
                }]
            },
            map: {
                controls: {
                    drawControl: false,
                    measurementControl: false,
                    searchPlaceControl: false,
                    scaleControl: false,
                    geoPortalLayersControl: false,
                    geoPortalLoginControl: false,
                    geoPortalWmsLegendControl: false,
                    geoPortalFeatureSearchControl: false,
                },
                layers: {
                    overlayLayers: [
                        layers:[
                            {
                                type: "GeoJSON|WMS|TileLayer",
                                key: "<Chuỗi khóa duy nhất của layer trong map instance>",
                                options: {
                                    url: "geojson_url | wms url | tile url template",
                                    layers: "Tên layer trong khai báo của url"
                                }
                            }
                        ]
                    ],
                    baseLayers: []
                },
                plugins: {
                    turfPlugin: false,
                    mvtPlugin: false,
                    model3DPlugins: false,
                    model3DTilingPlugins: false
                },
            },
            baseLayer: "Google"
        })
```
### Tạo bản đồ với Marker
1. Sử dụng hàm `createMap` để khởi tạo bản đồ với Marker và popup hiển thị thông báo
```javascript
        var map = BCG.BecaGIS.createMap("map", {}, {
            map: {
                layers: {
                    overlayLayers: [
                        layers:[
                            {
                                type: "GeoJSON",
                                key: "<Chuỗi khóa duy nhất của layer trong map instance>",
                                options: {
                                    data: {
                                        "type": "Feature",
                                        "properties": {},
                                        "geometry": {
                                            "coordinates": [
                                                106.6661822358538,
                                                11.052296887021058
                                            ],
                                            "type": "Point"
                                        }
                                    },
                                    showPopup: {
                                        content: "BecaGIS Team"
                                    }
                                }
                            }
                        ]
                    ]
                }
            },
            baseLayer: "Google"
        })
```
### Tạo bản đồ với WMS Layer từ GeoPortal
1. Sử dụng hàm `createMap` để khởi tạo thông tin đăng nhập GeoPortal, danh sách WMS layer 
được phân quyền truy cập từ GeoPortal
```javascript
        var map = BCG.BecaGIS.createMap("map", {}, {
            geoPortal: {
                geoPortalUrl: "<geoportal_url>",
                loginInfo: {
                    clientId: "<geoportal_clientid>",
                    clientSecret: "<geoportal_clientsecret>",
                    username: "<geoportal_username>",
                    password: "<geoportal_password>"
                },
                layers: [{
                    layers: "<geoportal_layer_typename>",
                    options: {
                        featureInfo: true,
                        featureInfoOptions: {
                            showFeatureHandler: (feature) => {
                                // TODO: Hàm callback để hiển thị feature
                            }
                        }
                    }
                }]
            }
        })
```

### Tìm kiếm Feature với GeoPortal Connector
1. Kết nối GeoPortal từ `createMap` để khởi tạo thông tin đăng nhập GeoPortal, 
các Feature được phân quyền truy cập từ GeoPortal
```javascript
        var map = BCG.BecaGIS.createMap("map", {}, {
            geoPortal: {
                geoPortalUrl: "<geoportal_url>",
                loginInfo: {
                    clientId: "<geoportal_clientid>",
                    clientSecret: "<geoportal_clientsecret>",
                    username: "<geoportal_username>",
                    password: "<geoportal_password>"
                },
                layers: [{
                    layers: "<geoportal_layer_typename>",
                    options: {
                        featureInfo: true,
                        featureInfoOptions: {
                            showFeatureHandler: (feature) => {
                                // TODO: Hàm callback để hiển thị feature
                            }
                        }
                    }
                }]
            }
        })
```
2. Truy xuất danh sách Features dựa vào truy vấn CQL.
```javascript
    var features = await map.geoPortal
            .getFeaturesHelper()
            .getFeatures("layer1,layer2,layer3", {CQL_FILTER: "prop=searchText"});
```
3. Truy xuất danh sách Features bằng phép tính WITHIN Geometry
```javascript
    var geoJson =     {
      "type": "Feature",
      "properties": {},
      "geometry": {
        "coordinates": [
          [
            [106.6482317147952,11.087427890480868],
            [106.6482317147952,11.029666522504229],
            [106.72984719825786,11.029666522504229],
            [106.72984719825786,11.087427890480868],
            [106.6482317147952,11.087427890480868]
          ]
        ],
        "type": "Polygon"
      }
    };
    var features = await map.geoPortal
            .getFeaturesHelper()
            .getFeaturesWithinGeoJSON("layer1", "the_geom", geoJson);
```
> *** Hướng dẫn CQL Query xem chi tiết [tại đây](https://docs.geoserver.org/2.22.x/en/user/tutorials/cql/cql_tutorial.html)

4. Truy xuất thông tin mô tả thuộc tính của Feature
```javascript
    var featureAttributes = await map.geoPortal
                            .getFeaturesHelper()
                            .getFeatureAttributes("layername");
```
## Tài liệu tham khảo API
### Map
> Map API là đối tượng chính của BecaGIS SDK, là đối tượng thể hiện nên bản đồ, được kế thừa từ bộ thư viên LeafletJS
> Được BecaGIS bổ sung các method, module, plugins nhằm phục vụ kết nối BecaGIS Platform và tăng cường các tác vụ xử lý dữ liệu không gian
#### Khởi tạo Map bằng `BCG.BecaGIS.createMap`
```html
    <div id="divMapId"></div>
```
```css
    #divMapId {
        width: 500px;
        height: 500px
    }
```
```javascript
    var map = BCG.BecaGIS.createMap('divMapId', options, config)
```
> Diễn giải các thông số:
> - **divId**: là id của thẻ div được chọn làm Map, điều kiện thẻ div phải được xác định width và height
> - **options**: là các cấu hình thay thế mặc định cho properties của map, sẽ được diễn giải ở Properties
> Có 2 thông số bắt buộc khi khởi tạo map:
>   - **center**: xác định vị trí trung tâm của map khi khởi tạo
>   - **zoom**: mức zoom mặc định của map khi khởi tạo
> - **config**: là các cấu hình liên quan đến GeoPortal, Plugins, Module khác.
#### Options
>**Map State Options**
> - _crs_: hệ tọa độ
> - _center_(*): [LatLng](#LatLng) vị trí trung tâm khi khởi tạo
> - _zoom_(Number)(*): độ zoom mặc định
> - _minZoom_(Number): độ zoom nhỏ nhất cho phép
> - _maxZoom_(Number): độ zoom lớn nhất cho phép
> - _layers_(Number): danh sách layers được thêm mặc định
> - _maxBounds_([LatLngBounds](#LatLngBounds): Bounds tối đa
>
>**Animation Options**
> - _zoomAnimation_(Boolean): hiệu ứng khi phóng to, thu nhỏ
> - _zoomAnimationThreshold_(Number): chênh lệch mức zoom để xuất hiện hiệu ứng
> - _fadeAnimation_(Boolean): hiệu ứng fade in/out khi tile được thay thế đối với [TileLayer](#TileLayer)
> 
>**Control options**
> - _zoomControl_(Boolean): hiển thị zoom control
> - _attributionControl_(Boolean): hiển thị thông tin nhà phát triển
> 
>[Xem thêm...](https://leafletjs.com/reference.html#map)

#### Config
>**Cấu hình GeoPortal**
> - _geoPortal_: chứa các cấu hình liên quan đến [GeoPorta](#GeoPortal)
> - _map_: chứa các cấu hình modules, control, plugins
>```javascript
>    map: {
>        controls: {
>            drawControl: false,
>            measurementControl: false,
>            searchPlaceControl: false,
>            scaleControl: false,
>            geoPortalLayersControl: false,
>            geoPortalLoginControl: false,
>            geoPortalWmsLegendControl: false,
>            geoPortalFeatureSearchControl: false,
>        },
>        layers: {
>            overlayLayers: [
>                    {
>                        type: "GeoJSON|WMS|TileLayer",
>                        key: "<Chuỗi khóa duy nhất của layer trong map instance>",
>                        options: {
>                            url: "geojson_url | wms url | tile url template",
>                            layers: "Tên layer trong khai báo của url"
>                        }
>                    }
>            ],
>            baseLayers: []
>        },
>        plugins: {
>            turfPlugin: false,
>            mvtPlugin: false,
>            model3DPlugins: false,
>            model3DTilingPlugins: false
>        },
>    },
> ```

#### Methods


### GeoPortal
> GeoPortal API chứa các methods giúp tương tác với website GeoPortal được phát triển bởi BecaGIS.
Nhóm các methods trong GeoPortal API giúp khai thác các dịch vụ WFS và WMS được cung cấp bởi Website GeoPortal
> Để sử dụng GeoPortal API, cần thực hiện các bước sau:
> 1. Khai báo GeoPortal bằng method `createMap`
> 2. Xác thực tài khoản
> - Dữ liệu trong GeoPortal được khai báo với phân quyền theo từng người dùng và nhóm người dùng cụ thể,
> để có thể truy cập vào dữ liệu, người dùng phải thông qua thao tác xác thực được hỗ trợ bởi GeoPortal API.
> 3. Gọi các methods theo như cầu sử dụng

#### Khai báo GeoPortal bằng `createMap`
```javascript
        var map = BCG.BecaGIS.createMap("map", {}, {
            geoPortal: {
                geoPortalUrl: "<geoportal_url>",
                loginInfo: {
                    clientId: "<geoportal_clientid>",
                    clientSecret: "<geoportal_clientsecret>",
                    username: "<geoportal_username>",
                    password: "<geoportal_password>"
                },
                layers: [{
                    layers: "<geoportal_layer_typename>",
                    options: {
                        featureInfo: true,
                        featureInfoOptions: {
                            showFeatureHandler: (feature) => {
                                // TODO: Hàm callback để hiển thị feature
                            }
                        }
                    }
                }]
            },
            map: {
                controls: {
                    geoPortalLayersControl: false,
                    geoPortalLoginControl: false,
                    geoPortalWmsLegendControl: false,
                    geoPortalFeatureSearchControl: false,
                }
            }
        })
```
> Diễn giải các thông số:
> - **geoPortal**: chứa khai báo liên quan đến GeoPortal
>   - **geoPortalUrl**: đường dẫn đến website GeoPortal, ví dụ: https://geoportal.vntts.com.vn
>   - **loginInfo**: Thông tin xác thực tài khoản GeoPortal
>     - **clientId**: Tìm thông số trong menu: Admin Site/Applications/<ứng dụng>/clientId
>     - **clientSecret**: Tìm thông số trong menu: Admin Site/Applications/<ứng dụng>/clientSecret
>     - **username**: Tên đăng nhập của người dùng sử dụng dữ liệu
>     - **password**: Mật khẩu của người dùng sử dụng dữ liệu
>   - **layers**: Khai báo các danh sách layers được sử dụng ở ứng dụng khi vừa khởi tạo đối tượng map
>     - Trong mỗi khai báo Layer, gồm các thông số sau:
>       - **layers**: Là typename của Layer trong GeoPortal
>       - **options**: Chứa các khai báo bổ sung cho Layers
>         - **featureInfo**: Khai báo sử dụng chức năng chọn vào Feature trên bản đồ và hiển thị thông tin.
>         - **featureInfoOptions**: Các thông tin bổ sung cho FeatureInfo
>           - **showFeatureHandler**: function(feature): Đây là hàm callback, gọi sau khi Feature được click trên map.
> - Ngoài ra một số chức năng khác tương tác với GeoPortal được khai báo dưới dạng plugins trong khai báo `map`
> - **map**: Đối tượng khai báo cấu hình cho map
>   - **controls**: Nơi khai báo các plugins controls
>     - **geoPortalLayersControl**: Khai báo control chưa danh sách các Layers của GeoPortal mà thông tin xác thực được quyền truy cập.
>     - **geoPortalLoginControl**: Khai báo control cho phép người dùng có thể tự login vào GeoPortal
>     - **geoPortalWmsLegendControl**: Khai báo control cho phép hiển thị legend các active layer của GeoPortal
>     - **geoPortalFeatureSearchControl**: Khai báo control cho phép tìm kiếm thông tin các Feature thuộc active Layer của GeoPortal
#### Methods và properties của GeoPortal API
> GeoPortal API sử dụng thông qua đối tượng `map` (được khởi tạo bởi `createMap`), thông qua lời gọi `getGeoPortal()`
> ```javascript
>   var map = BCG.createMap('map', {.....})
>   map.getGeoPortal().... /// Lời gọi đối tượng GeoPortal
> ```
> Sau khi `createMap` thực thi, GeoPortal API sẽ tiến hành đăng nhập vào website và lưu trữ `accessToken`  và `refreshToken`
> phục vụ cho những lần sử dụng trong phiên làm việc.

> **setAccessToken(accessToken)**
> - Thiết lập giá trị accessToken

> **getAccessToken(): String**
> - Lấy giá trị accessToken

> **getRefreshToken(): String**
> - Lấy giá trị refreshToken

> **async loginAsync(loginInfo)**
> - Đăng nhập bằng `loginInfo{clientId, clientSecret, username, password}`

> **async getLayersDataAsync(): Object[]**
> - Truy xuất danh sách layers được quyền truy cập, kết quả trả về là danh sách `layers[{alternate, name, title}]`

> **getFeatureHelper(): Object**
> - Truy xuất module FeatureHelper giúp thao tác lên dữ liệu của GeoPortal Layer

> **async getFeatureHelper().getFeatureInfo(params): Object**
> - Truy xuất thông tin chi tiết của Feature dựa thông số của [WMS GetFeatureInfo](https://docs.geoserver.org/2.22.x/en/user/services/wms/reference.html#getfeatureinfo)
>   - `params: {bbox, height, width, layers, query_layers, info_format, x, y}`

> **async getFeatureHelper().getFeatureTypeList(): Object[]**
> - Truy xuất danh sách tất cả layers của GeoPortal được quyền truy cập với đầy đủ thông tin liên quan của layer

> **async getFeatureHelper().getFeatureDescription(layer): Object**
>  - Truy xuất thông tin chi tiết của layer 

> **async getFeatureHelper().getFeatureResourceDescription(layer): Object**
> - Truy xuất thông tin chi tiết của layer, kết quả trả về theo mô tả Resource Description

> **async getFeatureHelper().getFeatures(layer, params)** 
> - Truy xuất danh sách Features dựa theo kết quả tìm kiếm bằng params: {CQL_FILTER}

> **async getFeatureHelper().getFeatuersWithinGeoJSON(layer, geoPropName, geoJson): Object[]**
> - Truy xuất danh sách Features với hàm Within được so sánh với tham số dữ liệu geoJson

> **async getFeatureHelper().getFeatureAttributes(layer): Object**
> - Truy xuất danh sách các attributes của layer

> **getAuthHelper(): Object**
> - Truy cập module chứa các method thực thi xác thực

> **async getAuthHelper().getTokenInfoAsync(loginInfo): Object**
> - Lấy `TokenInfo{access_token, expires_in, token_type, scope, refresh_token}` 
> từ tham số `LoginInfo{clientId, clientSecret, username, password}`
 
> **async getAuthHelper().getAuthorizationString(): String**
> - Tạo Authorization String từ dữ liệu xác thực đã lưu trữ trước đó
 
> **async getAuthHelper().getTokenInfoByRefreshTokenAsync(): Object**
> - Lấy `TokenInfo{access_token, expires_in, token_type, scope, refresh_token}` từ `refresh_token` đang được lưu trữ

### Kiểu dữ liệu cơ bản
#### LatLng
1. LatLng là kiểu dữ liệu cơ bản, LatLng định nghĩa cấu trúc lưu trữ latitude và longitude
2. Khởi tạo giá trị LatLng
```javascript
    var latlng = BCG.latLng(11.05310, 106.66616)
```
Trong khi sử dụng LatLng có thể sử dụng thông qua các dạng khai báo như sau:
```javascript
    map.panTo([11.05310, 106.66616]);
    map.panTo({lng: 106.66616, lat: 11.05310});
    map.panTo({lat: 11.05310, lng: 106.66616});
    map.panTo(L.latLng(11.05310, 106.66616));
```
3. Methods và Properties
> **equal(latlngOther, numberOfMagin): Boolean**
> - So sánh 2 giá trị LatLng, trả về true nếu 2 điểm là giống nhau
> - Tham số
>   - latlngOther: một LatLng khác
>   - numberOfMargin: giá trị margin tối đa để xác định 2 điểm là trùng nhau
> ```javascript
>    var latlng = BCG.latLng(11.05310, 106.66616);
>    var latlngOther = BCG.latLng(11.05, 106.66);
>    var isEqual = latlng.equal(latlngOther, 0.001);
> ```

> **toString(): String** 
> - Trả về một chuỗi thể hiện giá trị của LatLng

>  **distanceTo(latlngOther): Number**
> - Trả về giá trị khoảng cách đến một LatLng theo meter 
> - Trong đó:
>   - latlngOther: một LatLng khác
> ```javascript
>    var latlng = BCG.latLng(11.05310, 106.66616);
>    var latlngOther = BCG.latLng(11.05, 106.66);
>    var distanceInMeters = latlng.distanceTo(latlngOther, 0.001);
> ```

> **toBounds(sizeInMeters): [LatLngBounds](#LatLngBounds)**
> - Trả về giá trị [LatLngBounds](#LatLngBounds) được tính các góc bằng sizeInMeters / 2
> - Thông số:
>   - Giá trị khoảng cách để tạo các góc có khoảng cách sizeInMeters / 2

> **Properties**
> - lat: Giá trị latitude theo độ
> - lng: Giá trị longitude theo độ
> - alt: Giá trị altitude theo độ

#### LatLngBounds
1. Định nghĩa hình chữ nhật được mô tả bằng 2 giá trị [LatLng](#LatLng), góc Tây-Nam và góc Đông-Bắc
2. Khởi tạo
```javascript
    var southwest = BCG.latLng(11.052296887021058, 106.6661822358538);
    var northeast = BCG.latLng(11.05376950525995, 106.6682242178851);
    var latlngBounds = BCG.latLngBounds(southwest, northeast);
```
Trường hợp sử dụng phố biến, xác định khung nhìn bản đồ.
```javascript
    map.fitBounds(latlngBounds)
    map.fitBounds([
        [11.052296887021058, 106.6661822358538],
        [11.05376950525995, 106.6682242178851]
    ])
```
> Có thể khởi tạo LatLngBounds bằng 2 cách
> - BCG.latLngBounds(<[LatLng](#LatLng)> southwest, <[LatLng](#LatLng)> northeast)
> - BCG.latLngBounds([LatLng](#LatLng)[]) latlngs)

3. Methods và Properties
> **getCenter(): [LatLng](#LatLng)**
> - Trả về giá trị [LatLng](#LatLng) là center của bounds

> **getSouthWest(): [LatLng](#LatLng)**
> - Trả về giá trị [LatLng](#LatLng) là điểm SouthWest

> **getNorthEast(): [LatLng](#LatLng)**
> - Trả về giá trị [LatLng](#LatLng) là điểm NorthEast

> **getNorthWest(): [LatLng](#LatLng)**
> - Trả về giá trị [LatLng](#LatLng) là điểm NorthWest

> **getSouthEast(): [LatLng](#LatLng)**
> - Trả về giá trị [LatLng](#LatLng) là điểm SouthEast

> **getWest(): Number**
> - Trả về giá trị Number là West Longitude

> **getSouth(): Number**
> - Trả về giá trị Number là South Latitude

> **getEast(): Number**
> - Trả về giá trị Number là East Longitude

> **getNorth(): Number**
> - Trả về giá trị Number là North Latitude

> **contains(<[LatLngBounds](#LatLngBounds)> latlngBoundsOther): Boolean**
> - Trả về giá trị true nếu chứa một [LatLngBounds](#LatLngBounds) khác

> **intersects(<[LatLngBounds](#LatLngBounds)> latlngBoundsOther): Boolean**
> - Trả về giá trị true nếu giao một [LatLngBounds](#LatLngBounds) khác

> **overlaps(<[LatLngBounds](#LatLngBounds)> latlngBoundsOther): Boolean**
> - Trả về giá trị true nếu chồng lên một [LatLngBounds](#LatLngBounds) khác

> **toBBoxString(): String**
> - Trả về một chuỗi kèm theo tọa độ trong định dạng 
> 'southwest_lng,southwest_lat,northeast_lng,northeast_lat

> **equals(<[LatLngBounds](#LatLngBounds)> latlngBoundsOther): Boolean**
> - Trả về giá trị true nếu giống một [LatLngBounds](#LatLngBounds) khác trong giới hạn margin

> **isValid(): Boolean**
> - Trả về giá trị true nếu đối tượng [LatLngBounds](#LatLngBounds) hợp lệ


#### Point
1. Định nghĩa dữ liệu điểm x, y theo pixel
2. Khởi tạo
```javascript
    var point = BCG.point(200, 300)
```
Trường hợp sử dụng phố biến, xác định tọa độ trung tâm của bản đồ.
```javascript
    map.panBy([200, 300]
    map.panBy(BCG.point(200, 300))
    /////
```
3. Methods và Properties

> **add(<[Point](#Point)> otherPoint): [Point](#Point)**
> - Trả về [Point](#Point) là kết quả của phép cộng

> **subtract(<[Point](#Point)> otherPoint): [Point](#Point)**
> - Trả về [Point](#Point) là kết quả của phép trừ

> **divideBy(num): [Point](#Point)**
> - Trả về [Point](#Point) là kết quả của phép chia cho num

> **multiplyBy(num): [Point](#Point)**
> - Trả về [Point](#Point) là kết quả của phép nhân với num

> **scaleBy(<[Point](#Point)> scale): [Point](#Point)**
> - Trả về [Point](#Point) là kết quả của phép nhân x với scale.x và y với scale.y

> **unscaleBy(<[Point](#Point)> scale): [Point](#Point)**
> - Trả về [Point](#Point) là kết quả của phép chia x với scale.x và y với scale.y

> **round(): [Point](#Point)**
> - Trả về [Point](#Point) là kết quả làm tròn 2 giá trị x,y

> **floor(): [Point](#Point)**
> - Trả về [Point](#Point) là kết quả làm tròn xuống 2 giá trị x,y

> **ceil(): [Point](#Point)**
> - Trả về [Point](#Point) là kết quả làm tròn lên 2 giá trị x,y

> **trunc(): [Point](#Point)**
> - Trả về [Point](#Point) là kết quả làm tròn về 0 của 2 giá trị x,y

> **distanceTo(<[Point](#Point)> otherPoint): Number**
> - Trả về kết quả là khoản cách đến otherPoint

> **equals(<[Point](#Point)> otherPoint): Boolean**
> - Trả về true nếu có x, y bằng với otherPoint

> **toString(): String**
> - Trả về String thể hiện 2 giá trị x,y

#### Bounds
### Map
### Layer
#### TileLayer
#### ImageOverlay
#### VideoOverlay
#### GeoJSON
### Control
#### DrawControl
#### SearchControl
#### ScaleControl
### Path
#### Polyline
#### Polygon
#### Circle
#### Rectangle