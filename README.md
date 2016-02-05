
#VCTransition
The heart of this project is GITransition object, it adopts `UIViewControllerAnimatedTransitioning` and `UIGestureRecognizerDelegate` protocol, which allows you to have one view controller at the bottom, and on the same time keeping your main navigation separate. This was inspired by the iOS 8 emails implementation where you can have your new email open at the bottom while still viewing all your old emails above it.

#Demo
![Demo](https://raw.githubusercontent.com/Dalein/VCTransition/master/demo.gif)

#Example
```objectivec
    transitionManager = [[GITransition alloc] init];
    self.transitioningDelegate = transitionManager;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    controller = [storyboard instantiateViewControllerWithIdentifier:@"vcAddNewGoal"];
    controller.transitioningDelegate = transitionManager;
    controller.modalPresentationStyle = UIModalPresentationCustom;
    controller.transitionManager = transitionManager;

- (IBAction)show:(id)sender {
    [self presentViewController:controller animated:YES completion:nil];
}
```

#Usage
Copy GITransition folder into your project.

# License 
Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
 of the Software, and to permit persons to whom the Software is furnished to do
 so, subject to the following conditions:

 If you happen to meet one of the copyright holders in a bar you are obligated
 to buy them one pint of beer.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
