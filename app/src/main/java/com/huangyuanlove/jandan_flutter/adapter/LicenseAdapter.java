package com.huangyuanlove.jandan_flutter.adapter;

import android.app.Activity;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseExpandableListAdapter;
import android.widget.TextView;

import com.huangyuanlove.jandan_flutter.R;


public class LicenseAdapter extends BaseExpandableListAdapter {
    private Context context;
    public String[] groupString ;
    public String[][] childString ;
    public LicenseAdapter(Activity context){
        this.context = context;
        groupString = context.getResources().getStringArray(R.array.plugin);
        childString =new String[][]
                {{context.getResources().getString(R.string.fluttertost)}};


    }




    @Override
    public int getGroupCount() {
        return groupString == null ?0 : groupString.length;
    }

    @Override
    public int getChildrenCount(int groupPosition) {
        return childString == null ?0 : childString.length;
    }

    @Override
    public String getGroup(int groupPosition) {
        return groupString[groupPosition];
    }

    @Override
    public String getChild(int groupPosition, int childPosition) {
        return childString[groupPosition][childPosition];
    }

    @Override
    public long getGroupId(int groupPosition) {
        return groupPosition;
    }

    @Override
    public long getChildId(int groupPosition, int childPosition) {
        return childPosition;
    }

    @Override
    public boolean hasStableIds() {
        return true;
    }

    @Override
    public View getGroupView(int groupPosition, boolean isExpanded, View convertView, ViewGroup parent) {
        GroupViewHolder groupViewHolder;
        if (convertView == null){
            convertView = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_license_title,parent,false);
            groupViewHolder = new GroupViewHolder();
            groupViewHolder.licenseTitle = convertView.findViewById(R.id.license_title);
            convertView.setTag(groupViewHolder);
        }else {
            groupViewHolder = (GroupViewHolder)convertView.getTag();
        }
        groupViewHolder.licenseTitle.setText(groupString[groupPosition]);
        return convertView;
    }

    @Override
    public View getChildView(int groupPosition, int childPosition, boolean isLastChild, View convertView, ViewGroup parent) {
        ChildViewHolder childViewHolder;
        if (convertView==null){
            convertView = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_license_content,parent,false);
            childViewHolder = new ChildViewHolder();
            childViewHolder.licenseContent = convertView.findViewById(R.id.license_content);
            convertView.setTag(childViewHolder);

        }else {
            childViewHolder = (ChildViewHolder) convertView.getTag();
        }
        childViewHolder.licenseContent.setText(childString[groupPosition][childPosition]);
        return convertView;
    }

    @Override
    public boolean isChildSelectable(int groupPosition, int childPosition) {
        return true;
    }


    static class GroupViewHolder {
        TextView licenseTitle;
    }

    static class ChildViewHolder {
        TextView licenseContent;

    }
}
