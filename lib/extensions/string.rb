class String
  def prep
    split("::").map {|e| e.sub(/[^\w]*$/, "")}.reject(&:empty?) - ["vcr"]
  end
end
