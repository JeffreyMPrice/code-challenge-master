# frozen_string_literal: true

class ErrorsController < ApplicationController
  def not_implemented
    raise NotImplementedError
  end

  def internal
    raise InternalServerError
  end
end
