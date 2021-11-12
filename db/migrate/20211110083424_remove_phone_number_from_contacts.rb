class RemovePhoneNumberFromContacts < ActiveRecord::Migration[5.2]
  def change
    remove_column :contacts, :phone_number, :string
  end
end
