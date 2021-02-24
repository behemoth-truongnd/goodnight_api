class CreateTimeTracks < ActiveRecord::Migration[6.0]
  def change
    create_table :time_tracks do |t|
      t.references :user, foreign_key: true
      t.datetime :sleep_at
      t.datetime :wakeup_at
      t.timestamps
    end
  end
end
