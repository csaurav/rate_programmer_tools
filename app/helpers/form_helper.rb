module FormHelper
	def bootstrap_form_for(model,options={},&block)
		options[:builder] = BootstrapFormBuilder
		options[:html] ||= {class: 'form-horizontal'}
		form_for model, options, &block
	end


	class BootstrapFormBuilder < ActionView::Helpers::FormBuilder
		[:text,:password,:email].each do |field_type|
			method = "def #{field_type}_field type,message, options = {}
									options['data-content'] = message
									options['data-original-title'] = type.to_s.upcase.gsub('_',' ')
									name = type.to_s.capitalize.gsub('_',' ') if type
									bootstrap_div name, type do
										super type, options
									end
								end"
			class_eval method
		end
		def submit value, options ={}
		bootstrap_div nil do
			super value,options
		end
		end
		def bootstrap_div label = nil, type = nil, &block
			"<div class='control-group#{' error' if type && @object && !@object.errors[type].empty?}'>
			<label class='control-label'>#{label}</label>
			<div class='controls'>#{yield if block}</div></div>"
		end
	end
end