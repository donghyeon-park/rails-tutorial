module Visible
  extend ActiveSupport::Concern

  VALID_STATUSES = %w[visible hidden]

  included do
    validates :status, inclusion: { in: VALID_STATUSES }
  end

  def hidden?
    status == "hidden"
  end
end
