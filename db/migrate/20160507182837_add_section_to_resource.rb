class AddSectionToResource < ActiveRecord::Migration
  def change
    add_reference :resources, :section, index: true, foreign_key: true
  end
end
