package com.prndl.tutorialviewsample;

import android.app.Activity;
import android.graphics.Point;
import android.os.Bundle;

import TutorialView.Arrow;
import TutorialView.Tutorial;

/**
 * Created by davidbenko on 4/22/14.
 */
public class ExampleActivity extends Activity {

    @Override
    public void onCreate(Bundle data){
        super.onCreate( data );

        Tutorial t = new TutorialView.Tutorial(this);
        Arrow a = new Arrow();
        a.setHead(new Point(100,100));
        a.setTail(new Point(300, 300));
        t.addArrow(a);


        a = new Arrow();
        a.setHead(new Point(500, 700));
        a.setTail(new Point(200, 400));
        a.setCurved(false);
        t.addArrow(a);

        setContentView(t);

    }
}
