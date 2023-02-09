class CreateAttendees < ActiveRecord::Migration[5.2]
  def change
    create_table :attendees do |t|
      t.references :conference, null: false, index: true
      t.string :full_name, null: false
      t.string :email, null: false
      t.boolean :requires_certification, null: false, default: false
      t.timestamps
    end
  end
end
