module FormHelper
  def link_to_submit(*args, &block)
    link_to_function (block_given? ? capture(&block) : args[0]), "$(this).closest('form').submit()", args.extract_options!
  end
  def include_javascript(*files)
    content_for(:head) { javascript_include_tag(*files) } 
  end
  def bootstrap_class_for flash_type
    case flash_type
      when :success
        "alert-success"
      when :error
        "alert-error"
      when :alert
        "alert-block"
      when :notice
        "alert-info"
      else
        flash_type.to_s
    end
  end

	
	def bootstrap_form_for(model,options={},&block)
		options[:builder] = BootstrapFormBuilder
		options[:html] ||= {class: 'form-horizontal'}
		form_for model, options, &block
	end


	class BootstrapFormBuilder < ActionView::Helpers::FormBuilder
		[:text_field,:password_field,:email_field,:text_area].each do |field_type|
			method = "def #{field_type} type,message, options = {}
									name = type.to_s.capitalize.gsub('_',' ') if type
									if @object.errors[type].any?
										options['data-content'] = name.to_s + ' ' + @object.errors[type].join('<br>'+name.to_s+' ') 
									else
										options['data-content'] = message if message
									end
									options['data-original-title'] = type.to_s.capitalize.gsub('_',' ') if message
									bootstrap_div name, type do
										super type, options
									end
								end"
			class_eval method
		end
		def submit value, options ={}
			options[:class] ||= 'btn btn-success'
			bootstrap_div nil do
				super value,options
			end
		end
		def bootstrap_div label = nil, type = nil, &block
			"<div class='control-group#{' error' if type && @object && @object.errors[type].any?}'>
			<label class='control-label'>#{label}</label>
			<div class='controls'>#{yield if block}</div></div>"
		end
	end
end