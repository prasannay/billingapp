module ApplicationHelper
	def calander_tag(object, method, value = nil, label = nil, in_table = false, options = {:dateStatusFunc => "dateStatusHandler", :size => "12", :onclick_of_text_field => false, :onkey_press => "handleEnter", :placeholder => "", :minDate => "", :maxDate => "", :class_name=> "", :min_date_to=> "", :max_date_to=> "", :required=> "", :clear=> false, :width=> "", :number_of_months => "" })
    onchange = options.delete(:onchange)
    dateStatusFunc = options.delete(:dateStatusFunc)
    class_name = options.delete(:class_name)
    number_of_months = options.delete(:number_of_months)
    nom = number_of_months.present? ? number_of_months : 2
    size = options.delete(:size)
    width = options.delete(:width)
    required = options.delete(:required)
    is_clear = options.delete(:clear)
    onclose = options.delete(:onclose)
    oncloseFunc = onclose.present? ?  ",onClose: function(){#{onclose}}" : ""
    width = "73px" if width.blank?
    clearDate = is_clear ? ",closeText: 'Clear',closeAction: 'clear'" : ""
    onkey_press = options.delete(:onkey_press)
    calender_date = 'dd/mm/yy'
    calendar_date_format = 'dd/mm/yy'
    dateStatusFunc = "dateStatusHandler" if dateStatusFunc.blank?
    onchange = "onchange = \"#{onchange}\"" if onchange
    class_name = "class = \"#{class_name}\"" if class_name
    required = "required='required'" if required.present?
    onkey_press_fn = "onkeypress=\"return handleEnter(this, event);\"" if !onkey_press.blank?
    st_year = options.delete(:start_year)
    en_year = options.delete(:end_year)
    min_date_to = options.delete(:min_date_to)
    max_date_to = options.delete(:max_date_to)
    start_year = (st_year.nil?) ? (Billing.get_current_date - 2.year).year : st_year
    end_year =  (en_year.nil?) ? (Billing.get_current_date + 1.year).year : en_year
    tab_index = ""
    tab_index = "tabindex=#{options[:tabindex]}" if !options[:tabindex].blank?
    cal = ""
    cal += "<span><label for=\"#{object}_#{method}\">#{label}</label>" unless label.blank?
    # cal += "<input name=\"#{object}[#{method}]\" id=\"#{object}_#{method}\" value=\"#{ format_date value }\" size=\"#{size}\" type=\"text\"  #{onchange}#{onkey_press_fn}></div> TODO31"
    # return cal.html_safe
    onSelectEvent = ""
    if min_date_to.present?
      onSelectEvent += ", onSelect: function( selectedDate ) {" +
        onSelectEvent += "var instance = $( this ).data( 'datepicker' ),"
        onSelectEvent += "date = $.datepicker.parseDate( instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings );"
        onSelectEvent += "$('##{min_date_to}').datepicker( 'option', 'minDate', date );}"
    end

    if max_date_to.present?
      onSelectEvent += ", onSelect: function( selectedDate ) {" +
        onSelectEvent += "var instance = $( this ).data( 'datepicker' ),"
        onSelectEvent += "date = $.datepicker.parseDate( instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings );"
        onSelectEvent += "$('##{max_date_to}').datepicker( 'option', 'maxDate', date );}"
    end

    placeholder = options.delete(:placeholder)
    minDate = options.delete(:minDate)
    maxDate = options.delete(:maxDate)
    onclick_of_text_field = options.delete(:onclick_of_text_field)
    if onclick_of_text_field
      if in_table
      cal += "<div id=\"#{object}_#{method}-img\" class=\"input-group\"><input name=\"#{object}[#{method}]\" readonly=\"1\" id=\"#{object}_#{method}\" value=\"#{ format_date value }\" placeholder=\"#{placeholder}\" size=\"#{size}\" style=\"width:#{width}\"  type=\"text\" #{tab_index} #{onchange}#{onkey_press_fn} #{class_name} #{required}>" +
      "</div>" +
      "<script type=\"text/javascript\"> (function($) { $('##{object}_#{method}').datepicker({ showOn: 'both', changeMonth: true, changeYear: true, yearRange: '#{start_year}:#{end_year}', minDate: '#{minDate}', maxDate: '#{maxDate}', buttonImage: \"#{image_path('calendar.gif')}\", dateFormat: '#{calendar_date_format}', numberOfMonths: #{nom}, firstDay: 1, buttonImageOnly: true, showAnim: 'fold', showButtonPanel: true #{onSelectEvent} #{clearDate} #{oncloseFunc}});})(jQuery); </script> "
    else
      cal += "<span id=\"#{object}_#{method}-img\" class=\"input-group\"><input name=\"#{object}[#{method}]\" readonly=\"1\" id=\"#{object}_#{method}\" value=\"#{ format_date value }\" placeholder=\"#{placeholder}\" size=\"#{size}\" style=\"width:#{width}\"  type=\"text\" #{tab_index} #{onchange}#{onkey_press_fn} #{class_name} #{required}>" +
      "</span>" +
      "<script type=\"text/javascript\"> (function($) { $('##{object}_#{method}').datepicker({ showOn: 'both', changeMonth: true, changeYear: true, yearRange: '#{start_year}:#{end_year}', minDate: '#{minDate}', maxDate: '#{maxDate}', buttonImage: \"#{image_path('calendar.gif')}\", dateFormat: '#{calendar_date_format}', numberOfMonths: #{nom}, firstDay: 1, buttonImageOnly: true, showAnim: 'fold', showButtonPanel: true #{onSelectEvent} #{clearDate} #{oncloseFunc}});})(jQuery); </script> "
    end

    else
      if (in_table)
        cal += "<div  class=\"input-group\"><input name=\"#{object}[#{method}]\" readonly=\"1\" id=\"#{object}_#{method}\" value=\"#{ format_date value }\" placeholder=\"#{placeholder}\" size=\"#{size}\" style=\"width:#{width}\"  type=\"text\" #{tab_index}  #{onchange}#{onkey_press_fn} #{class_name} #{required}>"
        "</div>"+
        "<script type=\"text/javascript\"> (function($) { $('##{object}_#{method}').datepicker({ showOn: 'both', changeMonth: true, changeYear: true, yearRange: '#{start_year}:#{end_year}', minDate: '#{minDate}', maxDate: '#{maxDate}', buttonImage: \"#{image_path('calendar.gif')}\", dateFormat: '#{calendar_date_format}', numberOfMonths: #{nom}, firstDay: 1, buttonImageOnly: true, showAnim: 'fold', showButtonPanel: true #{onSelectEvent} #{clearDate} #{oncloseFunc}});})(jQuery); </script> "
      else
        cal += "<div  class=\"input-group\"><input name=\"#{object}[#{method}]\" readonly=\"1\" id=\"#{object}_#{method}\" value=\"#{ format_date value }\" placeholder=\"#{placeholder}\" size=\"#{size}\" style=\"width:#{width}\"  type=\"text\"  #{tab_index} #{onchange}#{onkey_press_fn} #{class_name} #{required}>" +
        "</div>" +
        "<script type=\"text/javascript\"> (function($) { $('##{object}_#{method}').datepicker({ showOn: 'both', changeMonth: true, changeYear: true, yearRange: '#{start_year}:#{end_year}', minDate: '#{minDate}', maxDate: '#{maxDate}', buttonImage: \"#{image_path('calendar.gif')}\", dateFormat: '#{calendar_date_format}', numberOfMonths: #{nom}, firstDay: 1, buttonImageOnly: true, showAnim: 'fold', showButtonPanel: true #{onSelectEvent} #{clearDate} #{oncloseFunc}});})(jQuery);  </script>"
      end
    end
    cal += "</span>"
    cal.html_safe
  end

  def format_date(date)
	  if (date.class == Date)
	    date_format = 'dd/mm/yy'
	    date.strftime(date_format) # if (!date.nil? && date.to_s.length > 0)
	  else
	    ""
	  end
  end
end
