class ErrorsController < ApplicationController
  def not_implemented
    raise NotImplementedError.new
  end

  def internal
    raise InternalServerError.new
  end
end
