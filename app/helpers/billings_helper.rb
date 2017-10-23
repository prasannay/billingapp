module BillingsHelper
def date_column(record, column)
	"<span style='float:left;'>#{record.date.strftime("%d/%b/%Y")}</span>".html_safe
end
def total_amount_column(record, column)
	"<span style='float:left;'>#{record.total_amount}</span>".html_safe
end
def event_id_form_column(record, input_name)
  "#{select(:record, :event_id, [['Lunch',1],['Dinner',2],['Snack',3]])}".html_safe
end
def total_amount_form_column(record,input_name)  
  "#{text_field(:record, :total_amount, :onkeypress => 'return onlyNumerals(event,this.value)')}".html_safe
end
def event_id_column(record, column)
	if(record.event_id == 1)
		"<span style='float:left;'>Lunch</span>".html_safe
	elsif(record.event_id == 2)
		"<span style='float:left;'>Dinner</span>".html_safe
	else
		"<span style='float:left;'>Snacks</span>".html_safe
	end
end
def billed_by_column(record, column)
	user = User.where(:id => record.billed_by).last
	bg_color = (record.billed_by == current_user.id)? 'yellow' : ''
	"<span style='float:left;background-color:#{bg_color}'>#{user.email}</span>".html_safe
end
end