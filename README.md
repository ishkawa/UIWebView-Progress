integrates [NJKWebViewProgress](https://github.com/ninjinkun/NJKWebViewProgress) into UIWebView.

## Usage 

```objectivec
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.webView.delegate = self;
    self.webView.progressDelegate = self;
}

#pragma mark - NJKWebViewProgressDelegate

-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    self.progressView = progress;
}
```

## Installing

### CocoaPods

If you use CocoaPods, you can install UIWebView+Progress by inserting config below.

```
pod 'UIWebView+Progress', :git => 'git@github.com:ishkawa/UIWebView-Progress.git'
```

### Without CocoaPods 

- Install [NJKWebViewProgress](https://github.com/ninjinkun/NJKWebViewProgress) and [ISMethodSwizzling](https://github.com/ishkawa/ISMethodSwizzling).
- Add files under `UIWebView+Progress/` to your Xcode project.

## License

Copyright (c) 2013 Yosuke Ishikawa

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
