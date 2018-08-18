class TestimonialsEngine::Admin::TestimonialsController < Spree::Admin::BaseController

	def index
		@testimonials = Testimonial.
			order("created_at DESC").
			page(params[:page]).
			per(Spree::Config[:admin_products_per_page])
	end

	def new
		@testimonial = Testimonial.new

		respond_to do |format|
		    format.html  # new.html.erb
		    #format.json  { render :json => @testimonial }
		end
	end

	def create
		@testimonial = Testimonial.new(testimonial_params)

		respond_to do |format|
			if @testimonial.save
				format.html  { redirect_to(admin_testimonials_url,
					:notice => 'Testimonial was successfully created.') }
				#format.json  { render :json => @testimonial,
				#	:status => :created, :location => @testimonial }
			else
				format.html  { render :action => "new" }
				#format.json  { render :json => @testimonial.errors,
				#	:status => :unprocessable_entity }
			end
  		end
	end

	def edit
		@testimonial = Testimonial.find(params[:id])

		respond_to do |format|
		    format.html  # new.html.erb
		end
	end

	def update
		@testimonial = Testimonial.find(params[:id])

		respond_to do |format|
			if @testimonial.update_attributes(testimonial_params)
				format.html  { redirect_to(admin_testimonials_url,
					:notice => 'Testimonial was successfully updated.') }
				#format.json  { head :no_content }
			else
				format.html  { render :action => "edit" }
				#format.json  { render :json => @testimonial.errors,
				#	:status => :unprocessable_entity }
			end
		end
	end

	def destroy
		@testimonial = Testimonial.find(params[:id])

		respond_to do |format|
			if @testimonial.destroy
				format.html { redirect_to admin_testimonials_url, :notice => "Testimonial was successfully deleted." }
			else
				format.html { redirect_to admin_testimonial_url(@testimonial), :error => "Testimonial was not deleted." }
			end
		end
	end

	private
	def testimonial_params
		params.require(:testimonial).permit(:enabled, :name, :body)
	end
end
