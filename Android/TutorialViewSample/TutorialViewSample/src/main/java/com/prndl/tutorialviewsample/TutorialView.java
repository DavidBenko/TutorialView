

package com.prndl.tutorialviewsample;

import android.content.Context;
import android.graphics.*;
import android.os.Bundle;
import android.util.Log;
import android.view.MotionEvent;
import android.view.View;

import java.util.ArrayList;

public class TutorialView extends android.app.Activity {
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        Tutorial t = new Tutorial(this);
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

    public static class Tutorial extends View {


        public static final float VIEW_ALPHA = 0.8f;
        public static final String VIEW_COLOR = "#000000";
        public static final float LINE_WIDTH = 5.0f;
        public static final String ARROW_COLOR = "#FFFFFF";
        public static final float DRAW_ANIMATION_SPEED = 30.0f;
        public static final float TIP_FRAME_PADDING = 15.0f;

        private static Paint paint;
        private Path pathAnimated;
        private Path pathNoAnimation;
        private Context context;
        float[] dashes = { 0.0f, Float.MAX_VALUE };
        private ArrayList<Arrow> arrows;

        public Tutorial(Context context) {
            super(context);

            this.context=context;
            this.setBackgroundColor(Color.parseColor(VIEW_COLOR));
            this.setAlpha(VIEW_ALPHA);
            this.arrows = new ArrayList<Arrow>();
            paint = new Paint();
            paint.setColor(Color.parseColor(ARROW_COLOR));
            paint.setStrokeWidth(LINE_WIDTH);
            paint.setAntiAlias(true);
            paint.setStrokeCap(Paint.Cap.ROUND);
            paint.setStrokeJoin(Paint.Join.ROUND);
            paint.setStyle(Paint.Style.STROKE);
        }

        private Point getClosestPointInRectToPoint(Rect rect, Point point){
            float xMin = rect.left;
            float yMin = rect.top;
            float xMax = rect.right;
            float yMax = rect.bottom;

            float closeX;
            float closeY;

            if(point.x < xMin) closeX = xMin;
            else if (point.x > xMax) closeX = xMax;
            else closeX = point.x;

            if(point.y < yMin) closeY = yMin;
            else if (point.y > yMax) closeY = yMax;
            else closeY = point.y;

            return new Point((int)closeX,(int)closeY);
        }

        public void addArrow(Arrow arrow){
            this.arrows.add(arrow);
            generatePath();
        }
        private void generatePath(){
            Path pAnimated = new Path();
            Path pNoAnimated = new Path();
            for (Arrow a : this.arrows)
                if(a.getAnimated()) pAnimated.addPath(a.getPath());
                else pNoAnimated.addPath(a.getPath());

            this.pathAnimated = pAnimated;
            this.pathNoAnimation = pNoAnimated;
        }

        @Override
        public void onDraw(Canvas canvas) {
            super.onDraw(canvas);

            if(this.arrows.isEmpty()){
                Log.i("TutorialView","No Arrows to Draw!");
                return;
            }

            /*
             * Animated Arrows
             */

            if(!pathAnimated.isEmpty()){
                dashes[0]+= DRAW_ANIMATION_SPEED;
                paint.setPathEffect(new DashPathEffect(dashes, 0));
                canvas.drawPath(pathAnimated, paint);
                invalidate();
            }

            /*
             * Non-Animated Arrows
             */

            if(!pathNoAnimation.isEmpty()){
                paint.setPathEffect(null);
                canvas.drawPath(pathNoAnimation,paint);
            }
        }

        public void dismissView(Boolean animated){
            this.setVisibility(View.GONE);
        }

        @Override
        public boolean onTouchEvent(MotionEvent event) {
            this.dismissView(true);
            return true;
        }
    }
}
