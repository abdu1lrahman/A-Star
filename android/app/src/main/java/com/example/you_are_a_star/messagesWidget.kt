package com.example.you_are_a_star

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin

/**
 * Implementation of App Widget functionality.
 */
class messagesWidget : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        // There may be multiple widgets active, so update all of them
        for (appWidgetId in appWidgetIds) {
            val widgetData = HomeWidgetPlugin.getData(context)
            val views = RemoteViews(context.packageName,R.layout.messages_widget).apply{
                val todayQuoteBody = widgetData.getString("today_quote_body",null)
                val todayQuoteTitle = widgetData.getString("today_quote_title",null)

                setTextViewText(R.id.text_id,todayQuoteBody?:"No Text...")
                setTextViewText(R.id.text_id2,todayQuoteTitle?:"No Text...")

            }
            appWidgetManager.updateAppWidget(appWidgetId,views)
        }
    }

    override fun onEnabled(context: Context) {
        // Enter relevant functionality for when the first widget is created
    }

    override fun onDisabled(context: Context) {
        // Enter relevant functionality for when the last widget is disabled
    }
}

internal fun updateAppWidget(
    context: Context,
    appWidgetManager: AppWidgetManager,
    appWidgetId: Int
) {
    val widgetText = context.getString(R.string.text_id)
    // Construct the RemoteViews object
    val views = RemoteViews(context.packageName, R.layout.messages_widget)
    views.setTextViewText(R.id.text_id, widgetText)
    views.setTextViewText(R.id.text_id2, widgetText)

    // Instruct the widget manager to update the widget
    appWidgetManager.updateAppWidget(appWidgetId, views)
}