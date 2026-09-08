# dont try serving JSON pages even if client requested this format
# prevents cms crashes with MissingTemplate
Spina::PagesController.class_eval do
  before_action do
    head :not_acceptable unless request.format.html?
  end
end
