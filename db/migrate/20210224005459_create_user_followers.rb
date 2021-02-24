class CreateUserFollowers < ActiveRecord::Migration[6.0]
  def change
    create_table :user_followers do |t|
      t.references :user, foreign_key: true
      t.references :follower, foreign_key: { to_table: :users }
      t.timestamps
    end

    add_index :user_followers, [:user_id, :follower_id], unique: true
  end
end
