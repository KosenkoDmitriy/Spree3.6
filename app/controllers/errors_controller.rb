class ErrorsController < Spree::BaseController

  def error_404
    self.title = "404"
    respond_to do |format|
      format.html { render status: 404 }
      format.any  { render text: "404 Not Found", status: 404, layout: false }
    end
  end

  def error_422
    respond_to do |format|
      format.html { render status: 422 }
      format.any  { render text: "422 Unprocessable Entity", status: 422 }
    end
  end

  def error_500
    render file: "#{Rails.root}/public/500.html", layout: false, status: 500
    # respond_to do |format|
    #   format.html { render status: 500 }
    #   format.any  { render text: "500 Unprocessable Entity", status: 422 }
    # end
  end
end
