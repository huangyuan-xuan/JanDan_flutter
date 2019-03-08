package com.huangyuanlove.jandan_flutter;

import androidx.appcompat.app.AppCompatActivity;
import android.os.Bundle;

import io.flutter.facade.Flutter;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView( Flutter.createView(this,getLifecycle(),"main"));

    }
}
