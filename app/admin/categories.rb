ActiveAdmin.register Category do
	scope :masters, :default => true do |categories|
		categories.masters
	end
	scope :all

	index do
		column :name
		column :value
		column :parent
		default_actions	
	end

	show :title => :name do
		attributes_table do
			row :name
			row :value
			row("Number of Child Elements")	{|category| category.childs.count}
		end
		panel "Sub Elements" do
			table_for(category.childs) do
				column("name", :sortable => :name)
				column("value")
			end
		end
	end

	form do |f|
		f.inputs "Details" do
			f.input :name
			f.input :value
			f.input :parent
		end
		f.buttons
	end 
end
