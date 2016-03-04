## bridgeClient Quickstart

#### Authenticate
```r
bridgeLogin(email='myEmail@awesome.com', password='password', study='studyName')
```

#### Get your user profile
```r
bridgeRestGET('/v3/users/self')
```
