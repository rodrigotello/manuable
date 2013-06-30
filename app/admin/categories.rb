ActiveAdmin.register Category do
  menu priority: 3
  # scope :masters, :default => true do |categories|
  #   categories.masters
  # end
  # scope :all

  # index do
  #   column(:name, :sortable => :name) {|category| link_to category.name, admin_category_path(category)}
  #   column(:value, :sortable => :value){|category| link_to category.value, admin_category_path(category)}
  #   default_actions
  # end

  # show :title => :name do
  #   attributes_table do
  #     row :name
  #     row :value
  #     row :parent
  #     row("Number of Child Elements") {|category| category.childs.count}
  #   end
  #   panel "Actions" do
  #     render "child_actions"
  #   end
  #   panel "Sub Elements" do
  #     table_for(category.childs) do
  #       column(:name, :sortable => :name) {|category| link_to category.name, admin_category_path(category)}
  #       column(:value, :sortable => :value){|category| link_to category.value, admin_category_path(category)}
  #       column(""){|category| link_to("Editar",edit_admin_category_path(category))}
  #       column(""){|category| link_to("Eliminar", admin_category_path(category),:confirm => "Esta seguro de que quiere eliminar esto?", :method => :delete)}
  #     end
  #   end
  # end

  # form do |f|
  #   f.inputs "Details" do
  #     f.input :name
  #     f.input :value
  #     f.input :parent
  #   end
  #   f.buttons
  # end

  # controller do
  #   def new
  #     if params[:id].nil?
  #       @category = Category.new
  #     else
  #       @category = Category.find(params[:id])
  #       @category = @category.childs.build
  #     end
  #   end
  # end
end
