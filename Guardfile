# A sample Guardfile
# More info at https://github.com/guard/guard#readme

#guard 'spork', :cucumber => false, :rspec_env => { 'RAILS_ENV' => 'test' } do
  #watch('config/application.rb')
  #watch('config/environment.rb')
  #watch(%r{^config/environments/.+\.rb$})
  #watch(%r{^config/initializers/.+\.rb$})
  #watch('Gemfile')
  #watch('Gemfile.lock')
  #watch('spec/spec_helper.rb')
  #watch(%r{^spec/support/.+\.rb$})
  #watch(%r{^vendor/gems/manuable-entities/app/models/.+\.rb$})
#end

#guard 'rspec', :cli => "--drb", :version => 2 do
  #watch(%r{^spec/.+_spec\.rb$})
  #watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  #watch('spec/spec_helper.rb')  { "spec" }

   #Rails example
  #watch(%r{^spec/.+_spec\.rb$})
  #watch(%r{^spec/models\.rb$})                        { "vendor/engines/manuable-entities/app/models/*.rb"}
  #watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  #watch(%r{^app/(.*)(\.erb|\.haml)$})                 { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
  #watch(%r{^lib/(.+)\.rb$})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
  #watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb", "spec/requests/#{m[1]}_spec.rb"] }
  #watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
  #watch('spec/spec_helper.rb')                        { "spec" }
  #watch('config/routes.rb')                           { "spec/routing" }
  #watch('app/controllers/application_controller.rb')  { "spec/controllers" }
   #Capybara request specs
  #watch(%r{^app/views/(.+)/.*\.(erb|haml)$})          { |m| ["spec/requests/#{m[1]}_spec.rb", "vendor/engines/manuable-entities/app/models/*.rb"] }

#end


guard 'livereload' do
  watch(%r{app/views/.+\.(erb|haml|slim)$})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{public/.+\.(css|js|html)})
  watch(%r{config/locales/.+\.yml})
  # Rails Assets Pipeline
  watch(%r{(app|vendor)(/assets/\w+/(.+\.(css|js|html))).*}) { |m| "/assets/#{m[3]}" }
end
