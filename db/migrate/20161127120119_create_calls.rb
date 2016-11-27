class CreateCalls < ActiveRecord::Migration
  def change
    create_table :calls do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :from
      t.string :to
      t.string :voicemail_url
      t.string :service
      t.string :service_call_id
      t.string :status

      t.timestamps null: false
    end

    add_index :calls, :service_call_id
  end
end
