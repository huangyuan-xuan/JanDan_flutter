package com.huangyuanlove.jandan_flutter.view;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;

import androidx.appcompat.app.AppCompatActivity;
import io.flutter.facade.Flutter;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.FlutterView;

public class MainActivity extends AppCompatActivity {
   private MethodChannel mChannel;
   private FlutterView flutterView;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);


         flutterView = Flutter.createView(this, getLifecycle(), "main");
        initChannel(flutterView);


        setContentView(flutterView);

    }

    private void initChannel(FlutterView flutterView) {
        mChannel = new MethodChannel(flutterView, "my_flutter/plugin");

        mChannel.setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                switch (methodCall.method) {
                    case "to_license":
                        startActivity(new Intent(MainActivity.this,LicenseActivity.class));
                        result.success(true);
                        break;
                    case "to_webview":
                        String url = methodCall.arguments.toString();

                        Uri uri = Uri.parse(url);
                        Intent intent = new Intent(Intent.ACTION_VIEW, uri);
                        if (intent.resolveActivity(getPackageManager()) != null) {
                            // 网址正确 跳转成功
                            startActivity(intent);
                            result.success(true);
                        } else {
                            result.success(false);

                        }

                        result.success("jump");
                        break;
                    case "to_another_flutter":


                        break;
                    default:
                        break;
                }
            }
        });

    }

    @Override
    public void onBackPressed() {
        if(this.flutterView!=null){
            this.flutterView.popRoute();
        }else {
            super.onBackPressed();
        }
    }
}
