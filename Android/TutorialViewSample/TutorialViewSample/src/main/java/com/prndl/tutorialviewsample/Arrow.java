//The MIT License (MIT)
//
//Copyright (c) 2013 PRNDL Development Studios, LLC
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.
//
//Created By David Benko on 5/23/2013

package com.prndl.tutorialviewsample;

import android.graphics.Path;
import android.graphics.Point;

public class Arrow {

    public static final float ARROW_HEAD_LENGTH_RATIO = 8.5f;

    private Point head;
    private Point tail;
    private Boolean curved;
    private Boolean animated;
    private String description;
    private Path path;

    public Arrow() {
        this.head = new Point(0,0);
        this.tail = new Point(0,0);
        this.curved = true;
        this.animated = true;
        this.description = "";
        this.path = new Path();
    }
    public void setHead(int x, int y){
        this.setHead(new Point(x,y));
    }
    public void setHead(Point point){
        this.head = point;
        this.generatePath();
    }
    public void setTail(Point point){
        this.tail = point;
        this.generatePath();
    }
    public void setTail(int x, int y){
        this.setTail(new Point(x,y));
    }
    public void setCurved(Boolean curved){
        this.curved = curved;
        this.generatePath();
    }
    public void setAnimated(Boolean animated){
        this.animated = animated;
    }
    public void setDescription(String description){
        this.description = description;
    }
    private void generatePath(){
        Boolean shouldCurve = (head.x == tail.x || head.y == tail.y) ? false : this.curved;

        Path path = new Path();
        path.moveTo(this.head.x,this.head.y);
        if(shouldCurve) path.quadTo(this.head.x,this.tail.y,this.tail.x,this.tail.y);
        else path.lineTo(this.tail.x,this.tail.y);

        //Calculate Arrow Head
        Point A = shouldCurve ? new Point(this.head.x,this.tail.y) : this.tail;
        Point B = this.head;

        // Vector from A to B:
        Point AB = new Point(B.x - A.x, B.y - A.y);

        // Length of AB == distance from A to B:
        double d = Math.hypot(AB.x, AB.y);

        // Arrow size == distance from C to B.
        float arrowSize = getArrowHeadLength(d);

        // Vector from C to B:
        Point CB = new Point((int)(AB.x * arrowSize/d), (int)(AB.y * arrowSize/d));

        // Compute P and Q:
        Point P = new Point(B.x - CB.x - CB.y, B.y - CB.y + CB.x);
        Point Q = new Point(B.x - CB.x + CB.y, B.y - CB.y - CB.x);

        path.moveTo(this.head.x,this.head.y);
        path.lineTo(P.x,P.y);

        path.moveTo(this.head.x,this.head.y);
        path.lineTo(Q.x,Q.y);

        this.path = path;
    }
    private float getArrowHeadLength(double hypotenuse){
        return (float)(hypotenuse / ARROW_HEAD_LENGTH_RATIO);
    }
    public Path getPath(){
        return this.path;
    }
}
