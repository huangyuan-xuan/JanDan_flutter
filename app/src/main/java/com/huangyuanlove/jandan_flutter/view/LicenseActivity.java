package com.huangyuanlove.jandan_flutter.view;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.widget.ExpandableListView;
import android.widget.ListView;

import com.huangyuanlove.jandan_flutter.R;
import com.huangyuanlove.jandan_flutter.adapter.LicenseAdapter;

public class LicenseActivity extends AppCompatActivity {

    private ListView listView;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_license);

        initView();
    }

    private void initView() {
        listView = findViewById(R.id.license_list);
        listView.setAdapter(new LicenseAdapter(this));

    }
}
