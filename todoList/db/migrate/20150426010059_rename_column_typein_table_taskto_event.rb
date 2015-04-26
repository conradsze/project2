class RenameColumnTypeinTableTasktoEvent < ActiveRecord::Migration
  def change
  	rename_column :tasks, :type, :event_type
  end
end
