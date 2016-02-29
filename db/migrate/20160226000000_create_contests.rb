# This migration comes from spree_faq (originally 20150921145741)
class CreateContests < ActiveRecord::Migration
  def up
    create_table :spree_contests do |t|
      t.string  :name
      t.string  :slug
      t.date :date_begin, null: false
      t.date :date_end, null: false
      t.text  :description
      t.timestamps null: false
    end
    create_table :spree_participations do |t|
      t.string      :name
      t.string      :email
      t.string      :zip
      t.boolean        :subscribed
      t.references  :contest
      t.timestamps  null: false
    end
  end

  def down
    drop_table :spree_contests
    drop_table :spree_participations
  end
end
