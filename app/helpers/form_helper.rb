module FormHelper
	def create_field_with_errors form,title, message, errors, options = {}
		
		if errors.any?
			if !errors[title.to_sym].empty?
				options.update(group_classes: 'error')
				message = errors[title.to_sym].join(" and ")  if !errors[title.to_sym].empty?
		else
			options.update(group_classes: 'success')
			end
		end
		create_field form,title, message, options
	end



	#If no field_type given, detects field by first name of title
	#Example title: password => will use password_field_tag
	def create_field form, title, message, options = {}
		
		options[:field_type] = (title.split('_')[0].downcase + '_field').to_sym if !options[:field_type] 
		# debugger
		options[:field_type] = :text_field 	if !form.respond_to?(options[:field_type]) #defaults to text field
		# debugger
		name = title.gsub('_',' ').capitalize
		
		label_content = label_tag(title, name, {class: 'control-label'})

		controls_content = 	form.send(options[:field_type],  title,
																			"data-content" => message, 
																			"data-original-title" => name) 

		create_control_div label_content, controls_content, options[:group_classes]
	end

	def create_control_div label_content , controls_content = nil, group_classes = ""
		render partial: "shared/field_forms", locals:  { label_content: label_content,
																										controls_content: controls_content,
																										group_classes: group_classes}
		end 
	end