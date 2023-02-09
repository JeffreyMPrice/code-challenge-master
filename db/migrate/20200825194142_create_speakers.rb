class CreateSpeakers < ActiveRecord::Migration[5.2]
  def change
    create_table :speakers do |t|
      t.references :conference, null: false, index: true
      t.string :full_name, null: false
      t.string :email, null: false
      t.string :company
      t.string :job_title
      t.timestamps
    end
  end
end
