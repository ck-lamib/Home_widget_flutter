package com.example.home_widget_test

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.widget.RemoteViews
import java.io.File


// New import.
import es.antonborri.home_widget.HomeWidgetPlugin


/**
 * Implementation of App Widget functionality.
 */
class MyWidget : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
       for (appWidgetId in appWidgetIds) {
            // Get reference to SharedPreferences
            val widgetData = HomeWidgetPlugin.getData(context)
            val views = RemoteViews(context.packageName, R.layout.my_widget).apply {

                val title = widgetData.getString("headline_title", null)
                setTextViewText(R.id.headline_title, title ?: "No title set")

                val description = widgetData.getString("headline_description", null)
                setTextViewText(R.id.headline_description, description ?: "No description set")
                // New: Add the section below
               // Get chart image and put it in the widget, if it exists
               
                val imageName = widgetData.getString("filename", null)
                if(imageName != null){
                    println("inside here")
                    val imageFile = File(imageName)
                    val imageExists = imageFile.exists()
                    if (imageExists) {
                        val bitmapOptions = BitmapFactory.Options()
                        bitmapOptions.inSampleSize = 3
                        val myBitmap: Bitmap = BitmapFactory.decodeFile(imageFile.absolutePath, bitmapOptions)
                        setImageViewBitmap(R.id.widget_image, myBitmap)
                    } else {
                        println("image not found!, looked @: ${imageName}")
                    }
                }else{
                    println("outside here")
                }
                // End new code


            }

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }

    override fun onEnabled(context: Context) {
        // Enter relevant functionality for when the first widget is created
    }

    override fun onDisabled(context: Context) {
        // Enter relevant functionality for when the last widget is disabled
    }

}


