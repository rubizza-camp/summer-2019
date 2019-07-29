module LocaleChooser
  def locale!
    save_context :change_locale
    respond_with :message, text: I18n.t(:locale_choose)
  end

  def ru!
    I18n.locale = :ru
    respond_with :message, text: I18n.t(:new_locale)
  end

  def en!
    I18n.locale = :en
    respond_with :message, text: I18n.t(:new_locale)
  end

  def ru_swear!
    I18n.locale = :ru_sw
    respond_with :message, text: I18n.t(:new_locale)
  end
end
