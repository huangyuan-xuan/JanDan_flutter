package com.huangyuanlove.jandan_flutter.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import com.huangyuanlove.jandan_flutter.R;

import androidx.appcompat.app.AppCompatActivity;


public class LicenseAdapter extends BaseAdapter {

    private Context context;
    public String[] groupString ;
    public String[] childString ;
    public LicenseAdapter(AppCompatActivity context){
        this.context = context;
        groupString = context.getResources().getStringArray(R.array.plugin);
        childString = context.getResources().getStringArray(R.array.license);


    }



    @Override
    public int getCount() {
        return Math.min(groupString==null?0:groupString.length,childString==null?0:childString.length);
    }

    @Override
    public Object getItem(int position) {
        return groupString[position];
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        String text = groupString[position] +":" + childString[position];
        GroupViewHolder groupViewHolder;
        if(convertView==null) {
            convertView = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_license_title,parent,false);
            groupViewHolder = new GroupViewHolder();
            groupViewHolder.licenseTitle = convertView.findViewById(R.id.license_title);
            convertView.setTag(groupViewHolder);
        }else{
            groupViewHolder = (GroupViewHolder) convertView.getTag();
        }
        groupViewHolder.licenseTitle.setText(text);
        return convertView;
    }

    static class GroupViewHolder {
        TextView licenseTitle;
    }


}
