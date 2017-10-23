class Billing < ApplicationRecord
  before_validation :validate_duplicate_entry , :on => :create
  before_save :save_billing_dtls
  # belongs_to :billed_by, :class_name => "User", :foreign_key => "billed_by"
  def Billing.get_current_date
    t = Time.zone.now
    Date.new(t.year, t.month, t.day)
  end

  def save_billing_dtls
  	self.billed_by = current_user.id
  	self.date = Date.today
  end
  def validate_duplicate_entry
  	 errors[:base] << "Amount Can't be blank" if self.total_amount.blank?
  	 errors[:base] << "Already Entry is present for this Event" if Billing.exists?(:event_id => self.event_id, :billed_by => current_user.id, :date => Date.today)
  end

  def Billing.final_computed_amount
  	billing_hash = Billing.all.group_by{|b| [b.event_id, b.date]} if Billing.exists?
		user_wise_hash = Hash.new
		date_arr = Array.new
		event_arr = Array.new
  	if billing_hash.present?
  		billing_hash.each_pair do |k,v|
  			per_head_amt = ((v.sum(&:total_amount))/v.count)
  			v.each do |evt|
	  			min_paid = 0.0
	  			max_paid = 0.0
	  			min_paid = (per_head_amt.to_f - evt.total_amount.to_f) if (evt.total_amount.to_f <= per_head_amt) 
	  			max_paid = (evt.total_amount.to_f - per_head_amt.to_f) if (evt.total_amount.to_f > per_head_amt) 
	  			user_wise_hash["#{evt.billed_by}-#{evt.date}-#{evt.event_id}"] = [min_paid, max_paid]
	  			date_arr << evt.date
	  			event_arr << evt.event_id
	  		end
  		end
  	end
  	[date_arr.uniq, user_wise_hash, event_arr.uniq]
  end
  def Billing.get_event_name(evt)
		if(evt == 1)
			evt_name = 'Lunch'
		elsif(evt == 2)
			evt_name = 'Dinner'
		else
			evt_name = 'Snacks'
		end
	end
end
