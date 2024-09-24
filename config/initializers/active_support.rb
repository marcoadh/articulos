# Be sure to restart your server when you modify this file.

class ActiveSupport::TimeWithZone
  def fmt_long
    I18n.l(self, format: :long)
  end
end
