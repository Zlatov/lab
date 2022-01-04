class Market::OfferPresenter

  attr_reader :model

  def initialize(model)
    @model = model
  end

  def status
    self.class.status model.status
  end
  def self.status sym_status
    sym_status = sym_status.to_sym if sym_status.is_a?(String)
    string = case sym_status
    when :created
      <<-STR
        <i
          title="#{Market::Model::Offer.human_enum_name :status, sym_status}"
          class="fa fa-circle color lighter_gray"
        ></i>
      STR
    when :confirmed
      <<-STR
        <i
          title="#{Market::Model::Offer.human_enum_name :status, sym_status}"
          class="fa fa-circle color lighter_primary"
        ></i>
      STR
    else
      ''
    end
    html = string.html_safe
    html
  end
end
