ActiveAdmin.register Product do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :price_in_cent
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :price_in_cent]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  permit_params :list, :of, :attributes, :on, :model, :name, :price_in_cent, :image_filename_1, :image_filename_2, :image_filename_3, :image_filename_4, :image_filename_main, :string, :description, :donation_amount, :delivery
  json_editor
end
