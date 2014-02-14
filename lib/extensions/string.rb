class String

  def vcr_path(example, spec_name)
    self.scan(/^(.*?)::[#a-z]/) do |class_names|
      class_name = class_names.flatten.first

      if class_name.nil?
        @path = example.class.name.prep
      else
        @path = example.class.name.gsub(class_name, "").prep.unshift(class_name)
      end
    end

    @path.push(spec_name).join("/") unless @path.nil?
  end

  def prep
    split("::").map {|e| e.sub(/[^\w]*$/, "")}.reject(&:empty?) - ["vcr"]
  end

end
