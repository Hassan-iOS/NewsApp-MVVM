# MVVM architecture sample project

![Swift](https://img.shields.io/badge/swift-4.2-orange.svg)   ![open source](https://img.shields.io/badge/open-source-green.svg) ![MVVM architecture](https://img.shields.io/badge/MVVM-architecture-blue.svg)

## open source news app with MVVM architecture using [news api](https://newsapi.org)

<img src="https://github.com/shadmahani/News-app---MVVM/blob/master/Media/ezgif.com-optimize.gif" width="30%"> 


# New Features!

- receive data from API
- bouncing article image
- shadow + corner radius for collection view 

### Libraries

for this project follwing libraries were used:

* [Alamofire](https://github.com/Alamofire/Alamofire) - for reciving data from api
* [Swifty JSON](https://github.com/SwiftyJSON/SwiftyJSON) - for parsing json objects

### Built-in tools
- observer - for binding data from ViewModel to viewController
- imageDownloader - for downloading and caching images from API

### note
in order to run the app you need to add your apiKey from newsapi.org in ApiService.swift file
```swift
//TODO: Replace this with YOUR api key from newsapi.org ---
    let yourApiKey = ""
```
