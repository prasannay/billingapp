class BillingsController < ApplicationController
  before_filter :update_table_config
  active_scaffold :"billing" do |conf|
	conf.columns = [:event_id,:location,:total_amount]
	conf.list.columns.add :billed_by, :date
	conf.show.columns.add :billed_by, :date
	conf.list.per_page = 10
	conf.delete.link.confirm = "Are you sure you want to delete ? "
  end

  def update_table_config
  	  active_scaffold_config.columns[:event_id].label = "Event Type"
  end
end
