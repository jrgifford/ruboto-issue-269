require 'ruboto/widget'
require 'ruboto/util/toast'
import android.app.Notification
import android.app.PendingIntent
import android.content.Intent
import android.content.Context
import android.view.View
import android.widget.Toast
import android.util.Log

ruboto_import_widgets :Button, :LinearLayout, :TextView

# http://xkcd.com/378/

class TimerActivity
  HELLO_ID = 1;
  def on_create(bundle)
    super
    set_title 'Domo arigato, Mr Ruboto!'

    self.content_view =
        linear_layout :orientation => :vertical do
          @text_view = text_view :text => 'What hath Matz wrought?', :id => 42, :width => :match_parent,
                                 :gravity => :center, :text_size => 48.0
          button :text => 'M-x butterfly', :width => :match_parent, :id => 43, :on_click_listener => proc { butterfly }
        end
  rescue
    puts "Exception creating activity: #{$!}"
    puts $!.backtrace.join("\n")
  end

  private

  def butterfly
    @text_view.text = 'What hath Matz wrought!'
    toast 'Flipped a bit via butterfly'
    @notification_manager = context.getSystemService(Context::NOTIFICATION_SERVICE)
    icon                  = $package.R::drawable::ic_launcher
    tickerText            = "In the right place!"
    notify_when           = java.lang.System.currentTimeMillis
    notification          = Notification.new(icon, tickerText, notify_when)
    contentTitle          = "You are in the right place!"
    contentText           = "You are connected to foobar."
    notificationIntent    = Intent.new(context, $package.TimerActivity.java_class)
    contentIntent         = PendingIntent.getActivity(context, 0, notificationIntent, 0)
    notification.setLatestEventInfo(context, contentTitle, contentText, contentIntent)

    @notification_manager.notify(HELLO_ID, notification)

  end

end
