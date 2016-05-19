class AddSelectedWinnerToContest < ActiveRecord::Migration
  def up
    add_reference :spree_contests, :selected_winner, index: true
  end

  def down
    remove_column :spree_contests, :selected_winner_id
  end
end
