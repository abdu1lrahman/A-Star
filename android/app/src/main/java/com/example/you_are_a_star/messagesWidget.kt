package com.example.you_are_a_star

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
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
            val views = RemoteViews(context.packageName, R.layout.messages_widget).apply {
                val todayQuoteBody = widgetData.getString("today_quote_body", null)
                val todayQuoteTitle = widgetData.getString("today_quote_title", null)

                setTextViewText(R.id.text_id, todayQuoteBody ?: "The only limit to our realization of tomorrow is our doubts of today.")
                setTextViewText(R.id.text_id2, todayQuoteTitle ?: "Franklin D. Roosevelt")

                // Create intent to open the Flutter app
                val intent = context.packageManager.getLaunchIntentForPackage(context.packageName)
                intent?.apply {
                    flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
                }

                // Create PendingIntent
                val pendingIntent = PendingIntent.getActivity(
                    context,
                    0,
                    intent,
                    PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
                )

                // Set the click listener on the entire widget
                setOnClickPendingIntent(R.id.te, pendingIntent)
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

    // Create intent to open the Flutter app
    val intent = context.packageManager.getLaunchIntentForPackage(context.packageName)
    intent?.apply {
        flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
    }

    // Create PendingIntent
    val pendingIntent = PendingIntent.getActivity(
        context,
        0,
        intent,
        PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
    )

    // Set the click listener on the entire widget
    views.setOnClickPendingIntent(R.id.te, pendingIntent)

    // Instruct the widget manager to update the widget
    appWidgetManager.updateAppWidget(appWidgetId, views)
}