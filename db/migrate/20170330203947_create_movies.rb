class CreateMovies < ActiveRecord::Migration[5.0]
  def change
    create_table :movies do |t|
      t.string :片名
      t.text :简介

      t.timestamps
    end
  end
end
