TutorialView
============

TutorialView is a project which will draw animated arrows over your app to instruct the user on the functions of the application. It dynamically draws arrows to the screen based on a head and tail point for the arrow. It will automatically determine the direction and curve of the arrow and draw it to screen with animation. The view will disappear after it has been tapped by the user.

The project consists of two classes: the TutorialView and the Arrow.

The Arrow class is responsible for determining the size and shape of the arrow, its location on the screen, and whether it should be curved and/or animated.

The TutorialView class is the actual overlay responsible for drawing to the screen. On iOS, it uses Core Graphics and Core Animation to render the arrows and the ‘drawing’ animation. On Android, it uses the Path class and other android.graphics.* classes.

This project has been tested on iOS6.X and iOS7 as well as Android 4.X.X.
Feel free to fork me to add updates and bug fixes!




License
============

The MIT License (MIT)

Copyright (c) 2013 PRNDL Development Studios, LLC

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.