class CreateSongInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :song_infos do |t|
      t.string :search_by
      t.string :website
      t.string :status
      t.string :web_template
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
