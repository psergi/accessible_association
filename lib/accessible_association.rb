module AccessibleAssociation
  def accessible_association(name)
    setter_method = "#{name}="
    original_method = instance_method(setter_method)

    define_method(setter_method) do |params|
      if params.is_a? Hash  
        send("build_#{name}", params) 
      else
        bound_method = original_method.bind(self)
        bound_method.call(params)
      end
    end
  end
end

